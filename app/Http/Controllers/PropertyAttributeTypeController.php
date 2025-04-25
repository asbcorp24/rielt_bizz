<?php
namespace App\Http\Controllers\Api;

use App\Models\PropertyAttributeType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PropertyAttributeTypeController extends Controller
{
    public function index()
    {
        return PropertyAttributeType::all();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|in:string,number',
            'min' => 'nullable|numeric',
            'max' => 'nullable|numeric',
        ]);

        return PropertyAttributeType::create($data);
    }

    public function show(PropertyAttributeType $propertyAttributeType)
    {
        return $propertyAttributeType;
    }

    public function destroy(PropertyAttributeType $propertyAttributeType)
    {
        $propertyAttributeType->delete();
        return response()->json(['message' => 'Удалено']);
    }
}
