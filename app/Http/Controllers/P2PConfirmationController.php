<?php
namespace App\Http\Controllers\Api;

use App\Models\P2PConfirmation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class P2PConfirmationController extends Controller
{
    public function index()
    {
        return P2PConfirmation::where('sender_id', auth()->id())
            ->orWhere('receiver_id', auth()->id())
            ->get();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'receiver_id' => 'required|exists:users,id',
            'related_property_id' => 'nullable|exists:properties,id',
            'related_contract_id' => 'nullable|exists:contracts,id',
            'action_type' => 'required|in:handover_acceptance,deposit_paid,utility_paid,damage_report,viewing_attended,contract_termination_notice',
            'description' => 'nullable|string'
        ]);

        $data['sender_id'] = auth()->id();
        $confirmation = P2PConfirmation::create($data);

        return response()->json($confirmation, 201);
    }

    public function update(Request $request, P2PConfirmation $p2pConfirmation)
    {
        if ($p2pConfirmation->receiver_id !== auth()->id()) {
            abort(403);
        }

        $p2pConfirmation->update([
            'is_confirmed' => true,
            'signed_by_receiver' => true,
            'confirmed_at' => now()
        ]);

        return response()->json($p2pConfirmation);
    }
}
