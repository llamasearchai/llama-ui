import React from 'react';
import Head from 'next/head';
import Todo from '../components/ui/Todo';
import { GlassCard } from '../components/ui/GlassCard';

const TodoPage = () => {
  // Sample initial todos
  const initialTodos = [
    { id: 1, text: 'Learn about glass morphism', completed: true },
    { id: 2, text: 'Build a Todo component', completed: false },
    { id: 3, text: 'Implement search functionality', completed: false },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-900 to-indigo-900 flex flex-col items-center py-12">
      <Head>
        <title>Todo List | Llama UI</title>
        <meta name="description" content="Todo list example with Llama UI components" />
      </Head>

      <header className="w-full max-w-4xl mb-8 text-center">
        <h1 className="text-3xl font-bold text-white mb-2">Todo List Example</h1>
        <p className="text-gray-300">A simple todo list using Llama UI components</p>
      </header>

      <main className="w-full max-w-4xl">
        <Todo 
          initialTodos={initialTodos} 
          title="My Tasks"
        />

        <GlassCard className="mt-8 p-6">
          <h2 className="text-xl font-semibold mb-4 text-white">About This Example</h2>
          <p className="text-gray-300">
            This Todo component demonstrates the use of Llama UI's glass morphism design patterns.
            It includes features like:
          </p>
          <ul className="list-disc pl-6 mt-2 text-gray-300">
            <li>Adding new tasks</li>
            <li>Marking tasks as complete</li>
            <li>Filtering tasks by status</li>
            <li>Deleting individual tasks</li>
            <li>Clearing all completed tasks</li>
          </ul>
        </GlassCard>
      </main>
    </div>
  );
};

export default TodoPage; 