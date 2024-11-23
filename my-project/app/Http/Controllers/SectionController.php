<?php

namespace App\Http\Controllers;

use App\Models\Section;
use Illuminate\Http\Request;

class SectionController extends Controller
{
    public function put(Request $request)
    {
        $path =null;
        if ($request->hasFile('photo')) 
        {
            $img=$request->file('photo')->getClientOriginalName();
            $path=$request->file('photo')->storeAs('sectionimg',$img,'publicimgs');
             
        }
        Section::create([
            'name'=>$request->input('name'),
            'img'=>$path
        ]);
        return response(['massage'=>'succes'],200);
    }
    public function show()
    {
        $section =Section::all();
        $sectionsArray = $section->toArray();
        $array =[
            [
                "id" => null,
                "name" => 'ALL',
                "img" => null,
                "created_at" => null,
                "updated_at" => null
            ],
            [
                "id" => null,
                "name" => 'NEW',
                "img" => null,
                "created_at" => null,
                "updated_at" => null
            ],
        ];
        $allsection =array_merge($sectionsArray,$array);
        return response(['data'=>$allsection],200);
        ///or 
    }
}
