import React from 'react';

export default function Home() {
  return React.createElement(
    'div',
    null,
    React.createElement('h1', null, 'Ultimate Llama AI Application'),
    React.createElement('p', null, 'Welcome to the Llama UI App running in Docker!'),
    React.createElement('p', null, 'Backend API URL: ' + (process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000'))
  );
} 