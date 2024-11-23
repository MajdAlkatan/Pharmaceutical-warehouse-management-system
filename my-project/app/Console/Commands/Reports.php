<?php

namespace App\Console\Commands;

use App\Models\Bill;
use App\Models\Oreder;
use App\Models\Report;
use App\Models\ReportForAdmin;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

use function PHPUnit\Framework\isEmpty;

class Reports extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:reports';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $userIds = User::pluck('id')->toArray();
        $now = Carbon::now()->subWeek();
        if (empty($userIds)) {
            $r = ReportForAdmin::create([
                //'user_id' => 1,
                //'medicin_id' => 1,
                'medicin_many' => 0,
                'bills_didnt_k' => 0,
                //'section_id' => 1,
                //'time' => 0,
            ]);
            return 0;
        }

        foreach ($userIds as $userId) {
            $bills = Bill::whereDate('created_at', '>', $now)
                ->where('user_id', $userId)->get();
            if ($bills->isEmpty()) {
                Report::create([
                    'user_id' => $userId,
                    'medicin_many' => 0,
                    'bills_didnt_k' => 0
                ]);
            } else {
                $totalAmount = DB::table('bills')
                    ->whereDate('created_at', '>', $now)
                    ->where("user_id", $userId)
                    ->where('pay', 0)
                    ->sum('total');
                $totalmedicin = 0;
                foreach ($bills as $bill) {
                    $orders = $bill->Orders;
                    foreach ($orders as $order) {
                        $totalmedicin += $order->quantity;
                    }
                }

                Report::create([
                    'user_id' => $userId,
                    'medicin_many' => $totalmedicin,
                    'bills_didnt_k' => $totalAmount
                ]);
            }
        }

        $carts = Oreder::whereDate('created_at', '>', $now)->get();
        if ($carts->isEmpty()) {
            $r = ReportForAdmin::create([
                //'user_id' => 1,
                //'medicin_id' => 1,
                'medicin_many' => 0,
                'bills_didnt_k' => 0,
                //'section_id' => 1,
                //'time' => 0,
            ]);
            return 0;
        }
        $best_users = [];
        $best_medicins = [];
        $all_medicin_many = 0;
        $all_bills_didnt_pay = 0;
        $best_section = [];
        foreach ($carts as $cart) {
            //for how medicin
            $all_medicin_many += $cart->quantity;
            //for best user
            if (isset($best_users[$cart->bill->user_id])) {
                $best_users[$cart->bill->user_id] += $cart->quantity;
            } else {
                $best_users[$cart->bill->user_id] = $cart->quantity;
            }
            //for best medicin
            if (isset($best_medicins[$cart->medicin_id])) {
                $best_medicins[$cart->medicin_id] += $cart->quantity;
            } else {
                $best_medicins[$cart->medicin_id] = $cart->quantity;
            }
            //best section
            if (isset($best_section[$cart->medicin->section_id])) {
                $best_section[$cart->medicin->section_id] += $cart->quantity;
            } else {
                $best_section[$cart->medicin->section_id] = $cart->quantity;
            }
        }
        $maxuser = array_search(max($best_users), $best_users);
        $maxmedicin = array_search(max($best_medicins), $best_medicins);
        $maxsection = array_search(max($best_section), $best_section);
        $bills = Bill::whereDate('created_at', '>', $now)->get();
        foreach ($bills as $bill) {

            if ($bill->pay == 0) {
                $all_bills_didnt_pay += $bill->total;
            }
        }
        $billtimes = Bill::where('pay', 1)->whereDate('created_at', '>', $now)->get();
        if($billtimes->isEmpty())
        {
            ReportForAdmin::create([
                'user_id' => $maxuser,
                'medicin_id' => $maxmedicin,
                'medicin_many' => $all_medicin_many,
                'bills_didnt_k' => $all_bills_didnt_pay,
                'section_id' => $maxsection,
                'time' =>null,
            ]);
            return 0;
        }
        $avgd = 0;
        $avgh = 0;
        $avgi = 0;
        $count = 0;
        foreach ($billtimes as $billtime) {
            $createdAt = Carbon::parse($billtime->created_at);
            $updatedAt = Carbon::parse($billtime->updated_at);

            $diff = $updatedAt->diff($createdAt);
            $diffString = $diff->format('%a days %h hours %i minutes');
            $avgh += $diff->h;
            $avgd += $diff->days;
            $avgi += $diff->i;
            $count++;
        }
        ReportForAdmin::create([
            'user_id' => $maxuser,
            'medicin_id' => $maxmedicin,
            'medicin_many' => $all_medicin_many,
            'bills_didnt_k' => $all_bills_didnt_pay,
            'section_id' => $maxsection,
            'time' => floor($avgd / $count) . ":" . floor($avgh / $count) . ":" . floor($avgi / $count),
        ]);
    }
}