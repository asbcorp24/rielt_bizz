<?php
namespace App\Http\Controllers\Api;

use App\Models\Contract;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ContractController extends Controller
{
    public function index()
    {
        return Contract::where('landlord_id', auth()->id())
            ->orWhere('tenant_id', auth()->id())
            ->get();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'landlord_id' => 'required|exists:users,id',
            'tenant_id' => 'required|exists:users,id',
            'property_id' => 'required|exists:properties,id',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date',
            'contract_body' => 'required|string',
            'deposit_amount' => 'required|numeric',
            'monthly_rent' => 'required|numeric',
            'payment_day' => 'required|integer|min:1|max:31',
            'payment_period' => 'required|in:month,quarter,year',
            'is_auto_renewal' => 'boolean'
        ]);

        $data['created_by'] = auth()->id();
        $contract = Contract::create($data);

        return response()->json($contract, 201);
    }

    public function show(Contract $contract)
    {
        if (!in_array(auth()->id(), [$contract->landlord_id, $contract->tenant_id])) {
            abort(403, 'Access denied');
        }

        return $contract;
    }

    public function update(Request $request, Contract $contract)
    {
        if (auth()->id() !== $contract->landlord_id && auth()->id() !== $contract->tenant_id) {
            abort(403);
        }

        $contract->update($request->only([
            'status', 'termination_reason',
            'is_signed_landlord', 'is_signed_tenant', 'signed_at'
        ]));

        return response()->json($contract);
    }
}
