<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProductController;


Route::get('/hello', function (Request $request) {
    return response()->json([
        'msg' => 'hello world'
    ]);
});

Route::get('/products', [ProductController::class, 'index']);

