import { NextApiRequest, NextApiResponse } from 'next';

// Declare the global variable for server start time
declare global {
  var serverStartTime: number | undefined;
}

// Initialize the server start time if it hasn't been set yet
if (!global.serverStartTime) {
  global.serverStartTime = Date.now();
}

export type HealthResponse = {
  status: 'up' | 'down';
  version: string;
  timestamp: string;
  uptime: number;
  environment: string;
};

/**
 * Health Check API endpoint
 * 
 * This API endpoint returns the current health status of the application.
 * It can be used by monitoring tools or frontend components to verify
 * that the server is running and responsive.
 */
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<HealthResponse>
) {
  // Calculate uptime in seconds
  const uptime = global.serverStartTime
    ? Math.floor((Date.now() - global.serverStartTime) / 1000)
    : 0;

  // Get environment
  const environment = global.process?.env?.NODE_ENV || 'development';

  const healthData: HealthResponse = {
    status: 'up',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
    uptime,
    environment,
  };

  res.status(200).json(healthData);
} 