<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PropertyAttributeType extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'type', 'min', 'max'
    ];

}
