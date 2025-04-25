<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserVerification extends Model
{
    protected $fillable = [
        'user_id', 'type', 'verification_data',
        'is_verified', 'verified_at'
    ];

    protected $casts = [
        'verification_data' => 'array',
        'is_verified'      => 'boolean',
        'verified_at'      => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
