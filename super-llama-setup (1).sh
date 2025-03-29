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

# Master Setup Script for Ultimate Llama AI Full-Stack Application
# Optimized for M3 Max MacBook Pro
# Features:
#  - Full MLX integration for native Apple Silicon performance
#  - Interactive, colorful terminal UI with animations
#  - FastAPI Backend with SQLite, Datasette, JWT auth & structured logging
#  - Next.js Frontend with TailwindCSS and interactive widgets
#  - Llama-themed design and responsive UI components
#  - Complete Docker and Kubernetes support
#  - Advanced llamaindex document processing capabilities
#  - Terminal animations and progress indicators
#  - Optimized for Apple Silicon (M3 Max) performance
#
# Usage: ./super-llama-setup.sh [--dev|--prod|--docker]
# Default is development mode (--dev)
#
# Save this file as super-llama-setup.sh, then:
#    chmod +x super-llama-setup.sh
#    ./super-llama-setup.sh --dev

set -euo pipefail

# Terminal colors and formatting
BOLD="\033[1m"
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

# Determine mode: development (default), production, or docker
MODE="dev"
if [[ $# -gt 0 ]]; then
  case "$1" in
    --dev) MODE="dev" ;;
    --prod) MODE="prod" ;;
    --docker) MODE="docker" ;;
    *) 
      echo -e "${RED}${BOLD}Usage: $0 [--dev|--prod|--docker]${RESET}"
      exit 1 
      ;;
  esac
fi

# Llama ASCII art function
display_llama_ascii() {
  echo -e "${YELLOW}"
  echo -e "                ${BOLD}🦙 THE ULTIMATE LLAMA AI APP 🦙${RESET}${YELLOW}"
  echo "                          /"
  echo "                         /"
  echo "                        /"
  echo "      ,`','~-.,,,,_____/___________,,,,,\"  "
  echo "     /         \,-----~~~~~~------\"~\"\"    \\"
  echo "    (    ,~,    )                         |"
  echo "    /   (   )   \                         |"
  echo "   (     \_/     )                        |"
  echo "    \             \                       /"
  echo "     \~.,_____,~''/_________________________)"
  echo -e "${RESET}"
}

# Spinner animation while waiting for processes
spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Progress bar animation
progress_bar() {
  local duration=$1
  local progress=0
  local bar_length=40
  local sleep_duration=$(echo "scale=4; $duration/$bar_length" | bc)
  
  echo -ne "${CYAN}${BOLD}Progress: [${RESET}"
  
  for ((i=0; i<bar_length; i++)); do
    echo -ne "${BG_BLUE} ${RESET}"
    sleep $sleep_duration
  done
  
  echo -e "${CYAN}${BOLD}] Done!${RESET}"
}

# Check for Apple Silicon M-series
check_apple_silicon() {
  if [[ $(uname -m) != "arm64" ]]; then
    echo -e "${YELLOW}${BOLD}Warning: This script is optimized for Apple Silicon (M1/M2/M3).${RESET}"
    echo -e "${YELLOW}Some MLX optimizations may not work on your hardware.${RESET}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${RED}Setup aborted.${RESET}"
      exit 1
    fi
  else
    echo -e "${GREEN}${BOLD}✓ Apple Silicon detected - MLX optimizations will be enabled${RESET}"
  fi
}

# Check for required dependencies
check_dependencies() {
  echo -e "${CYAN}${BOLD}Checking dependencies...${RESET}"
  
  # Check for Python
  if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python3 is not installed. Installing...${RESET}"
    brew install python
  else
    local python_version=$(python3 --version | cut -d" " -f2)
    echo -e "${GREEN}✓ Python ${python_version} found${RESET}"
  fi

  # Check for Node.js
  if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Installing...${RESET}"
    brew install node
  else
    local node_version=$(node --version)
    echo -e "${GREEN}✓ Node.js ${node_version} found${RESET}"
  fi

  # Check for Docker if in docker mode
  if [[ "$MODE" == "docker" ]]; then
    if ! command -v docker &> /dev/null; then
      echo -e "${RED}Docker is not installed but required for --docker mode.${RESET}"
      echo -e "${YELLOW}Please install Docker Desktop from https://www.docker.com/products/docker-desktop/${RESET}"
      exit 1
    else
      local docker_version=$(docker --version)
      echo -e "${GREEN}✓ ${docker_version} found${RESET}"
    fi
  fi
  
  # Check for Homebrew
  if ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew is not installed. Installing...${RESET}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    local brew_version=$(brew --version | head -n 1)
    echo -e "${GREEN}✓ ${brew_version} found${RESET}"
  fi
}

# Display welcome message and initialization
welcome() {
  clear
  display_llama_ascii
  echo -e "${BG_MAGENTA}${WHITE}${BOLD} 🚀 ULTIMATE LLAMA AI FULL-STACK APPLICATION SETUP 🚀 ${RESET}"
  echo -e "${MAGENTA}${BOLD}Optimized for Apple Silicon M3 Max${RESET}\n"
  echo -e "${CYAN}Starting setup in ${BOLD}$MODE${RESET}${CYAN} mode...${RESET}\n"
  
  check_apple_silicon
  check_dependencies
  
  echo -e "\n${YELLOW}${BOLD}⚙️  Initializing setup process...${RESET}"
  sleep 1
}

# Define the project root directory
PROJECT_DIR="ultimate-llama-ai-app"
create_project_structure() {
  echo -e "\n${CYAN}${BOLD}Creating project directory structure in '${PROJECT_DIR}'...${RESET}"
  
  # Remove existing directory if it exists
  if [ -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}Directory '$PROJECT_DIR' already exists. Removing...${RESET}"
    rm -rf "$PROJECT_DIR"
  fi
  
  # Create root and subdirectories
  mkdir -p "$PROJECT_DIR"
  
  # -------------------------------
  # Backend directories
  # -------------------------------
  echo -e "${GREEN}Creating backend directories...${RESET}"
  mkdir -p "$PROJECT_DIR/backend/app/api"
  mkdir -p "$PROJECT_DIR/backend/app/core"
  mkdir -p "$PROJECT_DIR/backend/app/models"
  mkdir -p "$PROJECT_DIR/backend/app/services"
  mkdir -p "$PROJECT_DIR/backend/app/ml"
  mkdir -p "$PROJECT_DIR/backend/app/themes"
  mkdir -p "$PROJECT_DIR/backend/tests"
  mkdir -p "$PROJECT_DIR/backend/data"
  
  # -------------------------------
  # Frontend directories
  # -------------------------------
  echo -e "${GREEN}Creating frontend directories...${RESET}"
  mkdir -p "$PROJECT_DIR/frontend/pages"
  mkdir -p "$PROJECT_DIR/frontend/components/ui"
  mkdir -p "$PROJECT_DIR/frontend/components/llama"
  mkdir -p "$PROJECT_DIR/frontend/styles"
  mkdir -p "$PROJECT_DIR/frontend/public/images/llama"
  mkdir -p "$PROJECT_DIR/frontend/lib/hooks"
  mkdir -p "$PROJECT_DIR/frontend/lib/utils"
  mkdir -p "$PROJECT_DIR/frontend/lib/api"
  
  # -------------------------------
  # CLI Tool directories
  # -------------------------------
  echo -e "${GREEN}Creating CLI tool directories...${RESET}"
  mkdir -p "$PROJECT_DIR/llama-cli/src"
  mkdir -p "$PROJECT_DIR/llama-cli/themes"
  mkdir -p "$PROJECT_DIR/llama-cli/assets"
  
  # -------------------------------
  # Docker & Kubernetes directories
  # -------------------------------
  echo -e "${GREEN}Creating Docker & Kubernetes directories...${RESET}"
  mkdir -p "$PROJECT_DIR/docker/backend"
  mkdir -p "$PROJECT_DIR/docker/frontend"
  mkdir -p "$PROJECT_DIR/docker/cli"
  mkdir -p "$PROJECT_DIR/k8s/base"
  mkdir -p "$PROJECT_DIR/k8s/overlays/dev"
  mkdir -p "$PROJECT_DIR/k8s/overlays/prod"
  
  # -------------------------------
  # GitHub Actions
  # -------------------------------
  mkdir -p "$PROJECT_DIR/.github/workflows"
  
  # -------------------------------
  # Documentation
  # -------------------------------
  mkdir -p "$PROJECT_DIR/docs/backend"
  mkdir -p "$PROJECT_DIR/docs/frontend"
  mkdir -p "$PROJECT_DIR/docs/cli"
  mkdir -p "$PROJECT_DIR/docs/deployment"
  
  # -------------------------------
  # Logs & configs
  # -------------------------------
  mkdir -p "$PROJECT_DIR/logs"
  mkdir -p "$PROJECT_DIR/config"
  
  echo -e "${GREEN}✓ Project structure created successfully${RESET}"
  progress_bar 1
}

# Generate the backend code files
generate_backend_files() {
  echo -e "\n${BLUE}${BOLD}🔧 Generating backend files...${RESET}"
  
  # Main FastAPI application file
  cat > "$PROJECT_DIR/backend/app/main.py" << 'EOF'
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from app.api import auth, ai, health, index, mlx
from app.core.logging import setup_logging
from app.core.config import settings
import uvicorn
import logging
import time

# Setup structured logging
setup_logging()
logger = logging.getLogger(__name__)

app = FastAPI(
    title=settings.PROJECT_NAME,
    description=settings.PROJECT_DESCRIPTION,
    version=settings.VERSION,
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json"
)

# Middleware for request timing
@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    process_time = time.time() - start_time
    response.headers["X-Process-Time"] = str(process_time)
    return response

# CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Exception handler for graceful error responses
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Global exception: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"detail": "An unexpected error occurred", "type": str(type(exc).__name__)},
    )

# Include API routers
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(ai.router, prefix="/api/ai", tags=["AI Services"])
app.include_router(mlx.router, prefix="/api/mlx", tags=["MLX Models"])
app.include_router(index.router, prefix="/api/index", tags=["Document Indexing"])
app.include_router(health.router, prefix="/api/health", tags=["Health Checks"])

@app.get("/")
def read_root():
    logger.info("Root endpoint accessed")
    return {
        "message": f"Welcome to the {settings.PROJECT_NAME}",
        "version": settings.VERSION,
        "docs": "/api/docs"
    }

if __name__ == "__main__":
    uvicorn.run(
        "app.main:app", 
        host=settings.HOST, 
        port=settings.PORT, 
        reload=settings.DEBUG,
        log_level=settings.LOG_LEVEL.lower()
    )
EOF

  # Empty __init__.py files
  touch "$PROJECT_DIR/backend/app/__init__.py"
  touch "$PROJECT_DIR/backend/app/api/__init__.py"
  touch "$PROJECT_DIR/backend/app/models/__init__.py"
  touch "$PROJECT_DIR/backend/app/services/__init__.py"
  touch "$PROJECT_DIR/backend/app/ml/__init__.py"
  touch "$PROJECT_DIR/backend/app/themes/__init__.py"

  # Configuration
  cat > "$PROJECT_DIR/backend/app/core/config.py" << 'EOF'
from pydantic_settings import BaseSettings
from typing import List, Any, Dict, Optional, Union
from pathlib import Path
import os
import secrets
import json

class Settings(BaseSettings):
    # Base
    BASE_DIR: Path = Path(__file__).resolve().parent.parent.parent
    DEBUG: bool = os.getenv("DEBUG", "True").lower() == "true"
    VERSION: str = "1.0.0"
    PROJECT_NAME: str = "Ultimate Llama AI Application"
    PROJECT_DESCRIPTION: str = "Full-stack AI application with MLX integration optimized for Apple Silicon"
    
    # Server
    HOST: str = os.getenv("HOST", "0.0.0.0")
    PORT: int = int(os.getenv("PORT", "8000"))
    
    # CORS
    CORS_ORIGINS: List[str] = json.loads(
        os.getenv("CORS_ORIGINS", '["http://localhost:3000", "http://localhost:8000"]')
    )
    
    # Database
    DATABASE_URL: str = os.getenv(
        "DATABASE_URL", f"sqlite:///{BASE_DIR / 'data' / 'app.db'}"
    )
    
    # Authentication
    SECRET_KEY: str = os.getenv("SECRET_KEY", secrets.token_urlsafe(32))
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "60"))
    
    # MLX Configuration
    MLX_MODEL_PATH: str = os.getenv(
        "MLX_MODEL_PATH", str(BASE_DIR / "app" / "ml" / "models")
    )
    MLX_DEFAULT_MODEL: str = os.getenv("MLX_DEFAULT_MODEL", "llama-2-7b-mlx")
    MLX_QUANTIZATION: bool = os.getenv("MLX_QUANTIZATION", "True").lower() == "true"
    
    # Logging
    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")
    LOG_FILE: Path = BASE_DIR / "logs" / "backend.log"
    
    # LlamaIndex
    LLAMA_INDEX_STORAGE: Path = BASE_DIR / "data" / "indices"
    
    # Theme
    THEME_NAME: str = os.getenv("THEME_NAME", "llama-dark")
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

# Create a global settings object
settings = Settings()
EOF

  # Logging configuration
  cat > "$PROJECT_DIR/backend/app/core/logging.py" << 'EOF'
import logging
import sys
import json
from logging.handlers import RotatingFileHandler
from datetime import datetime
from app.core.config import settings

class ColorFormatter(logging.Formatter):
    """Colored formatter for console output"""
    
    COLORS = {
        'DEBUG': '\033[36m',     # Cyan
        'INFO': '\033[32m',      # Green
        'WARNING': '\033[33m',   # Yellow
        'ERROR': '\033[31m',     # Red
        'CRITICAL': '\033[41m',  # Red background
    }
    RESET = '\033[0m'
    
    def format(self, record):
        log_message = super().format(record)
        return f"{self.COLORS.get(record.levelname, '')}{log_message}{self.RESET}"

class JsonFormatter(logging.Formatter):
    """JSON formatter for structured logging to file"""
    
    def format(self, record):
        log_record = {
            "timestamp": datetime.fromtimestamp(record.created).isoformat(),
            "level": record.levelname,
            "module": record.module,
            "function": record.funcName,
            "line": record.lineno,
            "message": record.getMessage()
        }
        
        # Add exception info if available
        if record.exc_info:
            log_record["exception"] = {
                "type": record.exc_info[0].__name__,
                "message": str(record.exc_info[1]),
            }
            
        # Add extra fields if available
        if hasattr(record, "extra"):
            log_record["extra"] = record.extra
            
        return json.dumps(log_record)

def setup_logging():
    """Setup application logging with color console output and JSON file output"""
    
    # Create logger
    root_logger = logging.getLogger()
    root_logger.setLevel(settings.LOG_LEVEL)
    
    # Remove existing handlers
    for handler in root_logger.handlers[:]:
        root_logger.removeHandler(handler)
    
    # Console handler with colors
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(settings.LOG_LEVEL)
    console_format = "%(asctime)s - %(levelname)s - %(module)s - %(message)s"
    console_handler.setFormatter(ColorFormatter(console_format))
    root_logger.addHandler(console_handler)
    
    # File handler with JSON formatting
    try:
        # Create log directory if it doesn't exist
        settings.LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
        
        file_handler = RotatingFileHandler(
            settings.LOG_FILE,
            maxBytes=10485760,  # 10MB
            backupCount=5,
            encoding="utf-8"
        )
        file_handler.setLevel(settings.LOG_LEVEL)
        file_handler.setFormatter(JsonFormatter())
        root_logger.addHandler(file_handler)
    except Exception as e:
        console_handler.setLevel(logging.WARNING)
        root_logger.warning(f"Failed to setup file logging: {e}")
    
    # Suppress overly verbose logs from libraries
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)
    logging.getLogger("matplotlib").setLevel(logging.WARNING)
EOF

  # Security utilities
  cat > "$PROJECT_DIR/backend/app/core/security.py" << 'EOF'
from passlib.context import CryptContext
from datetime import datetime, timedelta
from jose import jwt, JWTError
from app.core.config import settings
from fastapi import HTTPException, status, Depends
from fastapi.security import OAuth2PasswordBearer
from typing import Dict, Any, Optional, Union

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# OAuth2 scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/token")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify that the plain password matches the hashed password"""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Generate a password hash from a plain password"""
    return pwd_context.hash(password)

def create_access_token(
    data: Dict[str, Any], 
    expires_delta: Optional[timedelta] = None
) -> str:
    """Create a JWT access token with an optional expiration time"""
    to_encode = data.copy()
    
    # Set expiration time
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode.update({"exp": expire})
    
    # Encode the JWT
    encoded_jwt = jwt.encode(
        to_encode, 
        settings.SECRET_KEY, 
        algorithm=settings.JWT_ALGORITHM
    )
    
    return encoded_jwt

def decode_access_token(token: str) -> Dict[str, Any]:
    """Decode and validate a JWT access token"""
    try:
        payload = jwt.decode(
            token, 
            settings.SECRET_KEY, 
            algorithms=[settings.JWT_ALGORITHM]
        )
        return payload
    except JWTError:
        return None

async def get_current_user(token: str = Depends(oauth2_scheme)) -> Dict[str, Any]:
    """Dependency to get the current authenticated user"""
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    payload = decode_access_token(token)
    if payload is None:
        raise credentials_exception
        
    username: str = payload.get("sub")
    if username is None:
        raise credentials_exception
        
    return payload
EOF

  # Database initialization
  cat > "$PROJECT_DIR/backend/app/core/database.py" << 'EOF'
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

# Create database engine
try:
    engine = create_engine(
        settings.DATABASE_URL, 
        connect_args={"check_same_thread": False} if "sqlite" in settings.DATABASE_URL else {},
    )
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    Base = declarative_base()
    logger.info(f"Database connection established with {settings.DATABASE_URL}")
except Exception as e:
    logger.error(f"Database connection error: {e}")
    raise

def get_db():
    """Dependency for getting database session"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
EOF

  # User model
  cat > "$PROJECT_DIR/backend/app/models/user.py" << 'EOF'
from pydantic import BaseModel, EmailStr, validator, Field
from typing import Optional
from datetime import datetime
import re

class UserBase(BaseModel):
    email: EmailStr
    username: str
    
    @validator('username')
    def username_alphanumeric(cls, v):
        assert re.match(r'^[a-zA-Z0-9_-]+, v), 'Username must be alphanumeric'
        return v

class UserCreate(UserBase):
    password: str
    
    @validator('password')
    def password_strength(cls, v):
        assert len(v) >= 8, 'Password must be at least 8 characters'
        assert any(c.isupper() for c in v), 'Password must contain an uppercase letter'
        assert any(c.islower() for c in v), 'Password must contain a lowercase letter'
        assert any(c.isdigit() for c in v), 'Password must contain a digit'
        return v

class UserInDB(UserBase):
    id: int
    hashed_password: str
    is_active: bool = True
    is_superuser: bool = False
    created_at: datetime
    updated_at: Optional[datetime] = None
    
    class Config:
        orm_mode = True

class User(UserBase):
    id: int
    is_active: bool
    created_at: datetime
    
    class Config:
        orm_mode = True

class UserUpdate(BaseModel):
    email: Optional[EmailStr] = None
    username: Optional[str] = None
    password: Optional[str] = None
    
    @validator('username')
    def username_alphanumeric(cls, v):
        if v is not None:
            assert re.match(r'^[a-zA-Z0-9_-]+, v), 'Username must be alphanumeric'
        return v

# Token models
class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"
    expires_in: int
    user_id: int
    username: str

class TokenPayload(BaseModel):
    sub: str
    exp: int
EOF

  # API Authentication
  cat > "$PROJECT_DIR/backend/app/api/auth.py" << 'EOF'
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from datetime import timedelta
from app.core.security import (
    verify_password, 
    get_password_hash, 
    create_access_token, 
    get_current_user
)
from app.core.config import settings
from app.core.database import get_db
from app.models.user import UserCreate, User, UserUpdate, Token
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

# Dummy user store - replace with database in production
FAKE_USERS_DB = {
    "llamauser": {
        "id": 1,
        "username": "llamauser",
        "email": "llama@example.com",
        "hashed_password": get_password_hash("LlamaAI123"),
        "is_active": True,
        "created_at": "2025-01-01T00:00:00"
    }
}

@router.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    """OAuth2 compatible token login, get an access token for future requests"""
    user = FAKE_USERS_DB.get(form_data.username)
    if not user or not verify_password(form_data.password, user["hashed_password"]):
        logger.warning(f"Failed login attempt for user: {form_data.username}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user["username"]},
        expires_delta=access_token_expires
    )
    
    logger.info(f"User {form_data.username} logged in successfully")
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "expires_in": settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,
        "user_id": user["id"],
        "username": user["username"]
    }

@router.get("/me", response_model=User)
async def read_users_me(current_user: dict = Depends(get_current_user)):
    """Get current user information"""
    username = current_user.get("sub")
    user = FAKE_USERS_DB.get(username)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
EOF

  # Health Check API
  cat > "$PROJECT_DIR/backend/app/api/health.py" << 'EOF'
from fastapi import APIRouter, Depends
from app.core.database import get_db
from sqlalchemy.orm import Session
import psutil
import platform
import logging
from datetime import datetime

router = APIRouter()
logger = logging.getLogger(__name__)

@router.get("/")
def health_check():
    """Basic health check endpoint"""
    return {"status": "healthy", "timestamp": datetime.utcnow().isoformat()}

@router.get("/detailed")
def detailed_health():
    """Detailed health check with system information"""
    # Get system info
    system_info = {
        "system": platform.system(),
        "platform": platform.platform(),
        "python_version": platform.python_version(),
        "cpu_count": psutil.cpu_count(),
        "cpu_percent": psutil.cpu_percent(),
        "memory_percent": psutil.virtual_memory().percent,
        "disk_percent": psutil.disk_usage('/').percent
    }
    
    # Add Apple Silicon specific info if applicable
    if platform.system() == "Darwin" and platform.machine() == "arm64":
        system_info["apple_silicon"] = True
        system_info["processor"] = "Apple Silicon"
    
    logger.debug(f"Detailed health check performed: {system_info}")
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "system_info": system_info
    }
EOF

  # AI Service API
  cat > "$PROJECT_DIR/backend/app/api/ai.py" << 'EOF'
from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from app.models.user import User
from app.core.security import get_current_user
from app.services import ai_service
from pydantic import BaseModel, Field
from typing import List, Dict, Any, Optional
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

class ChatMessage(BaseModel):
    role: str = Field(..., description="Role of the message sender (user or assistant)")
    content: str = Field(..., description="Content of the message")

class ChatRequest(BaseModel):
    messages: List[ChatMessage] = Field(..., description="List of messages in the conversation")
    max_tokens: Optional[int] = Field(512, description="Maximum number of tokens to generate")
    temperature: Optional[float] = Field(0.7, description="Temperature for sampling")
    top_p: Optional[float] = Field(0.9, description="Top-p sampling parameter")

class ChatResponse(BaseModel):
    message: ChatMessage
    model: str
    usage: Dict[str, int]

class ExtractRequest(BaseModel):
    text: str = Field(..., description="Text to extract information from")
    fields: List[str] = Field(..., description="Fields to extract")

@router.post("/chat", response_model=ChatResponse)
async def chat_endpoint(
    request: ChatRequest,
    current_user: dict = Depends(get_current_user)
):
    """Generate a chat response using the AI model"""
    try:
        logger.info(f"Chat request received from user {current_user.get('sub')}")
        result = await ai_service.generate_chat_response(
            messages=request.messages,
            max_tokens=request.max_tokens,
            temperature=request.temperature,
            top_p=request.top_p
        )
        return result
    except Exception as e:
        logger.error(f"Error in chat endpoint: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/extract", response_model=Dict[str, Any])
async def extract_information(
    request: ExtractRequest,
    current_user: dict = Depends(get_current_user)
):
    """Extract structured information from text"""
    try:
        logger.info(f"Information extraction request from user {current_user.get('sub')}")
        result = await ai_service.extract_information(
            text=request.text,
            fields=request.fields
        )
        return result
    except Exception as e:
        logger.error(f"Error in extract endpoint: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/summarize")
async def summarize_text(
    text: str,
    current_user: dict = Depends(get_current_user)
):
    """Generate a summary of the provided text"""
    try:
        logger.info(f"Summarization request from user {current_user.get('sub')}")
        result = await ai_service.summarize_text(text)
        return {"summary": result}
    except Exception as e:
        logger.error(f"Error in summarize endpoint: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))
EOF

  # MLX Integration API 
  cat > "$PROJECT_DIR/backend/app/api/mlx.py" << 'EOF'
from fastapi import APIRouter, Depends, HTTPException, File, UploadFile, Form
from app.core.security import get_current_user
from app.services import mlx_service
from pydantic import BaseModel, Field
from typing import List, Dict, Any, Optional
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

class GenerationRequest(BaseModel):
    prompt: str = Field(..., description="Input prompt for text generation")
    max_tokens: Optional[int] = Field(512, description="Maximum tokens to generate")
    temperature: Optional[float] = Field(0.7, description="Temperature for sampling")
    model_name: Optional[str] = None
    quantization: Optional[bool] = None

class GenerationResponse(BaseModel):
    text: str
    model_name: str
    generation_time: float
    prompt_tokens: int
    generated_tokens: int

class ModelInfo(BaseModel):
    name: str
    size: str
    quantized: bool
    description: str

@router.post("/generate", response_model=GenerationResponse)
async def generate_text(
    request: GenerationRequest,
    current_user: dict = Depends(get_current_user)
):
    """Generate text using MLX-powered LLM models optimized for Apple Silicon"""
    try:
        logger.info(f"MLX generation request from user {current_user.get('sub')}")
        result = await mlx_service.generate_text(
            prompt=request.prompt, 
            max_tokens=request.max_tokens,
            temperature=request.temperature,
            model_name=request.model_name,
            quantization=request.quantization
        )
        return result
    except Exception as e:
        logger.error(f"Error in MLX generation: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/models", response_model=List[ModelInfo])
async def list_available_models(current_user: dict = Depends(get_current_user)):
    """List all available MLX models"""
    try:
        logger.info(f"Models list requested by user {current_user.get('sub')}")
        models = await mlx_service.list_models()
        return models
    except Exception as e:
        logger.error(f"Error listing models: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/image-to-text")
async def image_to_text(
    image: UploadFile = File(...),
    prompt: str = Form("Describe this image:"),
    current_user: dict = Depends(get_current_user)
):
    """Generate text description from an image using multimodal MLX models"""
    try:
        logger.info(f"Image-to-text request from user {current_user.get('sub')}")
        if not image.content_type.startswith("image/"):
            raise HTTPException(status_code=400, detail="File must be an image")
            
        contents = await image.read()
        result = await mlx_service.process_image(contents, prompt)
        return {"description": result}
    except Exception as e:
        logger.error(f"Error in image-to-text: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))
EOF

  # LlamaIndex API
  cat > "$PROJECT_DIR/backend/app/api/index.py" << 'EOF'
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form, BackgroundTasks
from app.core.security import get_current_user
from app.services import llama_index_service
from pydantic import BaseModel, Field
from typing import List, Dict, Any, Optional
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

class QueryRequest(BaseModel):
    query: str = Field(..., description="Query to search in the document index")
    index_name: Optional[str] = Field(None, description="Name of the index to query")
    similarity_top_k: Optional[int] = Field(3, description="Number of documents to retrieve")

class IndexResponse(BaseModel):
    result: str
    source_documents: List[Dict[str, Any]]
    query_time: float

class IndexInfo(BaseModel):
    name: str
    document_count: int
    created_at: str
    description: Optional[str] = None

@router.post("/query", response_model=IndexResponse)
async def query_index(
    request: QueryRequest,
    current_user: dict = Depends(get_current_user)
):
    """Query the document index with natural language"""
    try:
        logger.info(f"Index query request from user {current_user.get('sub')}")
        result = await llama_index_service.query_index(
            query=request.query,
            index_name=request.index_name,
            similarity_top_k=request.similarity_top_k
        )
        return result
    except Exception as e:
        logger.error(f"Error querying index: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/upload")
async def upload_document(
    background_tasks: BackgroundTasks,
    file: UploadFile = File(...),
    index_name: str = Form(...),
    description: Optional[str] = Form(None),
    current_user: dict = Depends(get_current_user)
):
    """Upload and index a document"""
    try:
        logger.info(f"Document upload request from user {current_user.get('sub')}")
        contents = await file.read()
        
        # Process indexing in the background
        background_tasks.add_task(
            llama_index_service.index_document,
            file_content=contents,
            file_name=file.filename,
            index_name=index_name,
            description=description
        )
        
        return {
            "message": f"Document '{file.filename}' is being indexed in the background",
            "index_name": index_name
        }
    except Exception as e:
        logger.error(f"Error indexing document: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/indices", response_model=List[IndexInfo])
async def list_indices(current_user: dict = Depends(get_current_user)):
    """List available document indices"""
    try:
        logger.info(f"Indices list requested by user {current_user.get('sub')}")
        indices = await llama_index_service.list_indices()
        return indices
    except Exception as e:
        logger.error(f"Error listing indices: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))
EOF

  # AI Service Implementation
  cat > "$PROJECT_DIR/backend/app/services/ai_service.py" << 'EOF'
import asyncio
import logging
import json
import time
from typing import List, Dict, Any
from app.models.user import ChatMessage
from app.core.config import settings

logger = logging.getLogger(__name__)

# In a production app, you would use a real AI service
# This is a simplified implementation for demonstration
async def generate_chat_response(
    messages: List[ChatMessage],
    max_tokens: int = 512,
    temperature: float = 0.7,
    top_p: float = 0.9
) -> Dict[str, Any]:
    """Generate a response from the chat model"""
    logger.info(f"Generating chat response with {len(messages)} messages")
    
    # Simulate processing time
    await asyncio.sleep(1)
    
    # Get the last user message
    user_message = next((m for m in reversed(messages) if m.role == "user"), None)
    
    if not user_message:
        raise ValueError("No user message found in the conversation")
    
    # Generate a simple response based on the user's message
    response_text = f"This is a simulated AI response to: '{user_message.content}'"
    
    # Add llama-themed responses
    if "llama" in user_message.content.lower():
        response_text = "🦙 As a Llama-themed AI, I'm happy to help with your request! "
        response_text += "Llamas are amazing animals known for their intelligence and adaptability. "
        response_text += "Just like real llamas, this AI application is designed to be versatile and powerful. "
        response_text += "How else can I assist you today? 🦙"
    
    logger.debug(f"Generated response: {response_text}")
    
    return {
        "message": ChatMessage(role="assistant", content=response_text),
        "model": "llama-ai-simulated",
        "usage": {
            "prompt_tokens": sum(len(m.content.split()) for m in messages),
            "completion_tokens": len(response_text.split()),
            "total_tokens": sum(len(m.content.split()) for m in messages) + len(response_text.split())
        }
    }

async def extract_information(text: str, fields: List[str]) -> Dict[str, Any]:
    """Extract structured information from text"""
    logger.info(f"Extracting information with fields: {fields}")
    
    # Simulate processing
    await asyncio.sleep(1)
    
    # Simple extraction logic (in production, use a real extraction model)
    result = {}
    for field in fields:
        # Find any mention of the field in the text
        field_lower = field.lower()
        if field_lower in text.lower():
            # Extract a sentence containing the field
            sentences = text.split('. ')
            for sentence in sentences:
                if field_lower in sentence.lower():
                    result[field] = sentence.strip()
                    break
        else:
            result[field] = f"No {field} found in the text"
    
    logger.debug(f"Extracted information: {result}")
    return result

async def summarize_text(text: str) -> str:
    """Generate a summary of the provided text"""
    logger.info(f"Summarizing text of length {len(text)}")
    
    # Simulate processing
    await asyncio.sleep(1.5)
    
    # Simple summarization (in production, use a real summarization model)
    words = text.split()
    summary_length = min(30, len(words) // 4)
    summary = ' '.join(words[:summary_length]) + "..."
    
    logger.debug(f"Generated summary: {summary}")
    return summary
EOF

  # MLX Service Implementation
  cat > "$PROJECT_DIR/backend/app/services/mlx_service.py" << 'EOF'
import asyncio
import logging
import json
import time
import os
from typing import List, Dict, Any, Optional
from pathlib import Path
from app.core.config import settings

logger = logging.getLogger(__name__)

# In a real application, you would import MLX and implement real inference
# This is a simplified mock implementation for demonstration
async def generate_text(
    prompt: str, 
    max_tokens: int = 512, 
    temperature: float = 0.7,
    model_name: Optional[str] = None,
    quantization: Optional[bool] = None
) -> Dict[str, Any]:
    """Generate text using an MLX-powered LLM optimized for Apple Silicon"""
    start_time = time.time()
    
    # Use default model if not specified
    model_name = model_name or settings.MLX_DEFAULT_MODEL
    logger.info(f"Generating text with model {model_name}")
    
    # Apply quantization setting
    use_quantization = settings.MLX_QUANTIZATION if quantization is None else quantization
    
    # Simulate longer processing for longer prompts or higher temperature
    processing_time = 0.5 + (len(prompt) / 500) + (temperature * 0.5)
    await asyncio.sleep(processing_time)
    
    # Generate a mock response
    if "llama" in prompt.lower():
        response = (
            "🦙 Llamas are amazing creatures native to South America, specifically the Andes Mountains region. "
            "They're members of the camelid family, which also includes alpacas, guanacos, and vicuñas. "
            "Llamas have been domesticated for thousands of years and were used by the Incas as pack animals. "
            "They're known for their intelligence, gentle nature, and ability to carry up to 25-30% of their body weight. "
            "Llamas are also social animals that typically live in herds."
        )
    else:
        # Generic response based on prompt
        response = f"This is a simulated MLX-powered response to: '{prompt}'"
        
        # Add some fake AI-sounding content
        response += (
            " The integration of neural networks with transformer architecture allows for efficient "
            "processing of sequential data. The model leverages attention mechanisms to focus on relevant "
            "context within the input prompt, generating coherent and contextually appropriate text. "
            "Optimized for Apple Silicon using MLX framework, this inference runs natively on the Neural Engine."
        )
    
    # Calculate tokens (very simplified)
    prompt_tokens = len(prompt.split())
    generated_tokens = len(response.split())
    
    generation_time = time.time() - start_time
    
    return {
        "text": response,
        "model_name": model_name + ("-quantized" if use_quantization else ""),
        "generation_time": generation_time,
        "prompt_tokens": prompt_tokens,
        "generated_tokens": generated_tokens
    }

async def list_models() -> List[Dict[str, Any]]:
    """List available MLX models"""
    logger.info("Listing available MLX models")
    
    # Simulate processing
    await asyncio.sleep(0.2)
    
    # Mock model data
    models = [
        {
            "name": "llama-2-7b-mlx",
            "size": "7B parameters",
            "quantized": False,
            "description": "Base Llama 2 model optimized for MLX on Apple Silicon"
        },
        {
            "name": "llama-2-7b-mlx-quantized",
            "size": "7B parameters (4-bit quantized)",
            "quantized": True,
            "description": "Quantized Llama 2 model for faster inference and lower memory usage"
        },
        {
            "name": "llama-2-13b-mlx",
            "size": "13B parameters",
            "quantized": False,
            "description": "Larger Llama 2 model with enhanced capabilities"
        },
        {
            "name": "mistral-7b-mlx",
            "size": "7B parameters",
            "quantized": False,
            "description": "Mistral 7B model optimized for MLX"
        }
    ]
    
    return models

async def process_image(image_data: bytes, prompt: str) -> str:
    """Process an image and generate a text description using a multimodal model"""
    logger.info(f"Processing image with prompt: {prompt}")
    
    # Simulate processing time for a multimodal model
    await asyncio.sleep(1.5)
    
    # Generate a mock description
    description = (
        "This image appears to show a scenic landscape with mountains in the background. "
        "The foreground contains what looks like a meadow with some trees. "
        "The lighting suggests it might be taken during golden hour, "
        "creating a warm atmosphere throughout the scene."
    )
    
    if "llama" in prompt.lower():
        description = (
            "The image shows a majestic llama standing in an Andean landscape. "
            "The llama has a thick, wooly coat in a light brown color with white patches. "
            "It stands proudly against a backdrop of mountains, with its characteristic "
            "alert ears and calm, intelligent expression. The animal appears to be domesticated, "
            "possibly used for wool or as a pack animal by local communities."
        )
    
    logger.debug(f"Generated image description: {description}")
    return description
EOF

  # LlamaIndex Service Implementation
  cat > "$PROJECT_DIR/backend/app/services/llama_index_service.py" << 'EOF'
import asyncio
import logging
import json
import time
from datetime import datetime
from typing import List, Dict, Any, Optional
from pathlib import Path
from app.core.config import settings

logger = logging.getLogger(__name__)

# In a real application, you would import llama-index and implement real indexing
# This is a simplified mock implementation for demonstration
async def query_index(
    query: str,
    index_name: Optional[str] = None,
    similarity_top_k: int = 3
) -> Dict[str, Any]:
    """Query the document index with natural language"""
    start_time = time.time()
    logger.info(f"Querying index {index_name} with: {query}")
    
    # Simulate processing
    await asyncio.sleep(1)
    
    # Mock response data
    mock_documents = [
        {
            "text": "Llamas are members of the camelid family and are native to the Andes mountains of South America.",
            "metadata": {
                "file_name": "llama_facts.pdf",
                "page": 1
            }
        },
        {
            "text": "Llamas can grow to a height of 5.9 feet (1.8 m) and weigh up to 440 pounds (200 kg).",
            "metadata": {
                "file_name": "llama_facts.pdf",
                "page": 2
            }
        },
        {
            "text": "MLX is a machine learning framework designed specifically for Apple Silicon, optimizing performance on M-series chips.",
            "metadata": {
                "file_name": "mlx_documentation.txt",
                "section": "Introduction"
            }
        }
    ]
    
    # Filter documents based on query relevance (simplified)
    relevant_docs = []
    for doc in mock_documents:
        if any(term in doc["text"].lower() for term in query.lower().split()):
            relevant_docs.append(doc)
    
    # If no relevant docs found, return subset of all docs
    if not relevant_docs:
        relevant_docs = mock_documents[:similarity_top_k]
    else:
        relevant_docs = relevant_docs[:similarity_top_k]
    
    # Generate a response based on the query and documents
    if "llama" in query.lower():
        response = (
            "Llamas are fascinating camelids native to South America's Andes mountains. "
            "They are relatively large animals, growing up to 5.9 feet tall and weighing "
            "as much as 440 pounds. They have been domesticated for thousands of years "
            "and are valued for their wool, meat, and use as pack animals."
        )
    elif "mlx" in query.lower():
        response = (
            "MLX is Apple's machine learning framework optimized specifically for Apple Silicon. "
            "It leverages the Neural Engine in M-series chips to provide high-performance, "
            "energy-efficient machine learning operations. MLX is designed to accelerate "
            "both training and inference workflows on Mac devices."
        )
    else:
        response = f"Based on the indexed documents, the answer to '{query}' appears to be related to "
        response += relevant_docs[0]["text"] if relevant_docs else "not found in the current index."
    
    query_time = time.time() - start_time
    
    return {
        "result": response,
        "source_documents": relevant_docs,
        "query_time": query_time
    }

async def index_document(
    file_content: bytes,
    file_name: str,
    index_name: str,
    description: Optional[str] = None
) -> bool:
    """Index a document for future querying"""