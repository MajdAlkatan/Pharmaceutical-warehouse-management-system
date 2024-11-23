<?php

namespace App\Http\Controllers;

use App\Models\Medicin;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Section;
use Illuminate\Support\Facades\DB;

class MedicinController extends Controller
{
    public function put(Request $request)
    {
        $input = $request->all();
        $section = Section::where("name", $input['section_name'])->first();
        $medicin = Medicin::create([
            'sientific_name' => $request->input('sientific_name'),
            'trade_name' => $request->input('trade_name'),
            'price' => $request->input('price'),
            'img' => $request->input('img'),
            'expiration' => $request->input('expiration'),
            'quantity' => $request->input('quantity'),
            'manufacture_name' => $request->input('manufacture_name'),
            'section_id' => $section->id,
            'details' => $request->input('details')
        ]);
        return response([$medicin], 200);
    }
    public function edit(Request $request, $id)
    {
        $input = $request->all();
        $medicin = Medicin::findOrFail($id);
        $section = Section::where("name", $input['section_name'])->first();
        $medicin->sientific_name = $request->input('sientific_name');
        $medicin->trade_name = $request->input('trade_name');
        $medicin->price = $request->input('price');
        $medicin->img = $request->input('img');
        $medicin->expiration = $request->input('expiration');
        $medicin->quantity = $request->input('quantity');
        $medicin->manufacture_name = $request->input('manufacture_name');
        $medicin->section_id = $section->id;
        $medicin->details = $request->input('details');
        $medicin->save();
        return response([$medicin], 200);
    }
    public function show($section_name)
    {
        if ($section_name === 'ALL') {
            return Medicin::where('quantity', '>', 0)->get();
        }
        if ($section_name === 'NEW') {
            $now = Carbon::now()->subWeek();
            $medicins = Medicin::whereDate('created_at', '>', $now)->where('quantity', '>', 0)->get();
            return $medicins;
        }
        $section = section::where("name", $section_name)->first();
        return $section->medicins()->where('quantity', '>', 0)->get();
    }
    public function search(Request $request, $section)
    {
        if($request==null)
        {
            return "no result";
        }
        if ($section == 'ALL') {
            $medicins = Medicin::where('sientific_name', 'like', '%' . $request->word . '%')
                ->orWhere('trade_name', 'like', '%' . $request->word . '%')->get();
            return $medicins;
        } else if ($section == "NEW") {


            $medicins = Medicin::where(function ($query) use ($request) {
                $query->where('sientific_name', 'like', '%' . $request->word . '%')
                    ->orWhere('trade_name', 'like', '%' . $request->word . '%');
            })
                ->whereDate('created_at', '>=', Carbon::now()->startOfWeek()) 
                ->get();
            return $medicins;
        } else {
            $section = Section::where('name', $section)->first();
            $medicins = Medicin::where('sientific_name', 'like', '%' . $request->word . '%')
                ->orWhere('trade_name', 'like', '%' . $request->word . '%')->get();
            $medicins_i_need_it = $medicins->where('section_id', $section->id);
            return $medicins_i_need_it;
        }
    }
    public function add_fav(Request $request)
    {
        $user = auth()->user();
        $medicinId = $request->input('id');
        $user->favoriteMedicins()->attach($medicinId);
        return response(['massage' => 'succes'], 200);
    }
    public function delete_fav(Request $request)
    {
        $user = auth()->user();
        $medicinId = $request->input('id');
        $user->favoriteMedicins()->detach($medicinId);
        return response(['massage' => 'succes'], 200);
    }
    public function show_fav()
    {
        $user = auth()->user();
        return response(['data' => $user->favoriteMedicins], 200);
    }
}
