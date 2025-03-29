import React, { useState } from 'react';
import { GlassCard } from './GlassCard';
import { Button } from './Button';
import { Input } from './Input';

type TodoItem = {
  id: number;
  text: string;
  completed: boolean;
};

interface TodoProps {
  initialTodos?: TodoItem[];
  title?: string;
}

export const Todo: React.FC<TodoProps> = ({ 
  initialTodos = [], 
  title = "Todo List" 
}) => {
  const [todos, setTodos] = useState<TodoItem[]>(initialTodos);
  const [newTodo, setNewTodo] = useState('');
  const [filter, setFilter] = useState<'all' | 'active' | 'completed'>('all');

  const addTodo = () => {
    if (newTodo.trim() === '') return;
    
    const newItem: TodoItem = {
      id: Date.now(),
      text: newTodo.trim(),
      completed: false
    };
    
    setTodos([...todos, newItem]);
    setNewTodo('');
  };

  const toggleTodo = (id: number) => {
    setTodos(todos.map(todo => 
      todo.id === id ? { ...todo, completed: !todo.completed } : todo
    ));
  };

  const deleteTodo = (id: number) => {
    setTodos(todos.filter(todo => todo.id !== id));
  };

  const clearCompleted = () => {
    setTodos(todos.filter(todo => !todo.completed));
  };

  const filteredTodos = todos.filter(todo => {
    if (filter === 'active') return !todo.completed;
    if (filter === 'completed') return todo.completed;
    return true;
  });

  return (
    <GlassCard className="w-full max-w-md mx-auto p-6">
      <h2 className="text-xl font-semibold mb-4 text-white">{title}</h2>
      
      <div className="flex mb-4">
        <Input
          type="text"
          placeholder="Add a new task..."
          value={newTodo}
          onChange={(e) => setNewTodo(e.target.value)}
          className="flex-grow mr-2"
          onKeyPress={(e) => e.key === 'Enter' && addTodo()}
        />
        <Button onClick={addTodo}>Add</Button>
      </div>

      <div className="mb-4 flex space-x-2">
        <Button 
          onClick={() => setFilter('all')}
          variant={filter === 'all' ? 'primary' : 'secondary'}
          size="sm"
        >
          All
        </Button>
        <Button 
          onClick={() => setFilter('active')}
          variant={filter === 'active' ? 'primary' : 'secondary'}
          size="sm"
        >
          Active
        </Button>
        <Button 
          onClick={() => setFilter('completed')}
          variant={filter === 'completed' ? 'primary' : 'secondary'}
          size="sm"
        >
          Completed
        </Button>
      </div>

      <ul className="space-y-2">
        {filteredTodos.length === 0 ? (
          <li className="text-gray-300 text-center py-2">No tasks to display</li>
        ) : (
          filteredTodos.map(todo => (
            <li key={todo.id} className="flex items-center p-2 bg-white bg-opacity-10 rounded-lg">
              <input
                type="checkbox"
                checked={todo.completed}
                onChange={() => toggleTodo(todo.id)}
                className="mr-3 h-5 w-5"
              />
              <span 
                className={`flex-grow ${todo.completed ? 'line-through text-gray-400' : 'text-white'}`}
              >
                {todo.text}
              </span>
              <Button 
                onClick={() => deleteTodo(todo.id)}
                variant="danger"
                size="sm"
              >
                Delete
              </Button>
            </li>
          ))
        )}
      </ul>

      {todos.some(todo => todo.completed) && (
        <div className="mt-4 text-right">
          <Button onClick={clearCompleted} variant="secondary" size="sm">
            Clear Completed
          </Button>
        </div>
      )}
    </GlassCard>
  );
};

export default Todo; 