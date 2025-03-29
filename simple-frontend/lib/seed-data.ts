import { ProcessedDocument } from './hooks/useDocumentProcessor';

export const sampleDocuments: ProcessedDocument[] = [
  {
    id: 'doc-1',
    name: 'Introduction to Large Language Models.pdf',
    type: 'pdf',
    size: 2450000,
    pageCount: 12,
    wordCount: 3500,
    uploadedAt: new Date('2023-12-15'),
    processingStatus: 'complete',
    indexedChunks: 28,
  },
  {
    id: 'doc-2',
    name: 'Machine Learning Research Paper.pdf',
    type: 'pdf',
    size: 4120000,
    pageCount: 24,
    wordCount: 6200,
    uploadedAt: new Date('2024-01-05'),
    processingStatus: 'complete',
    indexedChunks: 43,
  },
  {
    id: 'doc-3',
    name: 'data-analysis-results.csv',
    type: 'csv',
    size: 850000,
    wordCount: 12500,
    uploadedAt: new Date('2024-02-10'),
    processingStatus: 'complete',
    indexedChunks: 18,
  },
  {
    id: 'doc-4',
    name: 'Project Documentation.docx',
    type: 'docx',
    size: 1240000,
    pageCount: 15,
    wordCount: 4800,
    uploadedAt: new Date('2024-02-25'),
    processingStatus: 'complete',
    indexedChunks: 32,
  },
  {
    id: 'doc-5',
    name: 'api-documentation.md',
    type: 'md',
    size: 125000,
    wordCount: 3200,
    uploadedAt: new Date('2024-03-01'),
    processingStatus: 'complete',
    indexedChunks: 12,
  }
];

export const sampleSearchResults = [
  {
    id: 'result-1',
    title: 'Understanding Large Language Models',
    content: 'Large Language Models (LLMs) are neural networks trained on vast amounts of text data. They can generate human-like text, translate languages, write different creative content formats, and answer questions in an informative way.',
    source: 'Introduction to Large Language Models.pdf',
    score: 0.92,
    metadata: { 
      documentId: 'doc-1',
      page: 3,
      type: 'pdf',
    }
  },
  {
    id: 'result-2',
    title: 'Local Inference with Llama Models',
    content: 'Running Llama models locally provides privacy advantages while maintaining high quality results. This approach eliminates the need to send sensitive data to external APIs and allows for customization of the model to specific domains.',
    source: 'Project Documentation.docx',
    score: 0.87,
    metadata: { 
      documentId: 'doc-4',
      page: 8,
      type: 'docx',
    }
  },
  {
    id: 'result-3',
    title: 'Semantic Search Implementation',
    content: 'Semantic search uses vector embeddings to understand the meaning behind search queries rather than just matching keywords. This section covers implementing semantic search using vector embeddings and cosine similarity.',
    source: 'api-documentation.md',
    score: 0.81,
    metadata: { 
      documentId: 'doc-5',
      type: 'markdown',
    }
  },
  {
    id: 'result-4',
    title: 'Model Training Techniques',
    content: 'Fine-tuning large language models on domain-specific data can significantly improve performance on specialized tasks. This process involves starting with a pre-trained model and updating the weights based on a smaller, task-specific dataset.',
    source: 'Machine Learning Research Paper.pdf',
    score: 0.78,
    metadata: { 
      documentId: 'doc-2',
      page: 14,
      type: 'pdf',
    }
  },
  {
    id: 'result-5',
    title: 'Data Preprocessing Steps',
    content: 'Before analyzing the data, several preprocessing steps were performed including normalization, outlier removal, and feature engineering. These steps ensure that the data is in a suitable format for machine learning algorithms.',
    source: 'data-analysis-results.csv',
    score: 0.72,
    metadata: { 
      documentId: 'doc-3',
      type: 'csv',
    }
  }
];

// Export a function to initialize the application with seed data
export function initializeWithSeedData() {
  // In a real app, this might store the data in localStorage or IndexedDB
  // For now, we'll just return the sample data
  return {
    documents: sampleDocuments,
    searchResults: sampleSearchResults,
  };
} 