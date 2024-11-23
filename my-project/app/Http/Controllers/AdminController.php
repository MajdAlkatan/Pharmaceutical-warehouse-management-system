<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{
    public function login(Request $request)
    {
        $input = $request->all();
        $validator = \Validator::make($input, [
            'password' => 'required|min:3',
            'number' => 'required|unique:users',
        ]);
    
        if ($validator->fails()) {
            return response()->json(['error'=>$validator->errors()],422);
        }
        if(Auth::guard('admin')->attempt(['number'=>$input['number'],'password'=>$input['password']]))
        {
            $user = Admin::where('number', $input['number'])->first();
            //$user = Auth::guard('admin')->user();
            $token = $user->createToken('MyApp',['admin'])->plainTextToken;
            return  response()->json(['token'=>$token],200);
        }
        else
        {
            return  response()->json(['massage'=>'this password or number is wrong']);
        }
    }
    public function  logaout()
    {
        //$user = Auth::user();
        auth()->user()->tokens()->delete();
        return [
            'message' => 'logged out'
        ];

    }
}
