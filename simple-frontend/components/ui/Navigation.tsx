import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { motion } from 'framer-motion';
import { HiMenu, HiX, HiHome, HiDocumentText, HiChat, HiMoon, HiSun } from 'react-icons/hi';
import { useApp } from '@/contexts/AppContext';

const Navigation: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const router = useRouter();
  const { darkMode, toggleDarkMode, apiHealth } = useApp();

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  const closeMenu = () => {
    setIsMenuOpen(false);
  };

  const navigationItems = [
    { label: 'Home', href: '/', icon: <HiHome className="w-5 h-5" /> },
    { label: 'Documents', href: '/documents', icon: <HiDocumentText className="w-5 h-5" /> },
    { label: 'Chat', href: '/chat', icon: <HiChat className="w-5 h-5" /> },
  ];

  const isActive = (path: string) => {
    return router.pathname === path;
  };

  return (
    <nav className="bg-neural-900/70 backdrop-blur-md border-b border-neural-700 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex">
            <Link href="/" className="flex items-center" onClick={closeMenu}>
              <motion.div 
                className="flex items-center"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.3 }}
              >
                <span className="text-primary-500 mr-2 text-3xl font-bold">🦙</span>
                <span className="text-white font-display font-bold text-xl">
                  Llama<span className="text-primary-500">Seek</span>
                </span>
              </motion.div>
            </Link>
          </div>

          {/* API Status Indicator */}
          <div className="hidden md:flex items-center mr-4">
            <div className="flex items-center">
              <div 
                className={`w-2 h-2 rounded-full mr-2 ${
                  apiHealth === 'connected' ? 'bg-green-500' : 
                  apiHealth === 'checking' ? 'bg-yellow-500' : 
                  'bg-red-500'
                }`}
              />
              <span className="text-sm text-neural-300">
                {apiHealth === 'connected' ? 'API Connected' : 
                 apiHealth === 'checking' ? 'Checking API...' : 
                 'API Disconnected'}
              </span>
            </div>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden md:flex md:items-center md:space-x-4">
            {navigationItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={`px-3 py-2 rounded-md text-sm font-medium flex items-center space-x-1.5 transition-colors ${
                  isActive(item.href)
                    ? 'bg-primary-900/50 text-primary-400'
                    : 'text-neural-300 hover:text-white hover:bg-neural-800'
                }`}
              >
                {item.icon}
                <span>{item.label}</span>
              </Link>
            ))}
            <button
              onClick={toggleDarkMode}
              className="ml-4 p-2 rounded-full text-neural-300 hover:text-white hover:bg-neural-800"
              aria-label="Toggle dark mode"
            >
              {darkMode ? <HiSun className="w-5 h-5" /> : <HiMoon className="w-5 h-5" />}
            </button>
          </div>

          {/* Mobile menu button */}
          <div className="flex md:hidden items-center">
            <button
              onClick={toggleMenu}
              className="p-2 rounded-md text-neural-300 hover:text-white hover:bg-neural-800 focus:outline-none"
            >
              <span className="sr-only">Open main menu</span>
              {isMenuOpen ? (
                <HiX className="block h-6 w-6" aria-hidden="true" />
              ) : (
                <HiMenu className="block h-6 w-6" aria-hidden="true" />
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      <motion.div
        className={`md:hidden ${isMenuOpen ? 'block' : 'hidden'}`}
        initial={{ height: 0, opacity: 0 }}
        animate={{ height: isMenuOpen ? 'auto' : 0, opacity: isMenuOpen ? 1 : 0 }}
        transition={{ duration: 0.2 }}
      >
        <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3 border-t border-neural-700">
          {navigationItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={`block px-3 py-2 rounded-md text-base font-medium flex items-center space-x-3 ${
                isActive(item.href)
                  ? 'bg-primary-900/50 text-primary-400'
                  : 'text-neural-300 hover:text-white hover:bg-neural-800'
              }`}
              onClick={closeMenu}
            >
              {item.icon}
              <span>{item.label}</span>
            </Link>
          ))}
          <div className="flex items-center justify-between px-3 py-2">
            <div className="flex items-center">
              <div 
                className={`w-2 h-2 rounded-full mr-2 ${
                  apiHealth === 'connected' ? 'bg-green-500' : 
                  apiHealth === 'checking' ? 'bg-yellow-500' : 
                  'bg-red-500'
                }`}
              />
              <span className="text-sm text-neural-300">
                {apiHealth === 'connected' ? 'API Connected' : 
                 apiHealth === 'checking' ? 'Checking API...' : 
                 'API Disconnected'}
              </span>
            </div>
            <button
              onClick={toggleDarkMode}
              className="p-2 rounded-full text-neural-300 hover:text-white hover:bg-neural-800"
              aria-label="Toggle dark mode"
            >
              {darkMode ? <HiSun className="w-5 h-5" /> : <HiMoon className="w-5 h-5" />}
            </button>
          </div>
        </div>
      </motion.div>
    </nav>
  );
};

export default Navigation; 