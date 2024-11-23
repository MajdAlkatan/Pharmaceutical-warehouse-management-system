<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Bill extends Model
{
    use HasFactory;
    protected $fillable= [
        'state',
        'pay',
        'user_id',
        'total'
    ];
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
    public function Orders(): HasMany
    {
        return $this->hasMany(Oreder::class );
    }
}
