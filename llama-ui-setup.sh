#!/bin/bash
# ████████╗██╗  ██╗███████╗    ██╗     ██╗      █████╗ ███╗   ███╗ █████╗     ██╗   ██╗██╗
# ╚══██╔══╝██║  ██║██╔════╝    ██║     ██║     ██╔══██╗████╗ ████║██╔══██╗    ██║   ██║██║
#    ██║   ███████║█████╗      ██║     ██║     ███████║██╔████╔██║███████║    ██║   ██║██║
#    ██║   ██╔══██║██╔══╝      ██║     ██║     ██╔══██║██║╚██╔╝██║██╔══██║    ██║   ██║██║
#    ██║   ██║  ██║███████╗    ███████╗███████╗██║  ██║██║ ╚═╝ ██║██║  ██║    ╚██████╔╝██║
#    ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚═╝
#
# Ultimate Llama AI Setup - Complete Installation & Execution Script
# Optimized for macOS and Apple Silicon
# Handles all dependencies, environment setup, and application startup
# Created by ShellScriptGenius - Version 2.0.0

# Enable strict mode
set -euo pipefail

# ==============================
# GLOBAL VARIABLES
# ==============================
VERSION="2.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="Ultimate Llama AI Application"
PROJECT_DIR="$(cd "${SCRIPT_DIR}" && pwd)/llama-ui"
LOG_FILE="${SCRIPT_DIR}/llama-ui-setup.log"
MODE="dev"  # Default mode (dev, prod, docker)
RESTART_SERVICES=false
VERBOSE=false
PYTHON_VERSION="3.11"
NODE_VERSION="18"
FORCE_REINSTALL=false
APPLE_SILICON=false
START_APP=true

# ==============================
# TERMINAL FORMATTING
# ==============================
BOLD="\033[1m"
ITALIC="\033[3m"
RESET="\033[0m"
BLINK="\033[5m"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

# ==============================
# UTILITY FUNCTIONS
# ==============================

# Log messages to console and file
log() {
    local level=$1
    local message=$2
    local color=""
    
    case $level in
        "INFO") color=$GREEN ;;
        "WARNING") color=$YELLOW ;;
        "ERROR") color=$RED ;;
        "DEBUG") color=$BLUE ;;
        *) color=$RESET ;;
    esac
    
    # Get timestamp
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    
    # Output to console
    echo -e "${color}[${level}]${RESET} ${message}"
    
    # Output to log file
    echo "[${timestamp}] [${level}] ${message}" >> "${LOG_FILE}"
}

# Display error message and exit
exit_with_error() {
    log "ERROR" "$1"
    if [[ -n "${2:-}" ]]; then
        log "ERROR" "Suggestion: $2"
    fi
    exit 1
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Print a colorful header
print_header() {
    local text=$1
    local width=80
    local padding=$(( (width - ${#text} - 4) / 2 ))
    
    echo
    echo -e "${BG_MAGENTA}${WHITE}${BOLD}"
    printf "%${width}s\n" " " | tr " " "="
    printf "%s%${padding}s %s %${padding}s%s\n" "|" " " "$text" " " "|"
    printf "%${width}s\n" " " | tr " " "="
    echo -e "${RESET}"
}

# Print section title
print_section() {
    echo -e "\n${CYAN}${BOLD}[ $1 ]${RESET}"
}

# Spinner animation
spinner() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spinstr='|/-\'
    
    echo -ne "${message} "
    
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf "[%c]" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b"
    done
    
    wait $pid
    local return_code=$?
    
    if [ $return_code -eq 0 ]; then
        echo -e "${GREEN}${BOLD}[Done]${RESET}"
    else
        echo -e "${RED}${BOLD}[Failed]${RESET}"
        return $return_code
    fi
}

# Display progress bar
progress_bar() {
    local duration=$1
    local message=${2:-"Processing"}
    local bar_size=40
    local sleep_interval=$(bc -l <<< "scale=4; $duration/$bar_size")
    
    echo -ne "${message} [${RESET}"
    
    for ((i=0; i<bar_size; i++)); do
        sleep $sleep_interval
        echo -ne "${BG_BLUE} ${RESET}"
    done
    
    echo -e "${GREEN}${BOLD}] Completed!${RESET}"
}

# Display the Llama ASCII art
display_llama_ascii() {
    echo -e "${YELLOW}"
    echo -e "                ${BOLD}🦙 THE ULTIMATE LLAMA AI APP 🦙${RESET}${YELLOW}"
    echo "                          /"
    echo "                         /"
    echo "                        /"
    echo "      ,\`','~-.,,,,_____/___________,,,,,\"  "
    echo "     /         \\,-----~~~~~~------\"~\"\"    \\"
    echo "    (    ,~,    )                         |"
    echo "    /   (   )   \\                         |"
    echo "   (     \\_/     )                        |"
    echo "    \\             \\                       /"
    echo "     \\~.,_____,~''/________________________)"
    echo -e "${RESET}"
}

# Check script requirements
check_requirements() {
    # Create log file
    if [[ ! -f "${LOG_FILE}" ]]; then
        touch "${LOG_FILE}" || exit_with_error "Cannot create log file at ${LOG_FILE}"
    fi
    
    log "INFO" "Starting ${PROJECT_NAME} setup (v${VERSION})"
    log "INFO" "Setup mode: ${MODE}"
    
    # Check if running on macOS
    if [[ "$(uname)" != "Darwin" ]]; then
        exit_with_error "This script is designed for macOS only." "Try running on a Mac system."
    fi
    
    # Check for Apple Silicon
    if [[ "$(uname -m)" == "arm64" ]]; then
        APPLE_SILICON=true
        log "INFO" "Apple Silicon detected - Enabling MLX optimizations"
    else
        log "WARNING" "This script is optimized for Apple Silicon. Some MLX features may not work on Intel Macs."
        read -p "$(echo -e ${YELLOW}"Continue anyway? (y/n) "${RESET})" -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit_with_error "Setup aborted by user."
        fi
    fi
}

# Check and install Homebrew
ensure_homebrew() {
    print_section "Checking for Homebrew"

    if ! command_exists brew; then
        log "INFO" "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit_with_error "Failed to install Homebrew" "Check your internet connection and try again."
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ "$APPLE_SILICON" == true ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log "INFO" "Homebrew found: $(brew --version | head -1)"
        
        # Update Homebrew if it's been more than a day since last update
        if [[ "$FORCE_REINSTALL" == true ]] || [[ ! -f "${HOME}/.brew_updated" ]] || [[ "$(find "${HOME}/.brew_updated" -mtime +1 2>/dev/null)" ]]; then
            log "INFO" "Updating Homebrew..."
            brew update &> /dev/null &
            spinner $! "Updating Homebrew..."
            touch "${HOME}/.brew_updated"
        fi
    fi
}

# Check and install Python
ensure_python() {
    print_section "Checking for Python ${PYTHON_VERSION}"
    
    if command_exists pyenv; then
        log "INFO" "pyenv found: $(pyenv --version)"
        
        # Install required Python version if not available
        if ! pyenv versions | grep -q "${PYTHON_VERSION}"; then
            log "INFO" "Installing Python ${PYTHON_VERSION} via pyenv..."
            pyenv install "${PYTHON_VERSION}" || exit_with_error "Failed to install Python ${PYTHON_VERSION}" "Try running 'brew update && brew upgrade pyenv' first."
        fi
        
        # Set Python version for project
        pyenv local "${PYTHON_VERSION}"
    else
        # Check if Python is installed via Homebrew
        if ! command_exists python3 || [[ "$(python3 --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1-2)" != "${PYTHON_VERSION%.*}" ]]; then
            log "INFO" "Python ${PYTHON_VERSION} not found. Installing with Homebrew..."
            brew install python@${PYTHON_VERSION} || exit_with_error "Failed to install Python"
        else
            log "INFO" "Python found: $(python3 --version)"
        fi
    fi
    
    # Ensure pip is up-to-date
    python3 -m pip install --upgrade pip &> /dev/null
    
    # Ensure required Python packages
    log "INFO" "Installing required Python packages..."
    python3 -m pip install virtualenv &> /dev/null
}

# Check and install Node.js
ensure_node() {
    print_section "Checking for Node.js"
    
    if command_exists nvm; then
        log "INFO" "nvm found: $(nvm --version 2>/dev/null || echo 'version unknown')"
        
        # Install required Node version if not available
        if ! nvm ls "${NODE_VERSION}" &>/dev/null; then
            log "INFO" "Installing Node.js ${NODE_VERSION} via nvm..."
            nvm install "${NODE_VERSION}" || exit_with_error "Failed to install Node.js" "Try running 'nvm install ${NODE_VERSION}' manually."
        fi
        
        # Use the installed Node version
        nvm use "${NODE_VERSION}" &>/dev/null
    else
        # Check if Node is installed
        if ! command_exists node || [[ "$(node --version 2>&1 | cut -c2- | cut -d'.' -f1)" != "${NODE_VERSION}" ]]; then
            log "INFO" "Node.js ${NODE_VERSION} not found. Installing with Homebrew..."
            brew install node@${NODE_VERSION} || exit_with_error "Failed to install Node.js"
            
            # Add Node to PATH if installed with Homebrew
            if [[ -d "/opt/homebrew/opt/node@${NODE_VERSION}/bin" ]]; then
                export PATH="/opt/homebrew/opt/node@${NODE_VERSION}/bin:$PATH"
            elif [[ -d "/usr/local/opt/node@${NODE_VERSION}/bin" ]]; then
                export PATH="/usr/local/opt/node@${NODE_VERSION}/bin:$PATH"
            fi
        else
            log "INFO" "Node.js found: $(node --version)"
        fi
    fi
    
    # Ensure npm is up-to-date
    npm install -g npm &> /dev/null
}

# Check for Docker if needed
ensure_docker() {
    if [[ "$MODE" == "docker" ]]; then
        print_section "Checking for Docker"
        
        if ! command_exists docker; then
            log "ERROR" "Docker is required but not installed."
            log "INFO" "Please install Docker Desktop from https://www.docker.com/products/docker-desktop"
            exit 1
        else
            log "INFO" "Docker found: $(docker --version)"
            
            # Check if Docker is running
            if ! docker info &>/dev/null; then
                log "ERROR" "Docker is installed but not running."
                log "INFO" "Please start Docker Desktop and try again."
                exit 1
            fi
        fi
    fi
}

# Install additional CLI tools
install_cli_tools() {
    print_section "Installing CLI Tools"
    
    # Install additional tools with Homebrew
    local tools=(jq wget curl git bc)
    
    for tool in "${tools[@]}"; do
        if ! command_exists "$tool"; then
            log "INFO" "Installing $tool..."
            brew install "$tool" &>/dev/null || log "WARNING" "Failed to install $tool"
        else
            log "INFO" "$tool found: $($tool --version 2>/dev/null | head -1 || echo 'version unknown')"
        fi
    done
    
    # Install MLX if on Apple Silicon
    if [[ "$APPLE_SILICON" == true ]]; then
        log "INFO" "Installing MLX for Apple Silicon..."
        python3 -m pip install -U mlx &>/dev/null || log "WARNING" "Failed to install MLX"
    fi
}

# Create project structure
create_project_structure() {
    print_section "Creating Project Structure"
    
    log "INFO" "Setting up project directory at ${PROJECT_DIR}"
    
    # Remove existing directory if it exists and force flag is set
    if [[ -d "$PROJECT_DIR" ]]; then
        if [[ "$FORCE_REINSTALL" == true ]]; then
            log "WARNING" "Removing existing project directory..."
            rm -rf "$PROJECT_DIR"
        else
            log "INFO" "Project directory already exists. Using existing files."
            return 0
        fi
    fi
    
    # Create root directory
    mkdir -p "$PROJECT_DIR"
    
    # Create backend structure
    log "INFO" "Creating backend directory structure..."
    mkdir -p "$PROJECT_DIR/backend/app/api"
    mkdir -p "$PROJECT_DIR/backend/app/core"
    mkdir -p "$PROJECT_DIR/backend/app/models"
    mkdir -p "$PROJECT_DIR/backend/app/services"
    mkdir -p "$PROJECT_DIR/backend/app/ml/models"
    mkdir -p "$PROJECT_DIR/backend/app/themes"
    mkdir -p "$PROJECT_DIR/backend/tests"
    mkdir -p "$PROJECT_DIR/backend/data"
    mkdir -p "$PROJECT_DIR/backend/logs"
    
    # Create frontend structure
    log "INFO" "Creating frontend directory structure..."
    mkdir -p "$PROJECT_DIR/frontend/pages"
    mkdir -p "$PROJECT_DIR/frontend/components/ui"
    mkdir -p "$PROJECT_DIR/frontend/components/llama"
    mkdir -p "$PROJECT_DIR/frontend/styles"
    mkdir -p "$PROJECT_DIR/frontend/public/images/llama"
    mkdir -p "$PROJECT_DIR/frontend/lib/hooks"
    mkdir -p "$PROJECT_DIR/frontend/lib/utils"
    mkdir -p "$PROJECT_DIR/frontend/lib/api"
    
    # Create CLI tool structure
    log "INFO" "Creating CLI tool directory structure..."
    mkdir -p "$PROJECT_DIR/llama-cli/src"
    mkdir -p "$PROJECT_DIR/llama-cli/themes"
    mkdir -p "$PROJECT_DIR/llama-cli/assets"
    
    # Create Docker & Kubernetes structure if needed
    if [[ "$MODE" == "docker" || "$MODE" == "prod" ]]; then
        log "INFO" "Creating Docker & Kubernetes structure..."
        mkdir -p "$PROJECT_DIR/docker/backend"
        mkdir -p "$PROJECT_DIR/docker/frontend"
        mkdir -p "$PROJECT_DIR/docker/cli"
        mkdir -p "$PROJECT_DIR/k8s/base"
        mkdir -p "$PROJECT_DIR/k8s/overlays/dev"
        mkdir -p "$PROJECT_DIR/k8s/overlays/prod"
    fi
    
    # Create other directories
    mkdir -p "$PROJECT_DIR/docs"
    mkdir -p "$PROJECT_DIR/config"
    mkdir -p "$PROJECT_DIR/.github/workflows"
    
    progress_bar 1 "Creating directory structure"
}

# Setup Python virtual environment
setup_python_venv() {
    print_section "Setting up Python Virtual Environment"
    
    # Create and activate virtual environment
    log "INFO" "Creating Python virtual environment..."
    cd "$PROJECT_DIR/backend"
    
    if [[ ! -d "venv" ]]; then
        python3 -m virtualenv venv || exit_with_error "Failed to create virtual environment"
    else
        log "INFO" "Virtual environment already exists"
    fi
    
    # Activate virtual environment
    source venv/bin/activate || exit_with_error "Failed to activate virtual environment"
    
    # Upgrade pip
    log "INFO" "Upgrading pip..."
    pip install --upgrade pip &>/dev/null
    
    # Install backend dependencies
    log "INFO" "Installing backend dependencies..."
    cat > requirements.txt << EOF
fastapi>=0.100.0
uvicorn[standard]>=0.23.0
pydantic>=2.0.0
pydantic-settings>=2.0.0
sqlalchemy>=2.0.0
alembic>=1.11.0
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4
python-multipart>=0.0.6
httpx>=0.24.0
rich>=13.4.0
python-dotenv>=1.0.0
llama-index>=0.8.0
jinja2>=3.1.2
EOF

    if [[ "$APPLE_SILICON" == true ]]; then
        echo "mlx>=0.1.0" >> requirements.txt
    fi
    
    pip install -r requirements.txt &>/dev/null &
    spinner $! "Installing Python dependencies"
    
    # Deactivate virtual environment
    deactivate
}

# Setup Node.js environment
setup_node_env() {
    print_section "Setting up Node.js Environment"
    
    # Setup frontend
    log "INFO" "Setting up Next.js frontend..."
    cd "$PROJECT_DIR/frontend"
    
    if [[ ! -f "package.json" ]]; then
        cat > package.json << EOF
{
  "name": "llama-ui-frontend",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "^13.4.12",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "axios": "^1.4.0",
    "tailwindcss": "^3.3.3",
    "autoprefixer": "^10.4.14",
    "postcss": "^8.4.27",
    "react-query": "^3.39.3",
    "@heroicons/react": "^2.0.18",
    "swr": "^2.2.0"
  },
  "devDependencies": {
    "typescript": "^5.1.6",
    "@types/react": "^18.2.18",
    "@types/node": "^20.4.5",
    "eslint": "^8.46.0",
    "eslint-config-next": "^13.4.12"
  }
}
EOF
    else
        log "INFO" "Frontend package.json already exists"
    fi
    
    # Install dependencies
    if [[ ! -d "node_modules" ]]; then
        log "INFO" "Installing frontend dependencies..."
        npm install &>/dev/null &
        spinner $! "Installing Node.js dependencies"
    else
        log "INFO" "Frontend dependencies already installed"
    fi
}

# Generate basic application files
generate_application_files() {
    print_section "Generating Application Files"
    
    # Create backend main application file
    log "INFO" "Creating FastAPI application files..."
    cd "$PROJECT_DIR/backend"
    
    # Create .env file
    cat > .env << EOF
# Environment Configuration
DEBUG=True
LOG_LEVEL=INFO
HOST=0.0.0.0
PORT=8000

# Security
SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_hex(32))')
ACCESS_TOKEN_EXPIRE_MINUTES=60

# CORS Settings
CORS_ORIGINS=["http://localhost:3000", "http://127.0.0.1:3000"]

# MLX Configuration
MLX_DEFAULT_MODEL=llama-2-7b-mlx
MLX_QUANTIZATION=True
EOF

    # Create main.py
    cat > app/main.py << 'EOF'
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import uvicorn
import logging
import time
import os
import sys

# Append parent directory to path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Setup app
app = FastAPI(
    title="Ultimate Llama AI Application",
    description="Full-stack AI application with MLX integration optimized for Apple Silicon",
    version="1.0.0",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Request timing middleware
@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    process_time = time.time() - start_time
    response.headers["X-Process-Time"] = str(process_time)
    return response

# Root endpoint
@app.get("/")
def read_root():
    return {
        "message": "Welcome to the Ultimate Llama AI Application",
        "version": "1.0.0",
        "docs": "/api/docs"
    }

# Health check endpoint
@app.get("/api/health")
def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    uvicorn.run(
        "app.main:app", 
        host="0.0.0.0", 
        port=8000, 
        reload=True,
        log_level="info"
    )
EOF

    # Create __init__.py files
    touch app/__init__.py
    touch app/api/__init__.py
    touch app/core/__init__.py
    touch app/models/__init__.py
    touch app/services/__init__.py
    
    # Create frontend basic files
    log "INFO" "Creating Next.js application files..."
    cd "$PROJECT_DIR/frontend"
    
    # Create next.config.js
    cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://localhost:8000/api/:path*',
      },
    ];
  },
}

module.exports = nextConfig
EOF

    # Create pages/_app.js
    mkdir -p pages
    cat > pages/_app.js << 'EOF'
import '../styles/globals.css';

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />
}

export default MyApp
EOF

    # Create pages/index.js
    cat > pages/index.js << 'EOF'
import Head from 'next/head';
import { useState, useEffect } from 'react';

export default function Home() {
  const [isLoading, setIsLoading] = useState(true);
  const [apiStatus, setApiStatus] = useState('Checking...');

  useEffect(() => {
    async function checkApiStatus() {
      try {
        const res = await fetch('/api/health');
        const data = await res.json();
        setApiStatus(data.status === 'healthy' ? 'Connected' : 'Error');
      } catch (err) {
        setApiStatus('Disconnected');
      } finally {
        setIsLoading(false);
      }
    }

    checkApiStatus();
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 to-gray-800 text-white">
      <Head>
        <title>Ultimate Llama AI Application</title>
        <meta name="description" content="Full-stack AI application with MLX integration" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-5xl font-bold mb-4">🦙 Ultimate Llama AI</h1>
          <p className="text-xl text-gray-300">Full-stack AI application optimized for Apple Silicon</p>
        </div>
        
        <div className="max-w-md mx-auto bg-gray-800 rounded-lg shadow-lg p-6">
          <div className="text-center">
            <h2 className="text-2xl font-semibold mb-4">System Status</h2>
            <div className="flex items-center justify-center space-x-2 mb-2">
              <span>Backend API:</span>
              <span className={`px-2 py-1 rounded text-sm ${
                apiStatus === 'Connected' ? 'bg-green-600' : 
                apiStatus === 'Disconnected' ? 'bg-red-600' : 'bg-yellow-600'
              }`}>
                {isLoading ? 'Checking...' : apiStatus}
              </span>
            </div>
            <p className="text-gray-400 text-sm">
              {apiStatus === 'Connected' 
                ? 'Your application is running correctly!' 
                : 'Backend API is not connected. Please start the backend server.'}
            </p>
          </div>
        </div>
      </main>

      <footer className="text-center py-8 text-gray-500">
        <p>Ultimate Llama AI Application - v1.0.0</p>
      </footer>
    </div>
  );
}
EOF

    # Create styles
    mkdir -p styles
    cat > styles/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --primary-color: #8a63d2;
  --secondary-color: #5d3fd3;
  --accent-color: #ffcc29;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen,
    Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
}

a {
  color: inherit;
  text-decoration: none;
}

* {
  box-sizing: border-box;
}
EOF

    # Create tailwind config
    cat > tailwind.config.js << 'EOF'
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
EOF

    # Create postcss.config.js
    cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

    # Create README.md
    cd "$PROJECT_DIR"
    cat > README.md << 'EOF'
# Ultimate Llama AI Application

A full-stack AI application optimized for Apple Silicon with MLX integration.

## Features

- FastAPI Backend with SQLite database
- Next.js Frontend with TailwindCSS
- MLX optimizations for Apple Silicon
- Interactive Llama AI chat interface
- Command-line interface tools

## Getting Started

### Development Mode

```bash
# Start the backend
cd backend
source venv/bin/activate
python -m app.main

# In another terminal, start the frontend
cd frontend
npm run dev
```

Visit http://localhost:3000 to see the application.

## System Requirements

- macOS (Apple Silicon preferred)
- Python 3.11+
- Node.js 18+
- MLX for Apple Silicon optimization

## License

MIT
EOF

    progress_bar 2 "Generating application files"
}

# Run the application
run_application() {
    if [[ "$START_APP" != true ]]; then
        return
    fi
    
    print_section "Starting the Application"
    
    log "INFO" "Starting backend server..."
    cd "$PROJECT_DIR/backend"
    source venv/bin/activate
    
    # Start the backend server in the background
    python -m app.main &
    BACKEND_PID=$!
    
    # Start the frontend in another terminal
    log "INFO" "Starting frontend development server..."
    osascript -e "tell application \"Terminal\" to do script \"cd '${PROJECT_DIR}/frontend' && npm run dev\""
    
    log "INFO" "Application started!"
    log "INFO" "Backend running at: http://localhost:8000"
    log "INFO" "Frontend running at: http://localhost:3000"
    
    # Display startup message
    echo
    echo -e "${GREEN}${BOLD}Application successfully started!${RESET}"
    echo -e "- Frontend: ${BLUE}${UNDERLINE}http://localhost:3000${RESET}"
    echo -e "- Backend API: ${BLUE}${UNDERLINE}http://localhost:8000/api/docs${RESET}"
    echo
    echo -e "${YELLOW}Press Ctrl+C to stop the backend server${RESET}"
    
    # Wait for Ctrl+C signal
    trap "kill $BACKEND_PID 2>/dev/null" EXIT
    wait $BACKEND_PID
}

# Parse command line arguments
parse_arguments() {
    # Default values
    MODE="dev"
    FORCE_REINSTALL=false
    START_APP=true
    VERBOSE=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dev)
                MODE="dev"
                shift
                ;;
            --prod)
                MODE="prod"
                shift
                ;;
            --docker)
                MODE="docker"
                shift
                ;;
            --reinstall)
                FORCE_REINSTALL=true
                shift
                ;;
            --no-start)
                START_APP=false
                shift
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                display_help
                exit 0
                ;;
            *)
                log "ERROR" "Unknown option: $1"
                display_help
                exit 1
                ;;
        esac
    done
}

# Display help information
display_help() {
    echo -e "${BOLD}Ultimate Llama AI Setup - v${VERSION}${RESET}"
    echo
    echo -e "Usage: $0 [options]"
    echo
    echo -e "Options:"
    echo -e "  --dev          Development mode (default)"
    echo -e "  --prod         Production mode"
    echo -e "  --docker       Docker mode"
    echo -e "  --reinstall    Force clean reinstall"
    echo -e "  --no-start     Don't start the application after setup"
    echo -e "  --verbose      Enable verbose output"
    echo -e "  -h, --help     Display this help message"
    echo
}

# Main function
main() {
    # Parse command-line arguments
    parse_arguments "$@"
    
    # Display welcome message
    clear
    display_llama_ascii
    print_header "ULTIMATE LLAMA AI SETUP (v${VERSION})"
    echo -e "${CYAN}Setting up ${PROJECT_NAME} in ${BOLD}${MODE}${RESET}${CYAN} mode...${RESET}\n"
    
    # Check requirements
    check_requirements
    
    # Install and verify dependencies
    ensure_homebrew
    ensure_python
    ensure_node
    ensure_docker  # Only if in docker mode
    install_cli_tools
    
    # Set up project
    create_project_structure
    setup_python_venv
    setup_node_env
    generate_application_files
    
    # Run the application
    run_application
}

# Execute the main function
main "$@" 