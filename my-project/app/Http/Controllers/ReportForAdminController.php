<?php

namespace App\Http\Controllers;

use App\Models\ReportForAdmin;
use Illuminate\Http\Request;

class ReportForAdminController extends Controller
{
    public function ShowReports()
    {
        $reports = ReportForAdmin::with('user', 'section', 'medicin')->get();
        return response(['data' => $reports], 200);
    }
}
