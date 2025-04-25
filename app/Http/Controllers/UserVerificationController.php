<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\UserVerification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Http;

class UserVerificationController extends Controller
{
    public function index()
    {
        return auth()->user()->verifications()->get();
    }

    public function store(Request $request)
    {
        $type = $request->input('type');
        switch ($type) {
            case 'passport':
                return $this->verifyPassport($request);
            case 'gosuslugi':
                return $this->verifyViaGosuslugi($request);
            case 'property':
                return $this->verifyPropertyOwnership($request);
            default:
                return response()->json(['error' => 'Invalid verification type'], 422);
        }
    }

    protected function verifyPassport(Request $request)
    {
        $data = $request->validate([
            'file' => 'required|file|mimes:jpg,png,pdf|max:5120',
        ]);

        // Сохраняем скан
        $path = $request->file('file')->store('verifications/passport', 'public');

        // Вызов внешнего API МВД (stub)
        $response = Http::post('https://api.mvd.example.com/passport/verify', [
            'file_path' => Storage::disk('public')->url($path),
        ]);

        $status = $response->successful() && $response->json('valid') ? true : false;

        $verification = UserVerification::create([
            'user_id'           => auth()->id(),
            'type'              => 'passport',
            'verification_data' => json_encode([
                'file_path' => $path,
                'mvd_response' => $response->json(),
            ]),
            'is_verified'       => $status,
            'verified_at'       => $status ? now() : null,
        ]);

        return response()->json($verification, $status ? 201 : 422);
    }

    protected function verifyViaGosuslugi(Request $request)
    {
        // Ожидаем callback со всеми данными ЕСИА
        $data = $request->input('gosuslugi_data'); // массив полученных полей из ЕСИА

        // Проверяем, что данные пришли и содержат необходимые поля
        if (!isset($data['snils'], $data['fullName'])) {
            return response()->json(['error' => 'Invalid Gosuslugi data'], 422);
        }

        $verification = UserVerification::create([
            'user_id'           => auth()->id(),
            'type'              => 'gosuslugi',
            'verification_data' => json_encode($data),
            'is_verified'       => true,
            'verified_at'       => now(),
        ]);

        return response()->json($verification, 201);
    }

    protected function verifyPropertyOwnership(Request $request)
    {
        // Вариант A: загрузка выписки ЕГРН
        if ($request->hasFile('egrn_file')) {
            $path = $request->file('egrn_file')->store('verifications/property', 'public');
            $doc = ['egrn_file' => $path];
        } else {
            // Вариант B: запрос ЕГРН через Госуслуги по адресу/кад. номеру
            $addr = $request->validate([
                'address' => 'required_without:cadaster_number|string',
                'cadaster_number' => 'required_without:address|string',
            ]);

            // stub API call
            $response = Http::get('https://api.gosuslugi.ru/egrn', $addr);
            $doc = $response->json();
        }

        $status = isset($doc['owner_snils']) && $doc['owner_snils'] === auth()->user()->snils;

        $verification = UserVerification::create([
            'user_id'           => auth()->id(),
            'type'              => 'property',
            'verification_data' => json_encode($doc),
            'is_verified'       => $status,
            'verified_at'       => $status ? now() : null,
        ]);

        return response()->json($verification, $status ? 201 : 422);
    }
}
