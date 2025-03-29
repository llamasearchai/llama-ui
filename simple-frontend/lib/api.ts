import axios from 'axios';

// Create axios instance with default config
const apiClient = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000',
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 30000, // 30 seconds
});

// API Health check
export const checkApiHealth = async (): Promise<boolean> => {
  try {
    const response = await apiClient.get('/health');
    return response.status === 200;
  } catch (error) {
    console.error('API health check failed:', error);
    return false;
  }
};

// Document upload
export const uploadDocument = async (file: File, onProgress?: (progress: number) => void) => {
  const formData = new FormData();
  formData.append('file', file);
  
  try {
    const response = await apiClient.post('/documents/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      onUploadProgress: (progressEvent) => {
        if (progressEvent.total && onProgress) {
          const percentage = Math.round((progressEvent.loaded * 100) / progressEvent.total);
          onProgress(percentage);
        }
      },
    });
    
    return response.data;
  } catch (error) {
    console.error('Document upload failed:', error);
    throw error;
  }
};

// Get all documents
export const getDocuments = async () => {
  try {
    const response = await apiClient.get('/documents');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch documents:', error);
    throw error;
  }
};

// Delete document
export const deleteDocument = async (documentId: string) => {
  try {
    const response = await apiClient.delete(`/documents/${documentId}`);
    return response.data;
  } catch (error) {
    console.error(`Failed to delete document ${documentId}:`, error);
    throw error;
  }
};

// Search documents
export const searchDocuments = async (query: string, filters?: Record<string, any>) => {
  try {
    const response = await apiClient.post('/search', {
      query,
      ...filters,
    });
    return response.data;
  } catch (error) {
    console.error('Search failed:', error);
    throw error;
  }
};

// Chat with documents
export const chatWithDocuments = async (
  message: string, 
  conversationId?: string,
  filters?: Record<string, any>
) => {
  try {
    const response = await apiClient.post('/chat', {
      message,
      conversation_id: conversationId,
      ...filters,
    });
    return response.data;
  } catch (error) {
    console.error('Chat failed:', error);
    throw error;
  }
};

// Get conversation history
export const getConversationHistory = async (conversationId: string) => {
  try {
    const response = await apiClient.get(`/conversations/${conversationId}`);
    return response.data;
  } catch (error) {
    console.error(`Failed to fetch conversation ${conversationId}:`, error);
    throw error;
  }
};

// Mock API for local development without backend
export const mockApi = {
  isConnected: false,
  
  checkHealth: async (): Promise<boolean> => {
    // Simulate API response
    await new Promise(resolve => setTimeout(resolve, 500));
    return mockApi.isConnected;
  },
  
  toggleConnection: () => {
    mockApi.isConnected = !mockApi.isConnected;
    return mockApi.isConnected;
  },
  
  search: async (query: string) => {
    // Simulate API response delay
    await new Promise(resolve => setTimeout(resolve, 1200));
    
    // Import sample data
    const { sampleSearchResults } = await import('./seed-data');
    
    return {
      results: sampleSearchResults,
      meta: {
        totalResults: sampleSearchResults.length,
        query,
        searchTime: 0.42,
      }
    };
  },
  
  getDocuments: async () => {
    // Simulate API response delay
    await new Promise(resolve => setTimeout(resolve, 800));
    
    // Import sample data
    const { sampleDocuments } = await import('./seed-data');
    
    return {
      documents: sampleDocuments,
      meta: {
        totalDocuments: sampleDocuments.length,
      }
    };
  }
};

// Export a service that uses either real API or mock API
const apiService = {
  checkHealth: async (): Promise<boolean> => {
    // Try real API first
    try {
      return await checkApiHealth();
    } catch (error) {
      // Fall back to mock API
      return mockApi.checkHealth();
    }
  },
  
  uploadDocument,
  getDocuments,
  deleteDocument,
  searchDocuments,
  chatWithDocuments,
  getConversationHistory,
  
  // Mock API for development
  mock: mockApi,
};

export default apiService; 