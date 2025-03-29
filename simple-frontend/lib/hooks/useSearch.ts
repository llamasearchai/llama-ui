import { useState, useCallback } from 'react';
import { apiService } from '@/lib/api';
import { useApp } from '@/contexts/AppContext';

export type SearchResult = {
  id: string;
  title: string;
  content: string;
  source: string;
  score: number;
  metadata?: Record<string, any>;
};

export type SearchParams = {
  query: string;
  limit?: number;
  filters?: Record<string, any>;
  sort?: 'relevance' | 'date' | 'source';
};

export function useSearch() {
  const [results, setResults] = useState<SearchResult[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [searchStats, setSearchStats] = useState<{
    totalResults: number;
    searchTime: number;
    hasMore: boolean;
  }>({
    totalResults: 0,
    searchTime: 0,
    hasMore: false,
  });
  const { setError } = useApp();

  const search = useCallback(
    async (params: SearchParams) => {
      if (!params.query.trim()) {
        setResults([]);
        setSearchStats({
          totalResults: 0,
          searchTime: 0,
          hasMore: false,
        });
        return;
      }

      try {
        setIsSearching(true);
        const startTime = performance.now();
        
        // In a real implementation, this would call the API
        // For now, we'll simulate results after a short delay
        const mockSearch = async () => {
          // Simulate API call timing
          await new Promise(r => setTimeout(r, 500));
          
          // Generate some sample results
          const sampleResults: SearchResult[] = [
            {
              id: '1',
              title: 'Understanding Large Language Models',
              content: 'Large Language Models (LLMs) are neural networks trained on vast amounts of text data...',
              source: 'documents/ai_research/llm_basics.pdf',
              score: 0.92,
              metadata: { 
                type: 'pdf', 
                author: 'AI Research Team', 
                date: '2023-05-12',
                pageNumber: 5,
              }
            },
            {
              id: '2',
              title: 'Local Inference with Llama Models',
              content: 'Running Llama models locally provides privacy advantages while maintaining high quality results...',
              source: 'knowledge_base/llama_models/local_inference.md',
              score: 0.87,
              metadata: { 
                type: 'markdown', 
                author: 'Meta AI', 
                date: '2023-08-22',
              }
            },
            {
              id: '3',
              title: 'Semantic Search Implementation Guide',
              content: 'This guide covers implementing semantic search using vector embeddings and cosine similarity...',
              source: 'guides/search/semantic_search_guide.html',
              score: 0.81,
              metadata: { 
                type: 'html', 
                category: 'technical', 
                date: '2023-11-03',
              }
            },
          ];
          
          return {
            results: sampleResults,
            totalResults: 27,
            hasMore: true,
          };
        };

        const response = await mockSearch();
        
        const endTime = performance.now();
        const searchTime = (endTime - startTime) / 1000; // Convert to seconds
        
        setResults(response.results);
        setSearchStats({
          totalResults: response.totalResults,
          searchTime,
          hasMore: response.hasMore,
        });
        
        setIsSearching(false);
      } catch (error) {
        setError('Search failed. Please try again.');
        setIsSearching(false);
      }
    },
    [setError]
  );

  const clearSearch = useCallback(() => {
    setResults([]);
    setSearchStats({
      totalResults: 0,
      searchTime: 0,
      hasMore: false,
    });
  }, []);

  return {
    search,
    clearSearch,
    results,
    isSearching,
    searchStats,
  };
} 