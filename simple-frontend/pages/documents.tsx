import React, { useState, useEffect } from 'react';
import Head from 'next/head';
import { useRouter } from 'next/router';
import { useDocumentProcessor } from '../lib/hooks/useDocumentProcessor';
import DocumentDetails from '../components/DocumentDetails';
import apiService from '../lib/api';

export default function DocumentsPage() {
  const [isLoading, setIsLoading] = useState(true);
  const [selectedDocument, setSelectedDocument] = useState<string | null>(null);
  const router = useRouter();
  
  const { 
    documents, 
    uploadDocument, 
    removeDocument, 
    clearAllDocuments,
    uploadProgress, 
    currentStatus 
  } = useDocumentProcessor();

  // Fetch documents on component mount
  useEffect(() => {
    const fetchDocuments = async () => {
      try {
        setIsLoading(true);
        // For a real app, we would fetch documents from the API
        // const response = await apiService.getDocuments();
        
        // For demo purposes, we'll use the mock API
        const response = await apiService.mock.getDocuments();
        
        // Documents are already handled by the hook
        setIsLoading(false);
      } catch (error) {
        console.error('Failed to fetch documents:', error);
        setIsLoading(false);
      }
    };

    fetchDocuments();
  }, []);

  const handleFileUpload = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;
    if (!files || files.length === 0) return;

    try {
      for (let i = 0; i < files.length; i++) {
        await uploadDocument(files[i]);
      }
    } catch (error) {
      console.error('Error uploading file:', error);
    }
  };

  const handleDeleteDocument = (id: string) => {
    if (window.confirm('Are you sure you want to delete this document?')) {
      removeDocument(id);
      if (selectedDocument === id) {
        setSelectedDocument(null);
      }
    }
  };

  const selectedDocumentDetails = selectedDocument 
    ? documents.find(doc => doc.id === selectedDocument) 
    : null;

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <Head>
        <title>Documents | LlamaSeek</title>
        <meta name="description" content="Manage your documents in LlamaSeek - upload, delete and view details of your documents" />
      </Head>

      <main className="container mx-auto px-4 py-8">
        <div className="flex flex-col gap-6">
          <div className="flex justify-between items-center">
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Your Documents</h1>
            <div className="flex gap-3">
              <label 
                htmlFor="file-upload" 
                className="cursor-pointer inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
              >
                <svg className="w-5 h-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
                Upload Document
                <input 
                  id="file-upload" 
                  type="file" 
                  multiple 
                  className="hidden" 
                  onChange={handleFileUpload} 
                  accept=".pdf,.docx,.txt,.csv,.md,.json"
                />
              </label>
              <button 
                className="inline-flex items-center px-4 py-2 border border-gray-300 dark:border-gray-600 text-sm font-medium rounded-md text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
                onClick={() => clearAllDocuments()}
                disabled={documents.length === 0}
              >
                Clear All
              </button>
            </div>
          </div>

          {currentStatus !== 'idle' && (
            <div className="bg-primary-50 dark:bg-primary-900/20 border border-primary-100 dark:border-primary-800 rounded-lg p-4">
              <div className="flex items-center">
                <div className="mr-3 flex-shrink-0">
                  {currentStatus === 'uploading' ? (
                    <svg className="animate-spin h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                  ) : currentStatus === 'processing' ? (
                    <svg className="animate-spin h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                  ) : (
                    <svg className="h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                  )}
                </div>
                <div>
                  <p className="text-sm font-medium text-primary-800 dark:text-primary-200">
                    {currentStatus === 'uploading' && `Uploading document (${uploadProgress}%)...`}
                    {currentStatus === 'processing' && 'Processing document...'}
                    {currentStatus === 'indexing' && 'Indexing document for search...'}
                    {currentStatus === 'complete' && 'Document uploaded and ready to use!'}
                  </p>
                </div>
              </div>
              {currentStatus === 'uploading' && (
                <div className="mt-2 w-full bg-primary-200 dark:bg-primary-700 rounded-full h-2.5">
                  <div className="bg-primary-600 dark:bg-primary-400 h-2.5 rounded-full" style={{ width: `${uploadProgress}%` }}></div>
                </div>
              )}
            </div>
          )}

          {isLoading ? (
            <div className="flex justify-center items-center h-64">
              <svg className="animate-spin h-10 w-10 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
            </div>
          ) : documents.length === 0 ? (
            <div className="flex flex-col items-center justify-center h-64 bg-white dark:bg-gray-800 rounded-lg shadow p-8 text-center">
              <svg className="w-16 h-16 text-gray-400 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              <h3 className="text-lg font-medium text-gray-900 dark:text-white">No documents uploaded yet</h3>
              <p className="text-gray-500 dark:text-gray-400 mt-1">Upload your first document to get started</p>
              <label 
                htmlFor="empty-file-upload" 
                className="mt-4 cursor-pointer inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
              >
                <svg className="w-5 h-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
                Upload Document
                <input 
                  id="empty-file-upload" 
                  type="file" 
                  multiple 
                  className="hidden" 
                  onChange={handleFileUpload} 
                  accept=".pdf,.docx,.txt,.csv,.md,.json"
                />
              </label>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
              {documents.map((doc) => (
                <div 
                  key={doc.id} 
                  className="bg-white dark:bg-gray-800 rounded-lg shadow overflow-hidden hover:shadow-md transition-shadow cursor-pointer"
                  onClick={() => setSelectedDocument(doc.id)}
                >
                  <div className="p-5">
                    <div className="flex items-start gap-3">
                      <div className="flex-shrink-0 p-2 bg-primary-100 dark:bg-primary-900/30 rounded-lg">
                        {doc.type === 'pdf' && (
                          <svg className="w-8 h-8 text-primary-600 dark:text-primary-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <path d="M9 15v-4"></path>
                            <path d="M12 15v-6"></path>
                            <path d="M15 15v-2"></path>
                          </svg>
                        )}
                        {doc.type === 'docx' && (
                          <svg className="w-8 h-8 text-blue-600 dark:text-blue-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                          </svg>
                        )}
                        {doc.type === 'csv' && (
                          <svg className="w-8 h-8 text-green-600 dark:text-green-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="3" y1="9" x2="21" y2="9"></line>
                            <line x1="3" y1="15" x2="21" y2="15"></line>
                            <line x1="9" y1="3" x2="9" y2="21"></line>
                            <line x1="15" y1="3" x2="15" y2="21"></line>
                          </svg>
                        )}
                        {doc.type === 'md' && (
                          <svg className="w-8 h-8 text-purple-600 dark:text-purple-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <line x1="10" y1="9" x2="8" y2="9"></line>
                          </svg>
                        )}
                      </div>
                      <div className="flex-1 min-w-0">
                        <h3 className="text-lg font-semibold text-gray-900 dark:text-white truncate">{doc.name}</h3>
                        <p className="text-sm text-gray-500 dark:text-gray-400">
                          {doc.wordCount?.toLocaleString() || 'N/A'} words • {doc.indexedChunks} chunks
                        </p>
                      </div>
                    </div>
                  </div>
                  <div className="px-5 py-3 bg-gray-50 dark:bg-gray-700/30 text-xs text-gray-500 dark:text-gray-400">
                    Uploaded on {new Date(doc.uploadedAt).toLocaleDateString()}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </main>

      {selectedDocumentDetails && (
        <DocumentDetails 
          document={selectedDocumentDetails}
          onClose={() => setSelectedDocument(null)}
          onDelete={handleDeleteDocument}
        />
      )}
    </div>
  );
} 