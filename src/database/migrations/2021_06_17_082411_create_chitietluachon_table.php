<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChitietluachonTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('chitietluachon', function (Blueprint $table) {
            $table->id();
            $table->foreignId('tuychon_id')->constrained('tuychon')->onDelete('cascade');
            $table->foreignId('luachon_id')->constrained('luachon')->onDelete('cascade');
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
        Schema::dropIfExists('chitietluachon');
    }
}
