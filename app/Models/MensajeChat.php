<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MensajeChat extends Model
{
    use HasFactory;
    protected $fillable = ['mensaje', 'emisor', 'conversacion', 'receptor', 'hora_mensaje', 'leido'];



}
