#!/bin/bash
# ████████╗██╗  ██╗███████╗    ██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗    ██╗     ██╗      █████╗ ███╗   ███╗ █████╗ 
# ╚══██╔══╝██║  ██║██╔════╝    ██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝    ██║     ██║     ██╔══██╗████╗ ████║██╔══██╗
#    ██║   ███████║█████╗      ██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   █████╗      ██║     ██║     ███████║██╔████╔██║███████║
#    ██║   ██╔══██║██╔══╝      ██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝      ██║     ██║     ██╔══██║██║╚██╔╝██║██╔══██║
#    ██║   ██║  ██║███████╗    ╚██████╔╝███████╗██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗    ███████╗███████╗██║  ██║██║ ╚═╝ ██║██║  ██║
#    ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝
#                                                                                                                                  
# ███████╗██╗   ██╗██╗     ██╗         ███████╗████████╗ █████╗  ██████╗██╗  ██╗     █████╗ ██╗    ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗
# ██╔════╝██║   ██║██║     ██║         ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝    ██╔══██╗██║    ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║
# █████╗  ██║   ██║██║     ██║         ███████╗   ██║   ███████║██║     █████╔╝     ███████║██║    ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║
# ██╔══╝  ██║   ██║██║     ██║         ╚════██║   ██║   ██╔══██║██║     ██╔═██╗     ██╔══██║██║    ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║
# ██║     ╚██████╔╝███████╗███████╗    ███████║   ██║   ██║  ██║╚██████╗██║  ██╗    ██║  ██║██║    ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║
# ╚═╝      ╚═════╝ ╚══════╝╚══════╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝

# Master Setup Script for LlamaSeek - Document Search and Analysis Platform
# Optimized for M3 Max MacBook Pro
# Features:
#  - Easy deployment with Docker
#  - Full frontend and backend integration
#  - Environment configuration

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Script variables
FRONTEND_DIR="simple-frontend"
BACKEND_DIR="backend"
DATA_DIR="data"

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   LlamaSeek - Document Search & Analysis Platform    ${NC}"
echo -e "${BLUE}======================================================${NC}"
echo -e "${YELLOW}Setting up your development environment...${NC}"
echo

# Function to check if Docker is installed and running
check_docker() {
  echo -e "🔍 ${YELLOW}Checking Docker installation...${NC}"
  if ! command -v docker &> /dev/null; then
    echo -e "❌ ${RED}Docker is not installed! Please install Docker Desktop first.${NC}"
    echo -e "   Visit https://www.docker.com/products/docker-desktop/ to download."
    exit 1
  fi
  
  if ! docker info &> /dev/null; then
    echo -e "❌ ${RED}Docker is not running! Please start Docker Desktop first.${NC}"
    exit 1
  fi
  
  echo -e "✅ ${GREEN}Docker is installed and running.${NC}"
}

# Function to check if docker-compose is installed
check_docker_compose() {
  echo -e "🔍 ${YELLOW}Checking Docker Compose installation...${NC}"
  if ! command -v docker-compose &> /dev/null; then
    echo -e "❌ ${RED}Docker Compose is not installed!${NC}"
    echo -e "   It should be included with Docker Desktop. Please check your installation."
    exit 1
  fi
  
  echo -e "✅ ${GREEN}Docker Compose is installed.${NC}"
}

# Function to set up the frontend environment
setup_frontend() {
  echo -e "\n🖥️  ${YELLOW}Setting up frontend environment...${NC}"
  
  if [ ! -d "$FRONTEND_DIR" ]; then
    echo -e "❌ ${RED}Frontend directory not found! Creating it...${NC}"
    mkdir -p "$FRONTEND_DIR"
  fi
  
  # Check if docker-compose.yml exists, if not create it
  if [ ! -f "$FRONTEND_DIR/docker-compose.yml" ]; then
    echo -e "📄 ${YELLOW}Creating docker-compose.yml...${NC}"
    cat > "$FRONTEND_DIR/docker-compose.yml" <<EOF
services:
  simple-frontend:
    build: .
    container_name: llamaseek-frontend
    ports:
      - "3002:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - NEXT_PUBLIC_API_URL=http://localhost:8000/api
      - WATCHPACK_POLLING=true
    restart: always
    networks:
      - llamaseek-network
  
  backend:
    image: llamaseek-backend:latest
    build: 
      context: ../backend
      dockerfile: Dockerfile
    container_name: llamaseek-backend
    ports:
      - "8000:8000"
    volumes:
      - ../data:/app/data
    environment:
      - DEBUG=true
      - HOST=0.0.0.0
      - PORT=8000
      - CORS_ORIGINS=["http://localhost:3002"]
    restart: always
    networks:
      - llamaseek-network

networks:
  llamaseek-network:
    driver: bridge
EOF
    echo -e "✅ ${GREEN}docker-compose.yml created.${NC}"
  else
    echo -e "✅ ${GREEN}docker-compose.yml already exists.${NC}"
  fi
  
  echo -e "🔄 ${YELLOW}Building and starting the frontend containers...${NC}"
  cd "$FRONTEND_DIR"
  docker-compose down
  docker-compose up -d --build
  cd ..
  echo -e "✅ ${GREEN}Frontend containers started successfully.${NC}"
}

# Function to set up the backend environment
setup_backend() {
  echo -e "\n🧠 ${YELLOW}Setting up backend environment...${NC}"
  
  if [ ! -d "$BACKEND_DIR" ]; then
    echo -e "❌ ${RED}Backend directory not found! Creating it...${NC}"
    mkdir -p "$BACKEND_DIR"
    
    # Create a basic Dockerfile for the backend
    echo -e "📄 ${YELLOW}Creating backend Dockerfile...${NC}"
    cat > "$BACKEND_DIR/Dockerfile" <<EOF
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Create data directory
RUN mkdir -p /app/data

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
    
    # Create a basic requirements.txt file
    echo -e "📄 ${YELLOW}Creating requirements.txt...${NC}"
    cat > "$BACKEND_DIR/requirements.txt" <<EOF
fastapi==0.104.1
uvicorn==0.23.2
pydantic==2.4.2
python-multipart==0.0.6
# Add any other required packages
EOF
    
    # Create a basic FastAPI application
    echo -e "📄 ${YELLOW}Creating main.py API server...${NC}"
    cat > "$BACKEND_DIR/main.py" <<EOF
import os
import time
from typing import List, Dict, Any, Optional
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

# Record startup time for uptime calculation
START_TIME = time.time()

# Initialize FastAPI app
app = FastAPI(title="LlamaSeek API", description="Backend API for the LlamaSeek document search platform")

# Configure CORS
cors_origins = os.environ.get("CORS_ORIGINS", '["http://localhost:3002"]')
origins = eval(cors_origins)  # Convert string to list

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check endpoint
@app.get("/api/health")
async def health_check():
    uptime = int(time.time() - START_TIME)
    return {
        "status": "healthy",
        "version": "1.0.0",
        "uptime": uptime,
        "environment": os.environ.get("NODE_ENV", "development")
    }

# Document data models
class Document(BaseModel):
    id: str
    title: str
    content: str
    date: str
    tags: Optional[List[str]] = []

# Sample documents
SAMPLE_DOCUMENTS = [
    Document(
        id="1",
        title="Introduction to Semantic Search",
        content="Semantic search is a data searching technique that considers the intent and contextual meaning of search phrases, rather than just matching keywords.",
        date="2023-10-01",
        tags=["search", "nlp", "ai"]
    ),
    Document(
        id="2",
        title="Document Processing Techniques",
        content="Document processing involves extracting valuable information from documents using techniques like OCR, NLP, and machine learning.",
        date="2023-10-02",
        tags=["documents", "processing", "ocr"]
    ),
    Document(
        id="3",
        title="Vector Databases for Document Search",
        content="Vector databases store document embeddings that capture semantic meaning, enabling efficient similarity searches based on content.",
        date="2023-10-03",
        tags=["vectors", "databases", "embeddings"]
    ),
]

# Get all documents
@app.get("/api/documents", response_model=List[Document])
async def get_documents():
    return SAMPLE_DOCUMENTS

# Get document by ID
@app.get("/api/documents/{document_id}", response_model=Document)
async def get_document(document_id: str):
    for doc in SAMPLE_DOCUMENTS:
        if doc.id == document_id:
            return doc
    raise HTTPException(status_code=404, detail="Document not found")

# Basic search endpoint
@app.get("/api/search")
async def search(query: str, limit: int = 10):
    if not query:
        return {"results": [], "meta": {"total": 0, "time": 0}}
    
    start_time = time.time()
    
    # Very simple search implementation (case-insensitive substring match)
    results = []
    for doc in SAMPLE_DOCUMENTS:
        query_lower = query.lower()
        if query_lower in doc.title.lower() or query_lower in doc.content.lower():
            # Calculate a fake match score
            title_match = 1.5 if query_lower in doc.title.lower() else 0
            content_match = 1.0 if query_lower in doc.content.lower() else 0
            score = min((title_match + content_match) / 2.5, 1.0)
            
            results.append({
                "id": doc.id,
                "title": doc.title,
                "content": doc.content[:150] + "..." if len(doc.content) > 150 else doc.content,
                "score": score,
                "date": doc.date
            })
    
    # Sort by score, descending
    results.sort(key=lambda x: x["score"], reverse=True)
    
    # Apply limit
    results = results[:limit]
    
    search_time = time.time() - start_time
    
    return {
        "results": results,
        "meta": {
            "total": len(results),
            "time": search_time
        }
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
EOF
    
    echo -e "✅ ${GREEN}Backend files created successfully.${NC}"
  else
    echo -e "✅ ${GREEN}Backend directory already exists.${NC}"
  fi
  
  # Create data directory if it doesn't exist
  if [ ! -d "$DATA_DIR" ]; then
    echo -e "📁 ${YELLOW}Creating data directory...${NC}"
    mkdir -p "$DATA_DIR"
    echo -e "✅ ${GREEN}Data directory created.${NC}"
  else
    echo -e "✅ ${GREEN}Data directory already exists.${NC}"
  fi
}

# Main function
main() {
  # Print ASCII art
  echo -e "${BLUE}"
  echo "  _      _                         _____            _    "
  echo " | |    | |                       / ____|          | |   "
  echo " | |    | | __ _ _ __ ___   __ _ | (___   ___  ___| | __"
  echo " | |    | |/ _\` | '_ \` _ \ / _\` | \___ \ / _ \/ _ \ |/ /"
  echo " | |____| | (_| | | | | | | (_| | ____) |  __/  __/   < "
  echo " |______|_|\__,_|_| |_| |_|\__,_||_____/ \___|\___|_|\_\\"
  echo -e "${NC}"
  
  # Check required tools
  check_docker
  check_docker_compose
  
  # Set up environments
  setup_backend
  setup_frontend
  
  # Display success message
  echo -e "\n${GREEN}===================================================${NC}"
  echo -e "${GREEN}🎉 Setup completed successfully! 🎉${NC}"
  echo -e "${GREEN}===================================================${NC}"
  echo -e "${YELLOW}LlamaSeek is now running at:${NC}"
  echo -e "  Frontend: ${BLUE}http://localhost:3002${NC}"
  echo -e "  Backend API: ${BLUE}http://localhost:8000${NC}"
  echo -e "  API Health: ${BLUE}http://localhost:8000/api/health${NC}"
  echo
  echo -e "${YELLOW}To check the logs:${NC}"
  echo -e "  Frontend: ${GREEN}cd $FRONTEND_DIR && docker-compose logs -f simple-frontend${NC}"
  echo -e "  Backend: ${GREEN}cd $FRONTEND_DIR && docker-compose logs -f backend${NC}"
  echo
  echo -e "${YELLOW}To stop the services:${NC}"
  echo -e "  ${GREEN}cd $FRONTEND_DIR && docker-compose down${NC}"
  echo
  echo -e "${BLUE}Happy searching with LlamaSeek! 🦙🔍${NC}"
}

# Execute main function
main