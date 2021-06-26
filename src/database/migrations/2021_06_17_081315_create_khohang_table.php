<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateKhohangTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('khohang', function (Blueprint $table) {
            $table->id();
            $table->string('sanphamkho');
            $table->integer('soluong');
            $table->decimal('giasanpham', 18, 0);
            $table->decimal('tongtienkho', 18, 0)->nullable();
            $table->foreignId('nhanvien_id')->constrained('nhanviens')->onDelete('cascade');
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
        Schema::dropIfExists('khohang');
    }
}
