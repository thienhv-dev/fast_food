<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChitietkhoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('chitietkho', function (Blueprint $table) {
            $table->id();
            $table->integer('soluong');
            $table->decimal('gianhap', 18, 0);
            $table->foreignId('menu_id')->constrained('menu')->onDelete('cascade');
            $table->foreignId('khohang_id')->constrained('khohang')->onDelete('cascade');
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
        Schema::dropIfExists('chitietkho');
    }
}
