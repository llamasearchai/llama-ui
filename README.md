# LlamaUI

A modern, responsive UI component library and document search application built with Next.js and FastAPI.

## Features

- 🧩 Reusable UI components built with React and TypeScript
- 🌟 Glass morphism design with modern aesthetics
- 🔍 Document search functionality with semantic capabilities
- ✅ Interactive Todo list component with filtering capabilities
- 🚀 Fast and responsive frontend with Next.js
- 🐍 Robust API backend with FastAPI
- 🐳 Docker support for easy deployment

## Architecture

LlamaUI is composed of two main parts:

1. **Frontend**: A Next.js application with TypeScript and Tailwind CSS providing a modern UI
2. **Backend**: A FastAPI application providing document search and API functionality

## Quick Start

### Using Docker (Recommended)

```bash
# Clone the repository
git clone https://llamasearch.ai
cd llama-ui

# Start with Docker Compose
docker-compose up -d
```

Visit [http://localhost:3001](http://localhost:3001) to see the application.

### Manual Setup

#### Frontend

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

#### Backend

```bash
# Navigate to backend directory
cd backend

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start the server
uvicorn main:app --reload
```

## Development

### Prerequisites

- Node.js 16+
- Python 3.9+
- Docker and Docker Compose (optional)

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```
NEXT_PUBLIC_API_URL=http://localhost:8000
```

## API Documentation

When the backend is running, visit [http://localhost:8000/docs](http://localhost:8000/docs) for the Swagger documentation.

## Available Scripts

### Frontend

- `npm run dev`: Starts the development server
- `npm run build`: Builds the application for production
- `npm run start`: Starts the production server
- `npm run lint`: Runs the linter
- `npm run test`: Runs the test suite

### Backend

- `uvicorn main:app --reload`: Starts the development server with auto-reload
- `pytest`: Runs the test suite

## Docker Commands

- `docker-compose up -d`: Starts all services in detached mode
- `docker-compose down`: Stops all services
- `docker-compose logs -f`: Follows the logs from all services

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The LlamaSearch.AI team
- All contributors to this project 
# Updated in commit 1 - 2025-04-04 17:40:59

# Updated in commit 9 - 2025-04-04 17:40:59

# Updated in commit 17 - 2025-04-04 17:41:00

# Updated in commit 25 - 2025-04-04 17:41:00

# Updated in commit 1 - 2025-04-05 14:41:39

# Updated in commit 9 - 2025-04-05 14:41:39

# Updated in commit 17 - 2025-04-05 14:41:40

# Updated in commit 25 - 2025-04-05 14:41:40

# Updated in commit 1 - 2025-04-05 15:27:49

# Updated in commit 9 - 2025-04-05 15:27:50

# Updated in commit 17 - 2025-04-05 15:27:50

# Updated in commit 25 - 2025-04-05 15:27:50

# Updated in commit 1 - 2025-04-05 16:06:11

# Updated in commit 9 - 2025-04-05 16:06:11

# Updated in commit 17 - 2025-04-05 16:06:11

# Updated in commit 25 - 2025-04-05 16:06:12

# Updated in commit 1 - 2025-04-05 17:11:31

# Updated in commit 9 - 2025-04-05 17:11:31

# Updated in commit 17 - 2025-04-05 17:11:31

# Updated in commit 25 - 2025-04-05 17:11:31

# Updated in commit 1 - 2025-04-05 17:44:21

# Updated in commit 9 - 2025-04-05 17:44:21

# Updated in commit 17 - 2025-04-05 17:44:22

# Updated in commit 25 - 2025-04-05 17:44:22

# Updated in commit 1 - 2025-04-05 18:33:52

# Updated in commit 9 - 2025-04-05 18:33:53

# Updated in commit 17 - 2025-04-05 18:33:53

# Updated in commit 25 - 2025-04-05 18:33:53

# Updated in commit 1 - 2025-04-05 18:47:28

# Updated in commit 9 - 2025-04-05 18:47:28

# Updated in commit 17 - 2025-04-05 18:47:28

# Updated in commit 25 - 2025-04-05 18:47:28
