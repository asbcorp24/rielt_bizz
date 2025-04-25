<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('name')->after('id');
            $table->string('email')->unique()->after('name');
            $table->timestamp('email_verified_at')->nullable()->after('email');
            $table->string('password')->after('email_verified_at');
            $table->rememberToken()->after('password');

            // Дополнительные поля
            $table->string('first_name')->after('remember_token');
            $table->string('last_name')->after('first_name');
            $table->string('middle_name')->nullable()->after('last_name');
            $table->string('passport_data')->nullable()->after('middle_name');
            $table->string('gosuslugi_link')->nullable()->after('passport_data');
            $table->string('phone')->unique()->after('gosuslugi_link');
            $table->enum('role', ['landlord', 'tenant', 'realtor'])->default('tenant')->after('phone');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'name',
                'email',
                'email_verified_at',
                'password',
                'remember_token',
                'first_name',
                'last_name',
                'middle_name',
                'passport_data',
                'gosuslugi_link',
                'phone',
                'role'
            ]);
        });
    }
};
