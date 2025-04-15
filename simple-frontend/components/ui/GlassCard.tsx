import React from 'react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';

interface GlassCardProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  className?: string;
  hoverEffect?: boolean;
  floatEffect?: boolean;
}

export const GlassCard: React.FC<GlassCardProps> = ({
  children,
  className,
  hoverEffect = true,
  floatEffect = false,
  ...props
}) => {
  const cardVariants = {
    hover: {
      y: -5,
      transition: {
        duration: 0.2,
        ease: "easeOut"
      }
    },
    float: {
      y: [0, -10, 0],
      transition: {
        duration: 6,
        repeat: Infinity,
        repeatType: "loop" as const,
        ease: "easeInOut"
      }
    }
  };

  return (
    <motion.div 
      className={cn("glass-card", className)}
      whileHover={hoverEffect ? "hover" : undefined}
      animate={floatEffect ? "float" : undefined}
      variants={cardVariants}
      {...props}
    >
      <span className="glass-card-highlight" />
      {children}
    </motion.div>
  );
};

export default GlassCard; 