<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\BillController;
use App\Http\Controllers\MedicinController;
use App\Http\Controllers\OrederController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\ReportForAdminController;
use App\Http\Controllers\SectionController;
use App\Http\Controllers\UserController;
use App\Models\Report;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('login_for_user', [UserController::class, 'login']);
Route::post('register', [UserController::class, 'register']);
Route::get('logaout_for_user', [UserController::class, 'logaout'])
->middleware(['auth:sanctum','abilities:user']);
Route::post('change_profile', [UserController::class, 'change_profile'])
->middleware(['auth:sanctum','abilities:user']);
Route::get('show_profile', [UserController::class, 'show_profile'])
->middleware(['auth:sanctum','abilities:user']);
Route::get('show_medicins/{section_name}', [MedicinController::class, 'show']);
Route::get('show_sections', [SectionController::class, 'show']);
Route::post('search/{section}',[MedicinController::class, 'search']);
Route::post('add_fav', [MedicinController::class, 'add_fav'])
->middleware(['auth:sanctum','abilities:user']);
Route::get('show_fav', [MedicinController::class, 'show_fav'])
->middleware(['auth:sanctum','abilities:user']);
Route::post('delete_fav', [MedicinController::class, 'delete_fav'])
->middleware(['auth:sanctum','abilities:user']);
Route::post('order', [OrederController::class, 'order'])
->middleware(['auth:sanctum','abilities:user']);
Route::get('ShowMyBills', [BillController::class, 'ShowMyBills'])
->middleware(['auth:sanctum','abilities:user']);
Route::get('ShowMyReports', [ReportController::class, 'ShowMyReports'])
->middleware(['auth:sanctum','abilities:user']);
///////
//////
/////

Route::post('login_for_admin', [AdminController::class, 'login']);
Route::get('logout_for_admin', [AdminController::class, 'logaout'])
->middleware(['auth:sanctum','abilities:admin']);
Route::post("put_section",[SectionController::class,'put'])
->middleware(['auth:sanctum','abilities:admin']);
Route::post("put_medicin",[MedicinController::class,'put'])
->middleware(['auth:sanctum','abilities:admin']);
Route::post("edit_meidcin/{id}",[MedicinController::class,'edit'])
->middleware(['auth:sanctum','abilities:admin']);
Route::get('ShowBillsByState/{state}', [BillController::class, 'ShowBillsByState'])
->middleware(['auth:sanctum','abilities:admin']);
Route::get('ShowBillsByUser/{userId}', [BillController::class, 'ShowBillsByUser'])
->middleware(['auth:sanctum','abilities:admin']);
Route::get('ShowPercentOfBill', [BillController::class, 'ShowPercentOfBill'])
->middleware(['auth:sanctum','abilities:admin']);
Route::post('change_state_of_bills', [BillController::class, 'change_state'])
->middleware(['auth:sanctum','abilities:admin']);
Route::post('change_pay', [BillController::class, 'change_pay'])
->middleware(['auth:sanctum','abilities:admin']);
Route::get('ShowReports', [ReportForAdminController::class, 'ShowReports'])
->middleware(['auth:sanctum','abilities:admin']);

// Admin User :: 2|jPYyZUnLYjrbSou3zUsm0DkpaZAZYm6oR5kwUIJ559467b6a
// alaa ::       3|XDKpFPfyrATcPvfYMvr2nTyDoer0vGhemiRszoG7c3289e47
//  26236793
// show all users