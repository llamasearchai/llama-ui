import React, { createContext, useContext, useState, useEffect } from 'react';
import { LlamaConversation } from '@/lib/api';

interface AppContextType {
  conversations: LlamaConversation[];
  currentConversation: LlamaConversation | null;
  isLoading: boolean;
  error: string | null;
  darkMode: boolean;
  apiHealth: 'connected' | 'disconnected' | 'checking';
  searchQuery: string;
  setConversations: (conversations: LlamaConversation[]) => void;
  setCurrentConversation: (conversation: LlamaConversation | null) => void;
  setIsLoading: (isLoading: boolean) => void;
  setError: (error: string | null) => void;
  toggleDarkMode: () => void;
  setApiHealth: (status: 'connected' | 'disconnected' | 'checking') => void;
  setSearchQuery: (query: string) => void;
  checkApiHealth: () => Promise<void>;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: React.ReactNode }) {
  const [conversations, setConversations] = useState<LlamaConversation[]>([]);
  const [currentConversation, setCurrentConversation] = useState<LlamaConversation | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [darkMode, setDarkMode] = useState(true); // Default to dark mode
  const [apiHealth, setApiHealth] = useState<'connected' | 'disconnected' | 'checking'>('checking');
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    // Apply dark mode class to document
    if (darkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [darkMode]);
  
  useEffect(() => {
    // Check API health on mount
    checkApiHealth();
    
    // Set up interval to check API health periodically
    const interval = setInterval(checkApiHealth, 60000); // Check every minute
    
    return () => clearInterval(interval);
  }, []);

  const toggleDarkMode = () => {
    setDarkMode(!darkMode);
  };
  
  const checkApiHealth = async () => {
    setApiHealth('checking');
    try {
      // This would be a real API call in production
      // For now, simulate with a timeout and random result
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Simulate 80% chance of connection success
      const isConnected = Math.random() < 0.8;
      setApiHealth(isConnected ? 'connected' : 'disconnected');
    } catch (error) {
      setApiHealth('disconnected');
    }
  };

  const value = {
    conversations,
    currentConversation,
    isLoading,
    error,
    darkMode,
    apiHealth,
    searchQuery,
    setConversations,
    setCurrentConversation,
    setIsLoading,
    setError,
    toggleDarkMode,
    setApiHealth,
    setSearchQuery,
    checkApiHealth,
  };

  return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
}

export function useApp() {
  const context = useContext(AppContext);
  if (context === undefined) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
}

export default AppProvider; 