<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Property extends Model
{
    protected $fillable = [
        'owner_id', 'address', 'city', 'rooms', 'area_m2',
        'latitude', 'longitude', 'building_type', 'floor',
        'total_floors', 'is_furnished', 'has_internet', 'can_have_pets'
    ];
    use HasFactory;
}
