import { useState, useEffect } from 'react';
import { AppProps } from 'next/app';
import Head from 'next/head';
import Navigation from '../components/Navigation';
import '../styles/globals.css';

export default function App({ Component, pageProps }: AppProps) {
  const [isDarkMode, setIsDarkMode] = useState(false);
  
  // Initialize dark mode based on user's preference
  useEffect(() => {
    // Check if user prefers dark mode
    if (typeof window !== 'undefined') {
      const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
      const savedMode = localStorage.getItem('darkMode');
      
      if (savedMode !== null) {
        setIsDarkMode(JSON.parse(savedMode));
      } else {
        setIsDarkMode(prefersDarkMode);
      }
    }
  }, []);
  
  // Apply dark mode class to html element
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const htmlElement = document.documentElement;
      
      if (isDarkMode) {
        htmlElement.classList.add('dark');
      } else {
        htmlElement.classList.remove('dark');
      }
      
      localStorage.setItem('darkMode', JSON.stringify(isDarkMode));
    }
  }, [isDarkMode]);

  const toggleDarkMode = () => {
    setIsDarkMode(!isDarkMode);
  };

  return (
    <>
      <Head>
        <title>LlamaSeek | Intelligent Document Search</title>
        <meta name="description" content="LlamaSeek leverages local large language models to deliver powerful document search, analysis, and insights without sending your data to the cloud." />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      
      <div className="min-h-screen bg-white dark:bg-gray-900 text-gray-900 dark:text-white">
        <Navigation />
        <Component {...pageProps} />
      </div>
    </>
  );
} 