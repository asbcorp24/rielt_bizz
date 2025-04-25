<?php
namespace App\Http\Controllers\Api;

use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;


class DocumentController extends Controller
{
    public function index(Request $request)
    {
        return $request->user()->documents()->get();
    }
    public function store(Request $request)
    {
        $validated = $request->validate([
            'document_type' => 'required|string|max:255',
            'property_id' => 'nullable|exists:properties,id',
            'contract_id' => 'nullable|exists:contracts,id',
            'file' => 'required|file|max:10240', // до 10MB
        ]);

        $path = $request->file('file')->store('documents', 'public');

        $document = Document::create([
            'uploaded_by' => $request->user()->id,
            'document_type' => $validated['document_type'],
            'file_path' => $path,
            'property_id' => $validated['property_id'],
            'contract_id' => $validated['contract_id'],
        ]);

        return response()->json(['document' => $document], 201);
    }
}
