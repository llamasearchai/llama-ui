import { useState, useCallback } from 'react';
import { useApp } from '@/contexts/AppContext';

export type DocumentProcessingStatus = 
  | 'idle' 
  | 'uploading' 
  | 'processing' 
  | 'indexing' 
  | 'complete' 
  | 'failed';

export type DocumentType = 
  | 'pdf' 
  | 'docx' 
  | 'txt' 
  | 'md' 
  | 'csv' 
  | 'json' 
  | 'html';

export type ProcessedDocument = {
  id: string;
  name: string;
  type: DocumentType;
  size: number;
  pageCount?: number;
  wordCount?: number;
  uploadedAt: Date;
  processingStatus: DocumentProcessingStatus;
  processingProgress?: number;
  indexedChunks?: number;
  url?: string;
};

export function useDocumentProcessor() {
  const [documents, setDocuments] = useState<ProcessedDocument[]>([]);
  const [currentStatus, setCurrentStatus] = useState<DocumentProcessingStatus>('idle');
  const [uploadProgress, setUploadProgress] = useState(0);
  const { setError } = useApp();

  const uploadDocument = useCallback(
    async (file: File): Promise<ProcessedDocument | null> => {
      try {
        setCurrentStatus('uploading');
        
        // Simulate file upload with progress
        const simulateUpload = async () => {
          let progress = 0;
          const interval = setInterval(() => {
            progress += 10;
            setUploadProgress(Math.min(progress, 100));
            if (progress >= 100) {
              clearInterval(interval);
            }
          }, 300);
          
          // Simulate network delay
          await new Promise(r => setTimeout(r, 3000));
          return true;
        };
        
        await simulateUpload();
        setCurrentStatus('processing');
        
        // Simulate document processing
        await new Promise(r => setTimeout(r, 1500));
        
        // For indexing progress simulation
        setCurrentStatus('indexing');
        let indexingProgress = 0;
        const interval = setInterval(() => {
          indexingProgress += 5;
          setUploadProgress(Math.min(indexingProgress, 100));
          if (indexingProgress >= 100) {
            clearInterval(interval);
            setCurrentStatus('complete');
          }
        }, 200);
        
        // Create processed document object
        const docType = file.name.split('.').pop()?.toLowerCase() as DocumentType || 'txt';
        const newDocument: ProcessedDocument = {
          id: `doc-${Date.now()}`,
          name: file.name,
          type: docType,
          size: file.size,
          pageCount: docType === 'pdf' ? Math.floor(Math.random() * 30) + 1 : undefined,
          wordCount: Math.floor(Math.random() * 5000) + 500,
          uploadedAt: new Date(),
          processingStatus: 'complete',
          indexedChunks: Math.floor(Math.random() * 50) + 10,
        };
        
        // Add to documents list
        setDocuments(prev => [...prev, newDocument]);
        
        // Reset status after a delay
        setTimeout(() => {
          setCurrentStatus('idle');
          setUploadProgress(0);
        }, 2000);
        
        return newDocument;
      } catch (error) {
        setError('Document upload failed');
        setCurrentStatus('failed');
        return null;
      }
    },
    [setError]
  );

  const removeDocument = useCallback((documentId: string) => {
    setDocuments(prev => prev.filter(doc => doc.id !== documentId));
  }, []);

  const clearAllDocuments = useCallback(() => {
    setDocuments([]);
  }, []);

  return {
    documents,
    currentStatus,
    uploadProgress,
    uploadDocument,
    removeDocument,
    clearAllDocuments,
  };
} 