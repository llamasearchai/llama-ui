#!/bin/bash

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print section header
print_header() {
  echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

# Function to print success message
print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error message
print_error() {
  echo -e "${RED}❌ $1${NC}"
}

# Function to print info message
print_info() {
  echo -e "${YELLOW}ℹ️ $1${NC}"
}

# Function to check if a port is in use
check_port() {
  local port=$1
  local process=$(lsof -i:$port -t)
  if [ -n "$process" ]; then
    print_error "Port $port is already in use by process $process"
    return 1
  fi
  return 0
}

# Check if Docker is running
print_header "Checking Docker Status"
if ! docker info > /dev/null 2>&1; then
  print_error "Docker is not running. Please start Docker Desktop and try again."
  exit 1
else
  print_success "Docker is running"
fi

# Check if docker-compose is installed
print_header "Checking Docker Compose"
if ! command -v docker-compose > /dev/null 2>&1 && ! docker compose version > /dev/null 2>&1; then
  print_error "Docker Compose not found. Please install Docker Compose and try again."
  exit 1
else
  print_success "Docker Compose is available"
fi

# Check required ports
print_header "Checking Required Ports"
check_port 8000 || print_info "Backend port 8000 is in use. This might cause conflicts."
check_port 3001 || print_info "Frontend port 3001 is in use. This might cause conflicts."

# Build and start the containers
print_header "Building and Starting Containers"
print_info "This may take a while for the first build..."

# Down any existing containers and volumes if the user wants to start fresh
if [[ $1 == "--fresh" || $1 == "-f" ]]; then
  print_info "Removing existing containers and volumes..."
  docker-compose down -v
fi

# Build and start containers
if docker-compose up -d --build; then
  print_success "Containers built and started successfully"
else
  print_error "Failed to build and start containers"
  exit 1
fi

# Check if containers are running
print_header "Checking Container Status"
BACKEND_RUNNING=$(docker-compose ps | grep backend | grep -i up)
FRONTEND_RUNNING=$(docker-compose ps | grep frontend | grep -i up)

if [[ -n "$BACKEND_RUNNING" ]]; then
  print_success "Backend container is running"
else
  print_error "Backend container is not running properly"
  echo "Checking logs:"
  docker-compose logs backend
  exit 1
fi

if [[ -n "$FRONTEND_RUNNING" ]]; then
  print_success "Frontend container is running"
else
  print_error "Frontend container is not running properly"
  echo "Checking logs:"
  docker-compose logs frontend
  exit 1
fi

# Final output and instructions
print_header "Llama UI Application Dockerized Successfully!"
print_info "The application is now running at:"
echo -e "  - Frontend: ${GREEN}http://localhost:3001${NC}"
echo -e "  - Backend API: ${GREEN}http://localhost:8000${NC}"
echo -e "  - Backend API Docs: ${GREEN}http://localhost:8000/api/docs${NC}"
echo ""
print_info "Management Commands:"
echo -e "  - View logs: ${YELLOW}docker-compose logs -f${NC}"
echo -e "  - Stop containers: ${YELLOW}docker-compose down${NC}"
echo -e "  - Restart containers: ${YELLOW}docker-compose restart${NC}"
echo -e "  - Rebuild containers: ${YELLOW}docker-compose up -d --build${NC}"
echo ""
print_info "For a fresh restart, use: ${YELLOW}./docker-setup.sh --fresh${NC}"

exit 0 