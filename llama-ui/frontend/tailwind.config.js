/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'llama-purple': '#8a63d2',
        'llama-yellow': '#ffcc29',
      },
    },
  },
  plugins: [],
}
