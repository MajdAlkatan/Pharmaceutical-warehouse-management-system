<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Medicin extends Model
{
    use HasFactory;
    protected $fillable = [
        'sientific_name',
        'trade_name',
        'price',
        'img',
        'expiration',
        'quantity',
        'manufacture_name',
        'section_id',
        'details'
    ];
    protected $casts = [
        'price' => 'float',
    ];
    public function section(): BelongsTo
    {
        return $this->belongsTo(Section::class);
    }
    public function favoritedByUsers()
    {
        return $this->belongsToMany(User::class, 'user_favorites', 'medicin_id', 'user_id');
    }
    public function Orders(): HasMany
    {
        return $this->hasMany(Oreder::class );
    }
}
