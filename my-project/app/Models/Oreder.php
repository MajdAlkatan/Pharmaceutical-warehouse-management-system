<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Oreder extends Model
{
    use HasFactory;
    protected $fillable = [
        'bill_id',
        'medicin_id',
        'quantity',
        'medicin_name'
    ];

    public function bill(): BelongsTo
    {
        return $this->belongsTo(Bill::class,'bill_id');
    }
    public function medicin(): BelongsTo
    {
        return $this->belongsTo(Medicin::class);
    }

}
