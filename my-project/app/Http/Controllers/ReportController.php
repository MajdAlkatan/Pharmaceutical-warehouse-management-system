<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function ShowMyReports()
    {
        $reports=Report::where('user_id',auth()->user()->id)->get();
        $newData = [];

    foreach ($reports as $item) {
        $newData[] = [
            'medicin_many' => $item['medicin_many'],
            'bills_didnt_k' => $item['bills_didnt_k'],
            'id'=>$item['id'],
            'date'=>$item['created_at']
        ];
    }
        return response(['data' => $newData], 200);
    }
}
