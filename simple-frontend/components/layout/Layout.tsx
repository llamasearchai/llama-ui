import React from 'react';
import Navigation from '@/components/ui/Navigation';

interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <div className="min-h-screen bg-gradient-to-b from-neural-950 to-neural-900 text-white">
      <Navigation />

      {/* Main content */}
      <main className="min-h-screen pb-24">
        {children}
      </main>

      {/* Footer */}
      <footer className="py-6 border-t border-neural-800 bg-neural-900/30">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-sm text-neural-400">
            &copy; {new Date().getFullYear()} LlamaSeek — Intelligent Document Search
          </p>
        </div>
      </footer>
    </div>
  );
};

export default Layout; 