<?php
namespace App\Http\Controllers\Api;

use App\Models\Property;
use App\Models\PropertyAttribute;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PropertyAttributeController extends Controller
{
    public function index($propertyId)
    {
        return PropertyAttribute::where('property_id', $propertyId)->get();
    }

    public function store(Request $request, $propertyId)
    {
        $property = Property::findOrFail($propertyId);
        if ($property->owner_id !== auth()->id()) {
            abort(403);
        }

        $data = $request->validate([
            'attribute_type_id' => 'required|exists:property_attribute_types,id',
            'value_string' => 'nullable|string',
            'value_number' => 'nullable|numeric'
        ]);

        $data['property_id'] = $propertyId;
        $attribute = PropertyAttribute::create($data);

        return response()->json($attribute, 201);
    }
}
