<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMenuTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('menu', function (Blueprint $table) {
            $table->id();
            $table->string('tensp')->unique();
            $table->integer('soluong');
            $table->decimal('giaold', 18, 0);
            $table->decimal('gianew', 18, 0);
            $table->string('mota');
            $table->foreignId('danhmuc_id')->constrained('danhmuc')->onDelete('cascade'); //danh phien 7
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
        Schema::dropIfExists('menu');
    }
}
