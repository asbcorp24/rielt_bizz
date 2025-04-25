<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\PropertyController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\Api\ContractController;
use App\Http\Controllers\Api\P2PConfirmationController;
use App\Http\Controllers\Api\PropertyAttributeController;
use App\Http\Controllers\Api\UserVerificationController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::prefix('auth')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/profile', [AuthController::class, 'profile']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/documents', [DocumentController::class, 'store']);

        Route::post('/properties', [PropertyController::class, 'store']);
    Route::post('/documents', [DocumentController::class, 'store']);
    Route::get('/properties', [PropertyController::class, 'index']);
    Route::get('/properties/{property}', [PropertyController::class, 'show']);

    Route::apiResource('contracts', ContractController::class);
    Route::apiResource('p2p-confirmations', P2PConfirmationController::class)->only(['index', 'store', 'update']);
    Route::get('/properties/{property}/attributes', [PropertyAttributeController::class, 'index']);
    Route::post('/properties/{property}/attributes', [PropertyAttributeController::class, 'store']);
    Route::apiResource('attribute-types', PropertyAttributeTypeController::class)->only(['index', 'store', 'show', 'destroy']);
    Route::get('/documents', [DocumentController::class, 'index']);
    Route::get('/verification', [UserVerificationController::class, 'index']);
    Route::post('/verification', [UserVerificationController::class, 'store']);
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::put('/notifications/{id}', [NotificationController::class, 'update']);

});
