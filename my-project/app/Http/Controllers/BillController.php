<?php

namespace App\Http\Controllers;

use App\Models\Bill;
use Illuminate\Http\Request;

use function PHPUnit\Framework\isEmpty;

class BillController extends Controller
{
    public function ShowMyBills()
    {
        $user = auth()->user();
        $bills = Bill::where('user_id', $user->id)->get();
        if ($bills->isEmpty()) {
            return response(['data' => []], 200); // Return an empty response
        }

        foreach ($bills as $bill) {
            $billId = $bill->id;
            $billState = $bill->state;
            $billPay = $bill->pay;
            $billUser = $bill->user_id;
            $billTotal = $bill->total;
            $medicin_with_quantity = [];
            foreach ($bill->Orders as $order) {
                $orderName = $order->medicin_name;
                $orderMedicin = $order->medicin_id;
                $orderQuantity = $order->quantity;
                $orderName = $medicin_with_quantity[] = [
                    'medicine_name' => $orderName,
                    'quantity' => $order->quantity,
                ];
            }
            $result = [
                'name' => $user->name,
                'state' => $billState,
                'pay' => $billPay,
                'date' => $bill->created_at,
                'total' => $billTotal,
            ];
            $result['medicin_with_quantity'] = $medicin_with_quantity;
            $results[$billId] = $result;
        }
        return response(['data' => $results], 200);
    }
    public function ShowBillsByState($state)
    {
        $bills = Bill::where('state', $state)->get();
        if ($bills->isEmpty()) {
            return response(['data' => []], 200); // Return an empty response
        }
        foreach ($bills as $bill) {
            $billId = $bill->id;
            $billState = $bill->state;
            $billPay = $bill->pay;
            $billUser = $bill->user->name;
            $billTotal = $bill->total;
            $medicin_with_quantity = [];
            foreach ($bill->Orders as $order) {
                $orderName = $order->medicin_name;
                $orderMedicin = $order->medicin_id;
                $orderQuantity = $order->quantity;
                $orderName = $medicin_with_quantity[] = [
                    'medicine_name' => $orderName,
                    'quantity' => $order->quantity,
                ];
            }
            $result = [
                'BillId' => $billId,
                'name' => $billUser,
                'state' => $billState,
                'pay' => $billPay,
                'date' => $bill->created_at,
                'total' => $billTotal,
            ];
            $result['medicin_with_quantity'] = $medicin_with_quantity;
            $results[$billId] = $result;
        }
        return response(['data' => $results], 200);
    }
    public function ShowBillsByUser($userId)
    {
        $bills = Bill::where('user_id', $userId)->get();
        if ($bills->isEmpty()) {
            return response(['data' => []], 200); // Return an empty response
        }
        foreach ($bills as $bill) {
            $billId = $bill->id;
            $billState = $bill->state;
            $billPay = $bill->pay;
            $billUser = $bill->user_id;
            $billTotal = $bill->total;
            $medicin_with_quantity = [];
            foreach ($bill->Orders as $order) {
                $orderName = $order->medicin_name;
                $orderMedicin = $order->medicin_id;
                $orderQuantity = $order->quantity;
                $orderName = $medicin_with_quantity[] = [
                    'medicine_name' => $orderName,
                    'quantity' => $order->quantity,
                ];
            }
            $result = [
                'name' => $billUser,
                'state' => $billState,
                'pay' => $billPay,
                'date' => $bill->created_at,
                'total' => $billTotal,
            ];
            $result['medicin_with_quantity'] = $medicin_with_quantity;
            $results[$billId] = $result;
        }
        return response(['data' => $results], 200);
    }
    public function ShowPercentOfBill()
    {
        if(Bill::count()==0)
        {
            return response(['data' => []], 200); // Return an empty response
        }
        $total = Bill::count();
        $count0 = Bill::where('state', '0')->count();
        $count1 = Bill::where('state', '1')->count();
        return response([
            "state0"=>($count0 / $total) * 100 .'%',
            "state1"=>($count1 / $total) * 100 .'%',
            "state2"=>(($total-($count0+$count1)) / $total) * 100 .'%',
    
        ],200);
    }
    public function change_pay(Request $request)
    {
        $billId= $request->input('id');
        $bill=Bill::findOrFail($billId);
        $bill->pay=1;
        $bill->save();
        return response(['massage' => "succes"], 200);
    }
    public function change_state(Request $request)
    {
        $state = $request->input('state');
        $billId= $request->input('id');
        $bill=Bill::findOrFail($billId);
        $bill->state=$state;
        $bill->save();
        return response(['massage' => 'succes'], 200);
    }
}
