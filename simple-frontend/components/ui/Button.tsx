import React from 'react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  icon?: React.ReactNode;
  iconPosition?: 'left' | 'right';
  className?: string;
}

export const Button: React.FC<ButtonProps> = ({
  children,
  variant = 'primary',
  size = 'md',
  loading = false,
  className = '',
  icon,
  iconPosition = 'left',
  disabled,
  ...props
}) => {
  const isDisabled = disabled || loading;

  // Base styles
  let buttonClasses = 'rounded-md focus:outline-none transition duration-200 ease-in-out';
  
  // Variant styles
  if (variant === 'primary') {
    buttonClasses += ' bg-indigo-600 hover:bg-indigo-700 text-white';
  } else if (variant === 'secondary') {
    buttonClasses += ' bg-gray-600 bg-opacity-50 hover:bg-opacity-70 text-white';
  } else if (variant === 'danger') {
    buttonClasses += ' bg-red-600 hover:bg-red-700 text-white';
  }
  
  // Size styles
  if (size === 'sm') {
    buttonClasses += ' px-2 py-1 text-sm';
  } else if (size === 'md') {
    buttonClasses += ' px-4 py-2';
  } else if (size === 'lg') {
    buttonClasses += ' px-6 py-3 text-lg';
  }

  const buttonVariants = {
    initial: { scale: 1 },
    tap: { scale: 0.98 }
  };

  return (
    <motion.button
      className={cn(
        buttonClasses,
        isDisabled && "opacity-50 cursor-not-allowed hover:bg-inherit",
        className
      )}
      initial="initial"
      whileTap="tap"
      variants={buttonVariants}
      disabled={isDisabled}
      {...props}
    >
      {loading ? (
        <span className="inline-block h-4 w-4 animate-spin rounded-full border-2 border-solid border-current border-r-transparent" />
      ) : (
        <>
          {icon && iconPosition === 'left' && <span className="mr-2">{icon}</span>}
          {children}
          {icon && iconPosition === 'right' && <span className="ml-2">{icon}</span>}
        </>
      )}
    </motion.button>
  );
};

export default Button; 