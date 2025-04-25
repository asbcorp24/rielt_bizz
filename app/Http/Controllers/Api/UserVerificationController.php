<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserVerificationController extends Controller
{
    public function index()
    {
        return auth()->user()->verifications;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'type' => 'required|in:passport,gosuslugi,property',
            'verification_data' => 'nullable|array'
        ]);

        $data['user_id'] = auth()->id();
        $data['verification_data'] = json_encode($data['verification_data']);
        $data['is_verified'] = false;

        $verification = \App\Models\UserVerification::create($data);

        return response()->json($verification, 201);
    }

}
