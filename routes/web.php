<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    // return view('welcome');
    $var = 'Hello Joe!';
    return $var;
    // return view('welcome');
});
