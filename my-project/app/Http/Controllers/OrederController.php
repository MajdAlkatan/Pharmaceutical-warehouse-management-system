<?php

namespace App\Http\Controllers;

use App\Models\Bill;
use App\Models\Medicin;
use App\Models\Oreder;
use Illuminate\Http\Request;

class OrederController extends Controller
{
    public function order(Request $request)
    {
        $user=auth()->user();
        $validatedData = $request->validate([
            'medicins' => 'required|array',
            'medicins.*.id' => 'required|integer',
            'medicins.*.quantity' => 'required|integer|min:1'
        ]);
        $bill = Bill::create([
            'state'=>0,
            'pay'=>0,
            'user_id'=>$user->id,
            'total'=>0
        ]);
         $total=0;
        foreach($validatedData['medicins'] as $medicin)
        {
            $product = Medicin::find($medicin['id']);
            // $medicin
            $order=Oreder::create([
                'bill_id'=>$bill->id,
                'medicin_id'=>$medicin['id'],
                'medicin_name'=>$product->sientific_name,
                'quantity'=>$medicin['quantity']
            ]);
            $product->quantity = $product->quantity-$medicin['quantity'];
            $product->save();
            $total+=$medicin['quantity']*$product->price;
        }
        $bill->total=$total;
        $bill->save();
        return response(['massage'=>"succes"],200);

    }
}