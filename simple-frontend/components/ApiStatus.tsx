import React, { useState, useEffect } from 'react';

type ApiStatusProps = {
  className?: string;
};

type HealthStatus = {
  status: string;
  version: string;
  uptime: number;
  environment: string;
};

const ApiStatus: React.FC<ApiStatusProps> = ({ className = '' }) => {
  const [status, setStatus] = useState<'connected' | 'disconnected' | 'checking'>('checking');
  const [healthData, setHealthData] = useState<HealthStatus | null>(null);
  const [lastCheck, setLastCheck] = useState<Date>(new Date());

  const checkApiHealth = async () => {
    try {
      setStatus('checking');
      
      const response = await fetch('/api/health');
      if (response.ok) {
        const data = await response.json();
        setHealthData(data);
        setStatus('connected');
      } else {
        setStatus('disconnected');
      }
    } catch (error) {
      console.error('API health check failed:', error);
      setStatus('disconnected');
    } finally {
      setLastCheck(new Date());
    }
  };

  // Check health on mount and every 30 seconds
  useEffect(() => {
    checkApiHealth();
    const interval = setInterval(checkApiHealth, 30000);
    
    return () => clearInterval(interval);
  }, []);

  // Format uptime as readable string
  const formatUptime = (seconds: number): string => {
    const days = Math.floor(seconds / 86400);
    const hours = Math.floor((seconds % 86400) / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;

    if (days > 0) return `${days}d ${hours}h ${minutes}m`;
    if (hours > 0) return `${hours}h ${minutes}m ${secs}s`;
    if (minutes > 0) return `${minutes}m ${secs}s`;
    return `${secs}s`;
  };

  return (
    <div className={`flex items-center ${className}`}>
      <div className="flex items-center">
        <div 
          className={`w-2 h-2 rounded-full mr-2 ${
            status === 'connected' ? 'bg-green-500' : 
            status === 'disconnected' ? 'bg-red-500' : 
            'bg-yellow-500 animate-pulse'
          }`}
        />
        <span className="text-sm mr-1">
          API:
        </span>
        <span 
          className={`text-sm font-medium ${
            status === 'connected' ? 'text-green-500' : 
            status === 'disconnected' ? 'text-red-500' : 
            'text-yellow-500'
          }`}
        >
          {status === 'connected' ? 'Connected' : 
           status === 'disconnected' ? 'Disconnected' : 
           'Checking...'}
        </span>
      </div>

      {status === 'connected' && healthData && (
        <div className="ml-4 text-xs text-gray-500 dark:text-gray-400">
          <span className="hidden sm:inline mr-2">v{healthData.version}</span>
          <span className="hidden md:inline mr-2">| {healthData.environment}</span>
          <span className="hidden lg:inline">| Up {formatUptime(healthData.uptime)}</span>
        </div>
      )}
    </div>
  );
};

export default ApiStatus; 