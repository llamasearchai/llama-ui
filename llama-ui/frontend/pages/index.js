import Head from 'next/head';
import { useState, useEffect } from 'react';

export default function Home() {
  const [isLoading, setIsLoading] = useState(true);
  const [apiStatus, setApiStatus] = useState('Checking...');

  useEffect(() => {
    async function checkApiStatus() {
      try {
        const res = await fetch('/api/health');
        const data = await res.json();
        setApiStatus(data.status === 'healthy' ? 'Connected' : 'Error');
      } catch (err) {
        setApiStatus('Disconnected');
      } finally {
        setIsLoading(false);
      }
    }

    checkApiStatus();
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 to-gray-800 text-white">
      <Head>
        <title>Ultimate Llama AI Application</title>
        <meta name="description" content="Full-stack AI application with MLX integration" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-5xl font-bold mb-4">🦙 Ultimate Llama AI</h1>
          <p className="text-xl text-gray-300">Full-stack AI application optimized for Apple Silicon</p>
        </div>
        
        <div className="max-w-md mx-auto bg-gray-800 rounded-lg shadow-lg p-6">
          <div className="text-center">
            <h2 className="text-2xl font-semibold mb-4">System Status</h2>
            <div className="flex items-center justify-center space-x-2 mb-2">
              <span>Backend API:</span>
              <span className={`px-2 py-1 rounded text-sm ${
                apiStatus === 'Connected' ? 'bg-green-600' : 
                apiStatus === 'Disconnected' ? 'bg-red-600' : 'bg-yellow-600'
              }`}>
                {isLoading ? 'Checking...' : apiStatus}
              </span>
            </div>
            <p className="text-gray-400 text-sm">
              {apiStatus === 'Connected' 
                ? 'Your application is running correctly!' 
                : 'Backend API is not connected. Please start the backend server.'}
            </p>
          </div>
        </div>
      </main>

      <footer className="text-center py-8 text-gray-500">
        <p>Ultimate Llama AI Application - v1.0.0</p>
      </footer>
    </div>
  );
}
