<?php

namespace Database\Seeders;

use App\Models\Admin;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserAdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create a regular user
        // User::create([
        //     'name' => 'John Doe',
        //     'email' => 'john@example.com',
        //     'password' => bcrypt('123456'),
        // ]);

        // Create an admin 
        Admin::create([
            'name' => 'Admin User',
            'email' => 'admin@example.com',
             'number'=>'0988365145',
            'password' => bcrypt('12341234'),
        ]);
    }
}
