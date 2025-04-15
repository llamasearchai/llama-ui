import React, { useState } from 'react';
import Head from 'next/head';
import { useSearch, SearchResult } from '../lib/hooks/useSearch';

export default function SearchPage() {
  const [query, setQuery] = useState('');
  const { results: searchResults, isSearching, searchStats: searchMeta, search, clearSearch } = useSearch();

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      search({ query });
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <Head>
        <title>Search | LlamaSeek</title>
        <meta name="description" content="Search through your documents with LlamaSeek's semantic search capabilities" />
      </Head>

      <main className="container mx-auto px-4 py-8">
        <div className="flex flex-col gap-6">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Document Search</h1>
          
          {/* Search Form */}
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-6">
            <form onSubmit={handleSearch} className="flex flex-col gap-4">
              <div>
                <label htmlFor="search-query" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Search Query
                </label>
                <div className="flex gap-2">
                  <input
                    id="search-query"
                    type="text"
                    value={query}
                    onChange={(e) => setQuery(e.target.value)}
                    placeholder="Enter your search query..."
                    className="flex-1 block w-full rounded-md border-gray-300 dark:border-gray-600 shadow-sm py-2 px-3 bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-primary-500 focus:border-primary-500"
                  />
                  <button
                    type="submit"
                    disabled={!query.trim() || isSearching}
                    className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isSearching ? (
                      <>
                        <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                        Searching...
                      </>
                    ) : (
                      <>
                        <svg className="w-4 h-4 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        Search
                      </>
                    )}
                  </button>
                  {searchResults.length > 0 && (
                    <button
                      type="button"
                      onClick={clearSearch}
                      className="inline-flex items-center px-3 py-2 border border-gray-300 dark:border-gray-600 text-sm font-medium rounded-md text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
                    >
                      Clear
                    </button>
                  )}
                </div>
                <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
                  Use natural language to search through your documents, e.g., "What are the key benefits of large language models?"
                </p>
              </div>
            </form>
          </div>
          
          {/* Search Results */}
          {searchResults.length > 0 && (
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm">
              <div className="border-b border-gray-200 dark:border-gray-700 px-6 py-4">
                <div className="flex justify-between items-center">
                  <h2 className="text-lg font-medium text-gray-900 dark:text-white">
                    Search Results
                  </h2>
                  <span className="text-sm text-gray-500 dark:text-gray-400">
                    {searchMeta?.totalResults} results ({searchMeta?.searchTime.toFixed(2)}s)
                  </span>
                </div>
              </div>
              
              <ul className="divide-y divide-gray-200 dark:divide-gray-700">
                {searchResults.map((result: SearchResult) => (
                  <li key={result.id} className="p-6 hover:bg-gray-50 dark:hover:bg-gray-750">
                    <div className="flex flex-col gap-2">
                      <div className="flex justify-between">
                        <h3 className="text-lg font-medium text-gray-900 dark:text-white">
                          {result.title}
                        </h3>
                        <span className="text-sm text-gray-500 dark:text-gray-400 whitespace-nowrap ml-2">
                          {Math.round(result.score * 100)}% match
                        </span>
                      </div>
                      
                      <p className="text-gray-700 dark:text-gray-300">
                        {result.content}
                      </p>
                      
                      <div className="flex justify-between items-center text-sm mt-2">
                        <div className="flex items-center text-gray-500 dark:text-gray-400">
                          <svg className="w-4 h-4 mr-1" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                          </svg>
                          <span>{result.source}</span>
                          {result.metadata?.page && (
                            <span className="ml-1">• Page {result.metadata.page}</span>
                          )}
                        </div>
                        <div>
                          <button className="text-primary-600 hover:text-primary-700 dark:text-primary-400 dark:hover:text-primary-300 font-medium text-sm">
                            View Context
                          </button>
                        </div>
                      </div>
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          )}
          
          {/* Empty state */}
          {!isSearching && query && searchResults.length === 0 && searchMeta && (
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-10 text-center">
              <svg className="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
              <h3 className="mt-2 text-lg font-medium text-gray-900 dark:text-white">No results found</h3>
              <p className="mt-1 text-gray-500 dark:text-gray-400">
                We couldn't find any documents matching your search. Try adjusting your search terms or upload more documents.
              </p>
            </div>
          )}
          
          {/* Initial state */}
          {!isSearching && !query && searchResults.length === 0 && (
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-10 text-center">
              <svg className="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
              <h3 className="mt-2 text-lg font-medium text-gray-900 dark:text-white">Start searching</h3>
              <p className="mt-1 text-gray-500 dark:text-gray-400">
                Enter a search query above to find relevant information in your documents.
              </p>
              <div className="mt-6">
                <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Try these sample queries:</h4>
                <div className="flex flex-wrap justify-center gap-2">
                  {["What are large language models?", "How to implement semantic search?", "Benefits of local LLM inference"].map((sampleQuery) => (
                    <button
                      key={sampleQuery}
                      onClick={() => {
                        setQuery(sampleQuery);
                        search({ query: sampleQuery });
                      }}
                      className="inline-flex items-center px-3 py-1.5 border border-gray-300 dark:border-gray-600 text-sm font-medium rounded-md text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                      {sampleQuery}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          )}
        </div>
      </main>
    </div>
  );
} 