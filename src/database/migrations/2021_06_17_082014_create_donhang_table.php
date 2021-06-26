<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDonhangTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('donhang', function (Blueprint $table) {
            $table->id();
            $table->foreignId('diachikh_id')->constrained('diachikhachhang')->onDelete('cascade');
            $table->foreignId('nhanvien_id')->constrained('nhanviens')->onDelete('cascade');
            $table->string('tinhtrang');
	        $table->string('pp_thanhtoan');
            $table->decimal('tongtien', 18, 0);
	        $table->string('ghichu');
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
        Schema::dropIfExists('donhang');
    }
}
