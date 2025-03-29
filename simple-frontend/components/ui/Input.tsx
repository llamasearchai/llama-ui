import React, { forwardRef } from 'react';
import { cn } from '@/lib/utils';

export interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  icon?: React.ReactNode;
  iconPosition?: 'left' | 'right';
  onKeyPress?: (event: React.KeyboardEvent<HTMLInputElement>) => void;
}

export const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ className, label, error, icon, iconPosition = 'left', ...props }, ref) => {
    return (
      <div className="w-full space-y-2">
        {label && (
          <label className="block text-sm font-medium text-white/90">
            {label}
          </label>
        )}
        <div className="relative">
          {icon && iconPosition === 'left' && (
            <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-white/50">
              {icon}
            </div>
          )}
          <input
            className={cn(
              "glass-input w-full",
              icon && iconPosition === 'left' && "pl-10",
              icon && iconPosition === 'right' && "pr-10",
              error && "border-red-500 focus:ring-red-500",
              className
            )}
            ref={ref}
            {...props}
          />
          {icon && iconPosition === 'right' && (
            <div className="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none text-white/50">
              {icon}
            </div>
          )}
        </div>
        {error && (
          <p className="text-red-500 text-sm mt-1">{error}</p>
        )}
      </div>
    );
  }
);

Input.displayName = 'Input';

export default Input; 