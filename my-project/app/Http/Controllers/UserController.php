<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function register(Request $request)
    {
        $input = $request->all();
        $path = null;
        if ($request->hasFile('photo')) {
            $img = $request->file('photo')->getClientOriginalName();
            $path = $request->file('photo')->storeAs('userimg', $img, 'publicimgs');
        }
        $user = User::create([
            'name' => $input['name'],
            'email' => $input['email'],
            'pharmacy_name' => $input['pharmacy_name'],
            'location' => $input['location'],
            'number' => $input['number'],
            'img' => $path,
            'password' => bcrypt($input['password'])
        ]);
        $token = $user->createToken('MyApp', ['user'])->plainTextToken;
        $response = [
            //'user' => $user,
            'token' => $token
        ];
        return response($response, 201);
    }
    public function logaout()
    {
        auth()->user()->tokens()->delete();
        return [
            'message' => 'logged out'
        ];
    }
    public function login(Request $request)
    {
        $input = $request->all();
        // $validator = \Validator::make($input, [
        //     'password' => 'required|min:3',
        //     'number' => 'required',
        // ]);

        // if ($validator->fails()) {
        //     return response()->json(['error'=>$validator->errors()],422);
        // }
        if (Auth::guard('user')->attempt(['number' => $input['number'], 'password' => $input['password']])) {
            $user = User::where('number', $input['number'])->first();
            //$user = Auth::guard('admin')->user();
            $token = $user->createToken('MyApp', ['user'])->plainTextToken;
            return  response()->json(['token' => $token], 200);
        } else {
            return  response()->json(['massage' => 'this password or number is wrong']);
        }
    }
    public function change_profile(Request $request)
    {
        $user = auth()->user();
        $path = null;
        if ($request->hasFile('photo')) {
            $img = $request->file('photo')->getClientOriginalName();
            $path = $request->file('photo')->storeAs('userimg', $img, 'publicimgs');
        }
        if (!Hash::check($request->input("lastPassword"), $user->password)) {
            return response(['the password it is not correct'], 406);
        }
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->pharmacy_name = $request->input('pharmacy_name');
        $user->location = $request->input('location');
        $user->number = $request->input('number');
        $user->img = $path;
        $user->password = bcrypt($request->input('password'));
        $user->save();
        $response = [
            'user' => $user
        ];
        return response($response, 201);
    }
    public function show_profile()
    {
        $user = auth()->user();
        $response = [
            'user' => $user
        ];
        return response($response, 201);
    }
}
