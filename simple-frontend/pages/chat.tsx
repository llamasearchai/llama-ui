import React, { useState, useRef, useEffect } from 'react';
import Head from 'next/head';
import { useDocumentProcessor } from '../lib/hooks/useDocumentProcessor';

type Message = {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
};

export default function ChatPage() {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 'welcome',
      role: 'assistant',
      content: 'Hello! I\'m your LlamaSeek assistant. How can I help you with your documents today?',
      timestamp: new Date(),
    },
  ]);
  const [inputValue, setInputValue] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const { documents } = useDocumentProcessor();

  // Auto-scroll to bottom of messages
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!inputValue.trim()) return;
    
    // Add user message
    const userMessage: Message = {
      id: `user-${Date.now()}`,
      role: 'user',
      content: inputValue,
      timestamp: new Date(),
    };
    
    setMessages((prevMessages) => [...prevMessages, userMessage]);
    setInputValue('');
    setIsLoading(true);
    
    // Simulate assistant response
    setTimeout(() => {
      const responses = [
        "Based on your documents, I found that large language models can be fine-tuned on domain-specific data to improve performance on specialized tasks.",
        "Your documents mention that semantic search uses vector embeddings to understand the meaning behind queries rather than just matching keywords.",
        "According to the information in your documents, running LLMs locally provides privacy advantages while maintaining high quality results.",
        "The documentation indicates that preprocessing steps like normalization and outlier removal are important before analyzing data.",
        "I couldn't find specific information about that in your documents. Would you like me to search for something else?",
      ];
      
      const assistantMessage: Message = {
        id: `assistant-${Date.now()}`,
        role: 'assistant',
        content: responses[Math.floor(Math.random() * responses.length)],
        timestamp: new Date(),
      };
      
      setMessages((prevMessages) => [...prevMessages, assistantMessage]);
      setIsLoading(false);
    }, 2000);
  };

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <Head>
        <title>Chat | LlamaSeek</title>
        <meta name="description" content="Chat with your documents using LlamaSeek's powerful AI assistant" />
      </Head>

      <main className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
          {/* Sidebar */}
          <div className="hidden lg:block lg:col-span-1">
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-4">
              <h2 className="text-lg font-medium text-gray-900 dark:text-white mb-4">Your Documents</h2>
              
              {documents.length === 0 ? (
                <div className="text-center py-6">
                  <svg className="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                  </svg>
                  <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">No documents uploaded yet</p>
                </div>
              ) : (
                <ul className="space-y-2">
                  {documents.map((doc) => (
                    <li key={doc.id} className="flex items-center p-2 rounded-md hover:bg-gray-100 dark:hover:bg-gray-700 cursor-pointer">
                      <div className="flex-shrink-0 p-1 bg-primary-100 dark:bg-primary-900/30 rounded">
                        <svg className="w-5 h-5 text-primary-600 dark:text-primary-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                      </div>
                      <div className="ml-3 overflow-hidden">
                        <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{doc.name}</p>
                      </div>
                    </li>
                  ))}
                </ul>
              )}
              
              <div className="mt-6">
                <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Chat Settings</h3>
                <div className="space-y-3">
                  <div>
                    <label htmlFor="temp-range" className="text-sm text-gray-600 dark:text-gray-400 flex justify-between">
                      <span>Temperature</span>
                      <span>0.7</span>
                    </label>
                    <input
                      id="temp-range"
                      type="range"
                      min="0"
                      max="1"
                      step="0.1"
                      defaultValue="0.7"
                      className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700"
                    />
                  </div>
                  
                  <div className="flex items-center justify-between">
                    <label htmlFor="contextual-search" className="text-sm text-gray-600 dark:text-gray-400">
                      Use all documents
                    </label>
                    <button
                      role="switch"
                      aria-checked="true"
                      className="relative inline-flex h-6 w-11 items-center rounded-full bg-primary-600"
                    >
                      <span className="translate-x-6 h-4 w-4 transform rounded-full bg-white transition" />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          {/* Chat Area */}
          <div className="lg:col-span-3 flex flex-col h-[calc(100vh-8rem)]">
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm flex-1 flex flex-col">
              {/* Messages */}
              <div className="flex-1 overflow-y-auto p-4 space-y-4">
                {messages.map((message) => (
                  <div
                    key={message.id}
                    className={`flex ${message.role === 'user' ? 'justify-end' : 'justify-start'}`}
                  >
                    <div
                      className={`max-w-3/4 rounded-lg px-4 py-2 ${
                        message.role === 'user'
                          ? 'bg-primary-600 text-white'
                          : 'bg-gray-100 dark:bg-gray-700 text-gray-800 dark:text-gray-200'
                      }`}
                    >
                      <div className="text-sm">{message.content}</div>
                      <div className="mt-1 text-xs opacity-70 text-right">
                        {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                      </div>
                    </div>
                  </div>
                ))}
                
                {isLoading && (
                  <div className="flex justify-start">
                    <div className="max-w-3/4 rounded-lg px-4 py-2 bg-gray-100 dark:bg-gray-700">
                      <div className="flex space-x-2 items-center">
                        <div className="w-2 h-2 bg-gray-500 dark:bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0ms' }}></div>
                        <div className="w-2 h-2 bg-gray-500 dark:bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '150ms' }}></div>
                        <div className="w-2 h-2 bg-gray-500 dark:bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '300ms' }}></div>
                      </div>
                    </div>
                  </div>
                )}
                
                <div ref={messagesEndRef} />
              </div>
              
              {/* Input */}
              <div className="border-t border-gray-200 dark:border-gray-700 p-4">
                <form onSubmit={handleSubmit} className="flex space-x-2">
                  <input
                    type="text"
                    value={inputValue}
                    onChange={(e) => setInputValue(e.target.value)}
                    placeholder="Ask a question about your documents..."
                    className="flex-1 px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-primary-500 focus:border-primary-500"
                    disabled={isLoading}
                  />
                  <button
                    type="submit"
                    disabled={!inputValue.trim() || isLoading}
                    className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <svg className="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                  </button>
                </form>
                <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                  LlamaSeek uses your documents to provide contextual answers. Ask about specific information in your files.
                </p>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
} 