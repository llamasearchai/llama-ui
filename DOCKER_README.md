# Llama UI - Docker Setup Guide

This guide describes how to run the Llama UI application using Docker, optimized for Apple Silicon (M1/M2/M3) Macs.

## Architecture

The Dockerized application consists of two main services:

1. **Backend (FastAPI)** - Serves the API on port 8000
2. **Frontend (Next.js)** - Serves the web interface on port 3001

## Prerequisites

- Docker Desktop for Mac (Apple Silicon)
- At least 4GB of free RAM
- At least 10GB of free disk space

## Setup Instructions

### Quick Start

The easiest way to get started is to use the provided setup script:

```bash
cd llama-ui
chmod +x docker-setup.sh
./docker-setup.sh
```

This script will:
1. Check if Docker is installed and running
2. Build and start the containers
3. Verify that both services are running correctly

### Manual Setup

If you prefer to run the commands manually:

```bash
# Navigate to the project directory
cd llama-ui

# Build and start the containers
docker-compose up -d --build

# Check if the containers are running
docker-compose ps

# View logs
docker-compose logs -f
```

## Important Notes on Apple Silicon (M1/M2/M3) Support

### MLX Framework

The application is designed to use Apple's MLX framework for optimized machine learning on Apple Silicon. However, MLX is not available in Docker containers since it requires direct access to the Apple Silicon hardware.

In the Dockerized version:
- The MLX dependency is commented out in the requirements
- A `DISABLE_MLX_FEATURES` environment variable is set to True
- The application falls back to standard libraries when MLX is not available

**To use MLX features, you need to run the application natively (not in Docker) on an Apple Silicon Mac.**

## Accessing the Application

- Frontend: [http://localhost:3001](http://localhost:3001)
- Backend API: [http://localhost:8000](http://localhost:8000)
- API Documentation: [http://localhost:8000/api/docs](http://localhost:8000/api/docs)

## Common Operations

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Just backend
docker-compose logs -f backend

# Just frontend
docker-compose logs -f frontend
```

### Restarting Services

```bash
# Restart everything
docker-compose restart

# Restart just the backend
docker-compose restart backend

# Restart just the frontend
docker-compose restart frontend
```

### Stopping Everything

```bash
# Stop all containers
docker-compose down

# Stop and remove volumes (clean slate)
docker-compose down -v
```

### Fresh Start

To completely rebuild and restart with a fresh state:

```bash
./docker-setup.sh --fresh
```

## Troubleshooting

### Backend Container Fails to Start

If the backend container fails to start, check the logs:

```bash
docker-compose logs backend
```

Common issues:
- MLX-related errors (should be handled by our Dockerfile)
- Database connection errors
- Port conflicts (ensure nothing else is using port 8000)

### Frontend Container Fails to Start

If the frontend container fails to start, check the logs:

```bash
docker-compose logs frontend
```

Common issues:
- Node version incompatibility
- Build errors
- Port conflicts (ensure nothing else is using port 3001)

## Performance Considerations

While Docker adds some overhead, the application is configured to optimize performance on Apple Silicon:

- The `platform: linux/arm64` setting is used to ensure native ARM64 containers
- Volume mounts are used for faster development iterations
- Node modules and Python dependencies are stored in named volumes for faster builds

## Running the Native (Non-Docker) Version

For maximum performance and full MLX support, consider running the application natively:

1. Backend: `cd backend && pip install -r requirements.txt && uvicorn app.main:app --reload`
2. Frontend: `cd frontend && npm install && npm run dev`

This will give you access to all Apple Silicon optimizations including MLX. 