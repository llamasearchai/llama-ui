# LlamaSeek

![LlamaSeek](https://img.shields.io/badge/LlamaSeek-v1.0.0-blue)
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![React](https://img.shields.io/badge/React-18-61DAFB)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.3-38B2AC)
![TypeScript](https://img.shields.io/badge/TypeScript-5.0-3178C6)

LlamaSeek is a modern document search and analysis platform that leverages local large language models to deliver powerful semantic search, document analysis, and conversational interactions without sending your data to external APIs.

## Features

- **Document Intelligence**: Upload, manage, and analyze various document types (PDF, DOCX, CSV, MD, etc.)
- **Semantic Search**: Search through your documents using natural language queries
- **Data Synthesis**: Extract insights and summaries from your document collection
- **Conversational Knowledge**: Chat with your documents to get contextual answers

## Getting Started

### Prerequisites

- Node.js 18+
- Docker and Docker Compose (for containerized development)

### Installation

#### Using Docker (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/yourusername/llamaseek.git
cd llamaseek
```

2. Start the Docker container:
```bash
docker-compose up -d
```

3. Access the application at `http://localhost:3002`

#### Local Development

1. Clone the repository:
```bash
git clone https://github.com/yourusername/llamaseek.git
cd llamaseek
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Access the application at `http://localhost:3000`

## Project Structure

```
llamaseek/
├── components/           # React components
│   ├── DocumentDetails.tsx
│   └── Navigation.tsx
├── lib/                  # Utility functions and custom hooks
│   ├── hooks/
│   │   ├── useDocumentProcessor.ts
│   │   └── useSearch.ts
│   ├── api.ts            # API service for backend communication
│   └── seed-data.ts      # Sample data for development
├── pages/                # Next.js pages
│   ├── _app.tsx
│   ├── index.tsx
│   ├── documents.tsx
│   ├── search.tsx
│   └── chat.tsx
├── public/               # Static assets
├── styles/               # Global styles
│   └── globals.css
├── next.config.js        # Next.js configuration
├── tailwind.config.js    # Tailwind CSS configuration
└── package.json          # Project dependencies and scripts
```

## Development

### Environment Variables

Create a `.env.local` file in the root directory with the following variables:

```
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application for production
- `npm run start` - Start the production server
- `npm run lint` - Run ESLint
- `npm run test` - Run tests

## Backend Integration

LlamaSeek is designed to work with a FastAPI backend that handles:

1. Document processing and chunking
2. Vector database management
3. LLM integration for search and chat
4. API endpoints for the frontend

The backend API is expected to expose the following endpoints:

- `GET /health` - Health check endpoint
- `POST /documents/upload` - Upload a document
- `GET /documents` - Get all documents
- `DELETE /documents/{id}` - Delete a document
- `POST /search` - Search documents
- `POST /chat` - Chat with documents
- `GET /conversations/{id}` - Get conversation history

## Customization

### Theme Customization

The application uses Tailwind CSS for styling. To customize the theme, edit the `tailwind.config.js` file to change colors, fonts, and other design elements.

### Feature Customization

LlamaSeek is built with a modular architecture, making it easy to add or remove features:

1. Create a new component in the `components` directory
2. Add a new page in the `pages` directory
3. Create custom hooks in the `lib/hooks` directory
4. Update the navigation in `components/Navigation.tsx`

## Deployment

### Docker Deployment

Build and deploy the Docker container:

```bash
docker build -t llamaseek .
docker run -p 3000:3000 llamaseek
```

### Vercel Deployment

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fyourusername%2Fllamaseek)

### Environment Configuration

For production deployment, set the following environment variables:

- `NEXT_PUBLIC_API_URL` - URL of your production API

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Next.js](https://nextjs.org/)
- [React](https://reactjs.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [TypeScript](https://www.typescriptlang.org/)
- [Docker](https://www.docker.com/) 