<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('medicins', function (Blueprint $table) {
            $table->id();
            $table->string('img');
            $table->string('sientific_name')->unique();
            $table->string('trade_name')->unique();
            $table->decimal('price',5,2);
            $table->date('expiration');  // Date in the format YYYY-MM-DD
            $table->bigInteger('quantity');
            $table->string('manufacture_name');
            $table->string('details');
            $table->foreignId('section_id')->constrained('sections');
            $table->timestamps();
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('medicins');
    }
};
