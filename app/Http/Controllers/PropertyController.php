<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Api\AuthController;
use App\Models\Property;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class PropertyController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Property::where('owner_id', Auth::id())->get();
    }

    public function show(Property $property)
    {
        // Защищаем, чтобы нельзя было смотреть чужую недвижимость
        if ($property->owner_id !== Auth::id()) {
            abort(403, 'Access denied');
        }

        return response()->json($property);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'address' => 'required|string',
            'city' => 'required|string',
            'rooms' => 'required|integer|min:1',
            'area_m2' => 'required|numeric|min:1',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'building_type' => 'nullable|in:panel,brick,monolith,wood,other',
            'floor' => 'nullable|integer',
            'total_floors' => 'nullable|integer',
            'is_furnished' => 'boolean',
            'has_internet' => 'boolean',
            'can_have_pets' => 'boolean',
        ]);

        $data['owner_id'] = $request->user()->id;

        $property = Property::create($data);

        return response()->json($property, 201);
    }



    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Property  $property
     * @return \Illuminate\Http\Response
     */
    public function edit(Property $property)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Property  $property
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Property $property)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Property  $property
     * @return \Illuminate\Http\Response
     */
    public function destroy(Property $property)
    {
        //
    }
}
