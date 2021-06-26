<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDiachikhachhangTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('diachikhachhang', function (Blueprint $table) {
            $table->id();
            $table->string('hoten');
            $table->integer('sdt')->unique();
            $table->string('email');
            $table->string('diachi');
            $table->foreignId('maps_id')->constrained('maps')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('diachikhachhang');
    }
}
