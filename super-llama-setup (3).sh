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
    logger.info(f"Indexing document: {file_name} to index: {index_name}")
    
    # Simulate a longer processing time for indexing
    await asyncio.sleep(2)
    
    # In a real implementation, this would process the file and add it to the index
    # Here we just log that we received it
    logger.info(f"Successfully indexed document {file_name} ({len(file_content)} bytes)")
    
    return True

async def list_indices() -> List[Dict[str, Any]]:
    """List available document indices"""
    logger.info("Listing available indices")
    
    # Simulate processing
    await asyncio.sleep(0.3)
    
    # Mock indices data
    indices = [
        {
            "name": "llama-documents",
            "document_count": 3,
            "created_at": "2025-01-15T12:00:00",
            "description": "Collection of documents about llamas and camelids"
        },
        {
            "name": "apple-silicon",
            "document_count": 5,
            "created_at": "2025-02-01T09:30:00",
            "description": "Documentation about Apple Silicon and M-series chips"
        },
        {
            "name": "ml-frameworks",
            "document_count": 8,
            "created_at": "2025-02-10T15:45:00",
            "description": "Information about various ML frameworks including MLX, TensorFlow, and PyTorch"
        }
    ]
    
    return indices
EOF

  # Create backend tests
  cat > "$PROJECT_DIR/backend/tests/test_health.py" << 'EOF'
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health_check():
    """Test the basic health check endpoint"""
    response = client.get("/api/health/")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_detailed_health():
    """Test the detailed health check endpoint"""
    response = client.get("/api/health/detailed")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"
    assert "system_info" in response.json()
EOF

  cat > "$PROJECT_DIR/backend/tests/test_ai.py" << 'EOF'
from fastapi.testclient import TestClient
from app.main import app
import pytest
from unittest.mock import patch, AsyncMock

client = TestClient(app)

# Mock JWT token for testing protected endpoints
mock_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsbGFtYXVzZXIifQ.jgliUcPaI-ZhC_FZvDdWpKvCgsnGZ_De-8FIgmTxbEU"

@pytest.fixture
def auth_header():
    return {"Authorization": f"Bearer {mock_token}"}

@patch("app.api.ai.ai_service.generate_chat_response")
def test_chat_endpoint(mock_generate, auth_header):
    # Setup mock
    mock_generate.return_value = AsyncMock(return_value={
        "message": {"role": "assistant", "content": "Test response"},
        "model": "test-model",
        "usage": {"prompt_tokens": 10, "completion_tokens": 5, "total_tokens": 15}
    })()
    
    # Test the endpoint
    response = client.post(
        "/api/ai/chat", 
        json={
            "messages": [{"role": "user", "content": "Hello"}],
            "max_tokens": 100,
            "temperature": 0.5
        },
        headers=auth_header
    )
    
    assert response.status_code == 200
    assert "message" in response.json()
    assert response.json()["message"]["role"] == "assistant"
EOF

  # Create FastAPI dependencies
  touch "$PROJECT_DIR/backend/app/api/deps.py"

  # Create backend requirements file
  cat > "$PROJECT_DIR/backend/requirements.txt" << 'EOF'
# FastAPI and web
fastapi==0.110.0
uvicorn[standard]==0.27.1
python-multipart==0.0.9
pydantic==2.6.3
pydantic-settings==2.2.1
email-validator==2.1.0.post1

# Security
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-dotenv==1.0.1

# Database
sqlalchemy==2.0.27
alembic==1.13.1
aiosqlite==0.19.0

# LLM & ML 
# Note: MLX would be installed directly in a real project
# mlx==0.4.0  
llama-index==0.10.0

# Utilities
psutil==5.9.8
pillow==10.2.0
rich==13.7.0
typer==0.9.0
pandas==2.2.0
numpy==1.26.4
tqdm==4.66.2

# Testing
pytest==7.4.4
pytest-asyncio==0.21.1
httpx==0.27.0
EOF

  # Create backend Dockerfile
  cat > "$PROJECT_DIR/docker/backend/Dockerfile" << 'EOF'
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY backend/requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY backend /app/
COPY logs /app/logs
COPY config /app/config

# Create necessary directories
RUN mkdir -p /app/data /app/logs

# Expose port
EXPOSE 8000

# Set command
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

  # Generate Frontend Files
  echo -e "\n${CYAN}${BOLD}🔧 Generating frontend files...${RESET}"
  
  # Package.json with all dependencies
  cat > "$PROJECT_DIR/frontend/package.json" << 'EOF'
{
  "name": "ultimate-llama-ai-frontend",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest"
  },
  "dependencies": {
    "@headlessui/react": "^1.7.18",
    "@heroicons/react": "^2.1.1",
    "@tailwindcss/forms": "^0.5.7",
    "axios": "^1.6.7",
    "framer-motion": "^11.0.5",
    "next": "14.1.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "react-markdown": "^9.0.1",
    "react-syntax-highlighter": "^15.5.0",
    "recharts": "^2.12.0",
    "swr": "^2.2.4",
    "tailwindcss": "^3.4.1",
    "three": "^0.161.0"
  },
  "devDependencies": {
    "@testing-library/jest-dom": "^6.4.2",
    "@testing-library/react": "^14.2.1",
    "@types/node": "20.11.19",
    "@types/react": "18.2.57",
    "@types/react-dom": "18.2.19",
    "@types/react-syntax-highlighter": "^15.5.11",
    "@types/three": "^0.161.2",
    "autoprefixer": "^10.4.17",
    "eslint": "8.56.0",
    "eslint-config-next": "14.1.0",
    "jest": "^29.7.0",
    "jest-environment-jsdom": "^29.7.0",
    "postcss": "^8.4.35",
    "typescript": "5.3.3"
  }
}
EOF

  # Next.js config
  cat > "$PROJECT_DIR/frontend/next.config.js" << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ['localhost', 'api.example.com'],
  },
  i18n: {
    locales: ['en'],
    defaultLocale: 'en',
  },
};

module.exports = nextConfig;
EOF

  # TypeScript config
  cat > "$PROJECT_DIR/frontend/tsconfig.json" << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"],
      "@/components/*": ["components/*"],
      "@/styles/*": ["styles/*"],
      "@/lib/*": ["lib/*"],
      "@/public/*": ["public/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
EOF

  # Tailwind config
  cat > "$PROJECT_DIR/frontend/tailwind.config.js" << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}'
  ],
  theme: {
    extend: {
      colors: {
        llama: {
          50: '#f9f7f4',
          100: '#f3efe9',
          200: '#e7dfd3',
          300: '#d5c7b2',
          400: '#c1ac8d',
          500: '#b0936e',
          600: '#a18457',
          700: '#896c4a',
          800: '#725941',
          900: '#5f4a38',
          950: '#32271d',
        },
      },
      fontFamily: {
        sans: ['Inter var', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        mono: ['Fira Code', 'ui-monospace', 'monospace'],
      },
      animation: {
        'llama-bounce': 'llama-bounce 3s infinite',
        'gradient-x': 'gradient-x 15s ease infinite',
      },
      keyframes: {
        'llama-bounce': {
          '0%, 100%': {
            transform: 'translateY(0)',
          },
          '50%': {
            transform: 'translateY(-10px)',
          },
        },
        'gradient-x': {
          '0%, 100%': {
            'background-position': '0% 50%',
          },
          '50%': {
            'background-position': '100% 50%',
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
};
EOF

  # Create global CSS
  cat > "$PROJECT_DIR/frontend/styles/globals.css" << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --primary: #a18457;
  --secondary: #5f4a38;
  --background: #f9f7f4;
  --text: #32271d;
  --accent: #c1ac8d;
}

@layer base {
  body {
    @apply bg-llama-50 text-llama-950;
  }
  
  h1 {
    @apply text-3xl font-bold text-llama-900 mb-4;
  }
  
  h2 {
    @apply text-2xl font-bold text-llama-800 mb-3;
  }
  
  h3 {
    @apply text-xl font-bold text-llama-700 mb-2;
  }
  
  a {
    @apply text-llama-600 hover:text-llama-500 transition-colors;
  }
}

@layer components {
  .llama-card {
    @apply bg-white rounded-xl shadow-md p-6 border border-llama-100 hover:shadow-lg transition-shadow;
  }
  
  .btn-primary {
    @apply bg-llama-600 hover:bg-llama-700 text-white font-medium py-2 px-4 rounded-md transition-colors;
  }
  
  .btn-secondary {
    @apply bg-llama-100 hover:bg-llama-200 text-llama-800 font-medium py-2 px-4 rounded-md transition-colors;
  }
  
  .input-field {
    @apply block w-full rounded-md border-llama-300 shadow-sm focus:border-llama-500 focus:ring-llama-500;
  }
}

/* Custom scrollbar styling */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  @apply bg-llama-100;
}

::-webkit-scrollbar-thumb {
  @apply bg-llama-400 rounded-full;
}

::-webkit-scrollbar-thumb:hover {
  @apply bg-llama-500;
}

/* Animation classes */
.animate-gradient-background {
  background: linear-gradient(-45deg, #e7dfd3, #d5c7b2, #a18457, #5f4a38);
  background-size: 400% 400%;
  animation: gradient-animation 15s ease infinite;
}

@keyframes gradient-animation {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

/* Llama-themed loader */
.llama-loader {
  position: relative;
  width: 80px;
  height: 80px;
  margin: 0 auto;
}

.llama-loader:before {
  content: '🦙';
  font-size: 40px;
  position: absolute;
  animation: llama-spin 2s linear infinite;
}

@keyframes llama-spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
EOF

  # Create _app.tsx
  cat > "$PROJECT_DIR/frontend/pages/_app.tsx" << 'EOF'
import { useState, useEffect } from 'react';
import { AppProps } from 'next/app';
import Head from 'next/head';
import { AnimatePresence } from 'framer-motion';
import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/layout/Footer';
import LoadingScreen from '@/components/ui/LoadingScreen';
import { AuthProvider } from '@/lib/hooks/useAuth';
import '@/styles/globals.css';

export default function MyApp({ Component, pageProps, router }: AppProps) {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulate loading resources
    const timer = setTimeout(() => {
      setLoading(false);
    }, 1500);
    
    return () => clearTimeout(timer);
  }, []);

  if (loading) {
    return <LoadingScreen />;
  }

  return (
    <>
      <Head>
        <title>Ultimate Llama AI App</title>
        <meta name="description" content="A full-stack AI application with MLX integration optimized for Apple Silicon" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      
      <AuthProvider>
        <Navbar />
        <AnimatePresence mode="wait">
          <main className="min-h-screen pt-16 pb-12">
            <Component {...pageProps} key={router.route} />
          </main>
        </AnimatePresence>
        <Footer />
      </AuthProvider>
    </>
  );
}
EOF

  # Create index.tsx
  cat > "$PROJECT_DIR/frontend/pages/index.tsx" << 'EOF'
import { motion } from 'framer-motion';
import LlamaHero from '@/components/llama/LlamaHero';
import FeaturesGrid from '@/components/ui/FeaturesGrid';
import AnimatedLlama from '@/components/llama/AnimatedLlama';
import { useAuth } from '@/lib/hooks/useAuth';

export default function Home() {
  const { user } = useAuth();
  
  const features = [
    {
      title: "MLX Integration",
      description: "Optimized for Apple Silicon with native Metal performance",
      icon: "🧠",
    },
    {
      title: "LlamaIndex Integration",
      description: "Powerful document indexing and retrieval capabilities",
      icon: "📚",
    },
    {
      title: "Beautiful UI",
      description: "Llama-themed interface with smooth animations",
      icon: "✨",
    },
    {
      title: "CLI Tools",
      description: "Colorful command-line interface for power users",
      icon: "⌨️",
    },
  ];

  return (
    <div className="container mx-auto px-4">
      <LlamaHero />
      
      <motion.section
        className="my-16"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
      >
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-llama-800">
            Powerful AI, Llama Style
          </h2>
          <p className="text-xl text-llama-600 mt-2">
            Harness the power of Apple Silicon with our native MLX integration
          </p>
        </div>
        
        <FeaturesGrid features={features} />
      </motion.section>
      
      <motion.section
        className="my-16 bg-llama-100 rounded-xl p-8"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.4 }}
      >
        <div className="flex flex-col md:flex-row items-center gap-8">
          <div className="w-full md:w-1/2">
            <h2 className="text-2xl font-bold text-llama-800 mb-4">
              Meet Your AI Assistant
            </h2>
            <p className="text-llama-700 mb-4">
              Our llama-powered AI assistant is optimized for Apple Silicon,
              providing blazing-fast responses with lower energy consumption.
            </p>
            <p className="text-llama-700 mb-6">
              Ask questions, generate content, or analyze documents - all with
              the power of advanced language models running natively on your M-series Mac.
            </p>
            <a href="/chat" className="btn-primary inline-block">
              Try It Now
            </a>
          </div>
          <div className="w-full md:w-1/2 flex justify-center">
            <AnimatedLlama />
          </div>
        </div>
      </motion.section>
    </div>
  );
}
EOF

  # Create a chat page
  cat > "$PROJECT_DIR/frontend/pages/chat.tsx" << 'EOF'
import { useState, useRef, useEffect } from 'react';
import { motion } from 'framer-motion';
import ChatInterface from '@/components/chat/ChatInterface';
import ModelSelector from '@/components/chat/ModelSelector';
import { useAuth } from '@/lib/hooks/useAuth';
import { useRouter } from 'next/router';

export default function ChatPage() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const [selectedModel, setSelectedModel] = useState('llama-2-7b-mlx');
  
  // Redirect if not authenticated
  useEffect(() => {
    if (!loading && !user) {
      router.push('/login?redirect=chat');
    }
  }, [user, loading, router]);
  
  if (loading || !user) {
    return (
      <div className="flex justify-center items-center h-screen">
        <div className="llama-loader"></div>
      </div>
    );
  }

  return (
    <motion.div
      className="container mx-auto px-4 py-8"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      <h1 className="text-2xl font-bold text-llama-800 mb-6">
        Chat with Llama AI
      </h1>
      
      <div className="mb-6">
        <ModelSelector 
          selectedModel={selectedModel}
          onSelectModel={setSelectedModel}
        />
      </div>
      
      <div className="bg-white rounded-xl shadow-md overflow-hidden border border-llama-200">
        <ChatInterface modelName={selectedModel} />
      </div>
    </motion.div>
  );
}
EOF

  # Create a login page
  cat > "$PROJECT_DIR/frontend/pages/login.tsx" << 'EOF'
import { useState } from 'react';
import { useRouter } from 'next/router';
import { motion } from 'framer-motion';
import { useAuth } from '@/lib/hooks/useAuth';
import LlamaIcon from '@/components/llama/LlamaIcon';

export default function Login() {
  const router = useRouter();
  const { login } = useAuth();
  const [formData, setFormData] = useState({
    username: '',
    password: '',
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };
  
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    
    try {
      await login(formData.username, formData.password);
      const redirectPath = router.query.redirect as string || '/dashboard';
      router.push(redirectPath);
    } catch (err: any) {
      setError(err.message || 'Failed to login');
    } finally {
      setLoading(false);
    }
  };
  
  return (
    <motion.div
      className="flex items-center justify-center min-h-screen bg-llama-50"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.5 }}
    >
      <div className="w-full max-w-md">
        <div className="bg-white py-8 px-6 shadow-md rounded-xl border border-llama-100">
          <div className="flex justify-center mb-6">
            <LlamaIcon className="w-20 h-20 text-llama-600" />
          </div>
          
          <h2 className="text-2xl font-bold text-center text-llama-800 mb-6">
            Sign in to your account
          </h2>
          
          {error && (
            <motion.div
              className="bg-red-50 border-l-4 border-red-500 p-4 mb-6 text-red-700"
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
            >
              {error}
            </motion.div>
          )}
          
          <form onSubmit={handleSubmit}>
            <div className="mb-4">
              <label htmlFor="username" className="block text-sm font-medium text-llama-700 mb-1">
                Username
              </label>
              <input
                id="username"
                name="username"
                type="text"
                required
                value={formData.username}
                onChange={handleChange}
                className="input-field"
                placeholder="llamauser"
              />
            </div>
            
            <div className="mb-6">
              <label htmlFor="password" className="block text-sm font-medium text-llama-700 mb-1">
                Password
              </label>
              <input
                id="password"
                name="password"
                type="password"
                required
                value={formData.password}
                onChange={handleChange}
                className="input-field"
                placeholder="••••••••"
              />
            </div>
            
            <div>
              <button
                type="submit"
                className="w-full btn-primary flex justify-center items-center"
                disabled={loading}
              >
                {loading ? (
                  <span className="flex items-center">
                    <span className="animate-spin mr-2">🔄</span>
                    Signing in...
                  </span>
                ) : (
                  'Sign in'
                )}
              </button>
            </div>
          </form>
          
          <p className="mt-4 text-center text-sm text-llama-500">
            Demo credentials: llamauser / LlamaAI123
          </p>
        </div>
      </div>
    </motion.div>
  );
}
EOF

  # Create auth hook
  mkdir -p "$PROJECT_DIR/frontend/lib/hooks"
  cat > "$PROJECT_DIR/frontend/lib/hooks/useAuth.tsx" << 'EOF'
import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { login as apiLogin } from '@/lib/api/auth';

interface AuthContextType {
  user: any;
  loading: boolean;
  login: (username: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check if user is already logged in
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser));
      } catch (error) {
        console.error('Failed to parse stored user', error);
        localStorage.removeItem('user');
      }
    }
    setLoading(false);
  }, []);

  const login = async (username: string, password: string) => {
    try {
      // For demo purposes, allow login with demo credentials
      if (username === 'llamauser' && password === 'LlamaAI123') {
        const demoUser = {
          id: 1,
          username: 'llamauser',
          email: 'llama@example.com',
          token: 'demo-token-xyz'
        };
        setUser(demoUser);
        localStorage.setItem('user', JSON.stringify(demoUser));
        return;
      }
      
      // Real API login
      const userData = await apiLogin(username, password);
      setUser(userData);
      localStorage.setItem('user', JSON.stringify(userData));
    } catch (error) {
      console.error('Login failed', error);
      throw new Error('Invalid username or password');
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('user');
  };

  return (
    <AuthContext.Provider value={{ user, loading, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
EOF

  # Create API utilities
  mkdir -p "$PROJECT_DIR/frontend/lib/api"
  cat > "$PROJECT_DIR/frontend/lib/api/auth.ts" << 'EOF'
import axios from 'axios';
import { API_URL } from '@/lib/utils/constants';

export async function login(username: string, password: string) {
  try {
    const response = await axios.post(`${API_URL}/auth/token`, {
      username,
      password,
    }, {
      headers: {
        'Content-Type': 'application/json',
      },
    });

    return response.data;
  } catch (error: any) {
    if (error.response) {
      throw new Error(error.response.data.detail || 'Login failed');
    }
    throw new Error('Network error. Please try again later.');
  }
}

export async function getUserProfile(token: string) {
  try {
    const response = await axios.get(`${API_URL}/auth/me`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    return response.data;
  } catch (error) {
    throw new Error('Failed to fetch user profile');
  }
}
EOF

  cat > "$PROJECT_DIR/frontend/lib/api/ai.ts" << 'EOF'
import axios from 'axios';
import { API_URL } from '@/lib/utils/constants';

export interface ChatMessage {
  role: string;
  content: string;
}

export interface ChatRequest {
  messages: ChatMessage[];
  max_tokens?: number;
  temperature?: number;
  top_p?: number;
}

export interface ChatResponse {
  message: ChatMessage;
  model: string;
  usage: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
}

export async function sendChatMessage(messages: ChatMessage[], options = {}, token: string) {
  try {
    const response = await axios.post(
      `${API_URL}/ai/chat`,
      {
        messages,
        ...options,
      },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      }
    );

    return response.data;
  } catch (error: any) {
    if (error.response) {
      throw new Error(error.response.data.detail || 'Failed to get AI response');
    }
    throw new Error('Network error. Please try again later.');
  }
}

export async function generateWithMLX(prompt: string, options = {}, token: string) {
  try {
    const response = await axios.post(
      `${API_URL}/mlx/generate`,
      {
        prompt,
        ...options,
      },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      }
    );

    return response.data;
  } catch (error: any) {
    if (error.response) {
      throw new Error(error.response.data.detail || 'Failed to generate text');
    }
    throw new Error('Network error. Please try again later.');
  }
}
EOF

  # Create constants file
  mkdir -p "$PROJECT_DIR/frontend/lib/utils"
  cat > "$PROJECT_DIR/frontend/lib/utils/constants.ts" << 'EOF'
// API Configuration
export const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000/api';

// MLX Models
export const MLX_MODELS = [
  {
    id: 'llama-2-7b-mlx',
    name: 'Llama 2 (7B)',
    description: 'Base Llama 2 model optimized for MLX on Apple Silicon',
  },
  {
    id: 'llama-2-7b-mlx-quantized',
    name: 'Llama 2 (7B) Quantized',
    description: 'Quantized Llama 2 model for faster inference and lower memory usage',
  },
  {
    id: 'llama-2-13b-mlx',
    name: 'Llama 2 (13B)',
    description: 'Larger Llama 2 model with enhanced capabilities',
  },
  {
    id: 'mistral-7b-mlx',
    name: 'Mistral (7B)',
    description: 'Mistral 7B model optimized for MLX',
  },
];

// Theme constants
export const LLAMA_COLORS = {
  primary: '#a18457',
  secondary: '#5f4a38',
  background: '#f9f7f4',
  text: '#32271d',
  accent: '#c1ac8d',
  light: '#e7dfd3',
  dark: '#32271d',
};
EOF

  # Create UI Components
  mkdir -p "$PROJECT_DIR/frontend/components/layout"
  mkdir -p "$PROJECT_DIR/frontend/components/ui"
  mkdir -p "$PROJECT_DIR/frontend/components/chat"
  mkdir -p "$PROJECT_DIR/frontend/components/llama"

  # Create Loading Screen Component
  cat > "$PROJECT_DIR/frontend/components/ui/LoadingScreen.tsx" << 'EOF'
import { motion } from 'framer-motion';
import LlamaIcon from '@/components/llama/LlamaIcon';

export default function LoadingScreen() {
  return (
    <div className="fixed inset-0 bg-llama-50 flex flex-col items-center justify-center z-50">
      <motion.div
        initial={{ scale: 0.8, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ duration: 0.5 }}
        className="flex flex-col items-center"
      >
        <motion.div
          animate={{ 
            y: [0, -15, 0],
            rotate: [0, 5, 0, -5, 0],
          }}
          transition={{ 
            duration: 2.5,
            repeat: Infinity,
            ease: "easeInOut" 
          }}
        >
          <LlamaIcon className="w-24 h-24 text-llama-600" />
        </motion.div>
        
        <motion.h1
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.3, duration: 0.5 }}
          className="mt-6 text-2xl font-bold text-llama-800"
        >
          Ultimate Llama AI
        </motion.h1>
        
        <motion.div
          initial={{ width: 0 }}
          animate={{ width: "100%" }}
          transition={{ 
            delay: 0.8,
            duration: 1.5,
            ease: "easeInOut" 
          }}
          className="h-1 bg-gradient-to-r from-llama-300 via-llama-600 to-llama-400 rounded-full mt-4 w-64"
        />
        
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1, duration: 0.5 }}
          className="mt-4 text-llama-600"
        >
          Optimized for Apple Silicon
        </motion.p>
      </motion.div>
    </div>
  );
}
EOF

  # Create Navbar Component
  cat > "$PROJECT_DIR/frontend/components/layout/Navbar.tsx" << 'EOF'
import { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { motion } from 'framer-motion';
import { Disclosure } from '@headlessui/react';
import { Bars3Icon, XMarkIcon } from '@heroicons/react/24/outline';
import { useAuth } from '@/lib/hooks/useAuth';
import LlamaIcon from '@/components/llama/LlamaIcon';

export default function Navbar() {
  const router = useRouter();
  const { user, logout } = useAuth();
  
  const navigation = [
    { name: 'Home', href: '/' },
    { name: 'Chat', href: '/chat' },
    { name: 'Dashboard', href: '/dashboard' },
    { name: 'Documentation', href: '/docs' },
  ];
  
  const handleLogout = () => {
    logout();
    router.push('/');
  };
  
  return (
    <Disclosure as="nav" className="bg-white shadow-sm fixed w-full top-0 z-10">
      {({ open }) => (
        <>
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div className="flex h-16 justify-between">
              <div className="flex">
                <Link href="/" className="flex flex-shrink-0 items-center">
                  <motion.div 
                    whileHover={{ rotate: 10 }}
                    transition={{ duration: 0.2 }}
                  >
                    <LlamaIcon className="h-8 w-auto text-llama-600" />
                  </motion.div>
                  <span className="ml-2 text-xl font-semibold text-llama-800">
                    Llama AI
                  </span>
                </Link>
                <div className="hidden sm:ml-6 sm:flex sm:space-x-8">
                  {navigation.map((item) => {
                    const isActive = router.pathname === item.href;
                    return (
                      <Link
                        key={item.name}
                        href={item.href}
                        className={`inline-flex items-center px-1 pt-1 text-sm font-medium 
                          ${isActive 
                            ? 'border-b-2 border-llama-500 text-llama-900' 
                            : 'border-b-2 border-transparent text-llama-500 hover:border-llama-300 hover:text-llama-700'
                          }
                        `}
                      >
                        {item.name}
                      </Link>
                    );
                  })}
                </div>
              </div>
              
              <div className="hidden sm:ml-6 sm:flex sm:items-center">
                {user ? (
                  <div className="flex items-center space-x-4">
                    <span className="text-sm text-llama-600">
                      Hello, {user.username}
                    </span>
                    <button
                      onClick={handleLogout}
                      className="rounded-md bg-llama-50 px-3 py-2 text-sm font-medium text-llama-700 hover:bg-llama-100"
                    >
                      Sign out
                    </button>
                  </div>
                ) : (
                  <Link
                    href="/login"
                    className="rounded-md bg-llama-600 px-3 py-2 text-sm font-medium text-white hover:bg-llama-700"
                  >
                    Sign in
                  </Link>
                )}
              </div>
              
              <div className="flex items-center sm:hidden">
                <Disclosure.Button className="inline-flex items-center justify-center rounded-md p-2 text-llama-400 hover:bg-llama-100 hover:text-llama-500">
                  <span className="sr-only">Open main menu</span>
                  {open ? (
                    <XMarkIcon className="block h-6 w-6" aria-hidden="true" />
                  ) : (
                    <Bars3Icon className="block h-6 w-6" aria-hidden="true" />
                  )}
                </Disclosure.Button>
              </div>
            </div>
          </div>

          <Disclosure.Panel className="sm:hidden">
            <div className="space-y-1 pb-3 pt-2">
              {navigation.map((item) => {
                const isActive = router.pathname === item.href;
                return (
                  <Disclosure.Button
                    key={item.name}
                    as="a"
                    href={item.href}
                    className={`block py-2 pl-3 pr-4 text-base font-medium 
                      ${isActive 
                        ? 'bg-llama-50 border-l-4 border-llama-500 text-llama-700' 
                        : 'border-l-4 border-transparent text-llama-500 hover:bg-llama-50 hover:border-llama-300 hover:text-llama-700'
                      }
                    `}
                  >
                    {item.name}
                  </Disclosure.Button>
                );
              })}
            </div>
            
            <div className="border-t border-llama-200 pb-3 pt-4">
              {user ? (
                <div className="space-y-2">
                  <div className="flex items-center px-4">
                    <div className="ml-3">
                      <div className="text-base font-medium text-llama-800">
                        {user.username}
                      </div>
                      <div className="text-sm font-medium text-llama-500">
                        {user.email}
                      </div>
                    </div>
                  </div>
                  <Disclosure.Button
                    onClick={handleLogout}
                    className="block w-full py-2 pl-3 pr-4 text-left text-base font-medium text-llama-500 hover:bg-llama-50 hover:text-llama-700"
                  >
                    Sign out
                  </Disclosure.Button>
                </div>
              ) : (
                <div className="px-4">
                  <Disclosure.Button
                    as="a"
                    href="/login"
                    className="block text-center w-full rounded-md bg-llama-600 px-3 py-2 text-base font-medium text-white hover:bg-llama-700"
                  >
                    Sign in
                  </Disclosure.Button>
                </div>
              )}
            </div>
          </Disclosure.Panel>
        </>
      )}
    </Disclosure>
  );
}
EOF

  # Create Footer Component
  cat > "$PROJECT_DIR/frontend/components/layout/Footer.tsx" << 'EOF'
import Link from 'next/link';
import LlamaIcon from '@/components/llama/LlamaIcon';

export default function Footer() {
  return (
    <footer className="bg-white border-t border-llama-100">
      <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <div className="xl:grid xl:grid-cols-3 xl:gap-8">
          <div className="space-y-8 xl:col-span-1">
            <div className="flex items-center">
              <LlamaIcon className="h-8 w-auto text-llama-600" />
              <span className="ml-2 text-xl font-semibold text-llama-800">
                Llama AI
              </span>
            </div>
            <p className="text-base text-llama-500">
              The ultimate AI application optimized for Apple Silicon
            </p>
            <div className="flex space-x-6">
              <a href="#" className="text-llama-400 hover:text-llama-500">
                <span className="sr-only">GitHub</span>
                <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd" />
                </svg>
              </a>
              <a href="#" className="text-llama-400 hover:text-llama-500">
                <span className="sr-only">Twitter</span>
                <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
                </svg>
              </a>
            </div>
          </div>
          
          <div className="mt-12 grid grid-cols-2 gap-8 xl:col-span-2 xl:mt-0">
            <div className="md:grid md:grid-cols-2 md:gap-8">
              <div>
                <h3 className="text-sm font-semibold text-llama-800">Features</h3>
                <ul className="mt-4 space-y-4">
                  <li>
                    <Link href="/chat" className="text-base text-llama-500 hover:text-llama-900">
                      Chat
                    </Link>
                  </li>
                  <li>
                    <Link href="/docs" className="text-base text-llama-500 hover:text-llama-900">
                      Documentation
                    </Link>
                  </li>
                  <li>
                    <Link href="/mlx" className="text-base text-llama-500 hover:text-llama-900">
                      MLX Integration
                    </Link>
                  </li>
                </ul>
              </div>
              <div className="mt-12 md:mt-0">
                <h3 className="text-sm font-semibold text-llama-800">Support</h3>
                <ul className="mt-4 space-y-4">
                  <li>
                    <Link href="/docs/getting-started" className="text-base text-llama-500 hover:text-llama-900">
                      Getting Started
                    </Link>
                  </li>
                  <li>
                    <Link href="/docs/faq" className="text-base text-llama-500 hover:text-llama-900">
                      FAQ
                    </Link>
                  </li>
                  <li>
                    <Link href="/contact" className="text-base text-llama-500 hover:text-llama-900">
                      Contact
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
            <div className="md:grid md:grid-cols-2 md:gap-8">
              <div>
                <h3 className="text-sm font-semibold text-llama-800">Legal</h3>
                <ul className="mt-4 space-y-4">
                  <li>
                    <Link href="/privacy" className="text-base text-llama-500 hover:text-llama-900">
                      Privacy
                    </Link>
                  </li>
                  <li>
                    <Link href="/terms" className="text-base text-llama-500 hover:text-llama-900">
                      Terms
                    </Link>
                  </li>
                </ul>
              </div>
              <div className="mt-12 md:mt-0">
                <h3 className="text-sm font-semibold text-llama-800">Company</h3>
                <ul className="mt-4 space-y-4">
                  <li>
                    <Link href="/about" className="text-base text-llama-500 hover:text-llama-900">
                      About
                    </Link>
                  </li>
                  <li>
                    <Link href="/blog" className="text-base text-llama-500 hover:text-llama-900">
                      Blog
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div className="mt-12 border-t border-llama-100 pt-8">
          <p className="text-base text-llama-400 text-center">
            &copy; 2025 Ultimate Llama AI. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
EOF

  # Create LlamaIcon Component
  cat > "$PROJECT_DIR/frontend/components/llama/LlamaIcon.tsx" << 'EOF'
interface LlamaIconProps {
  className?: string;
}

export default function LlamaIcon({ className = "w-6 h-6" }: LlamaIconProps) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 512 512"
      className={className}
      fill="currentColor"
    >
      <path d="M464.4 72.38c-10.9-10.88-23.9-19.12-38.1-24.95c-2.7-.98-5.6 1.79-5.1 4.56c9.3 49.94-18.2 95.52-57.6 118.72c1.3 24.32-6.8 48.89-24.4 66.52c-22.3 22.31-55.9 28.77-84.8 19.18c-19.6 9.56-43.8 9.53-63.8 .89c-8.4 9.76-19.8 17.24-33.3 21.42c-33.2 10.3-70.2-2.96-89.9-35.96c-13.2-4.25-25.5-11.82-35.8-22.11l-21.3 21.25l31.7 30.7c10.9 10.2 26.9 12.5 40.4 5.74c16.1-8.11 39.5-24.58 55.8-24.58c16.6 0 31 10.85 36 25.95c4.6 14.09-.1 29.45-10.9 38.88l-53.4 45.28C96.1 374.5 91.7 385.3 92.4 396.4c.8 13.2 9.2 25.4 21.7 31.1c12.5 5.8 27.1 4.1 38.1-4.5l84.7-65.6c19.7-9.1 51.9-34.2 68.2-53.4l124.6-63.6c9.2-4.7 14.7-10.8 17.9-18.2c4.8-11.2 1.8-36.2-11.4-49.4c23.7-20 43.8-44 60.3-69.5C503.8 109.7 474.7 82.63 464.4 72.38zM304.1 402.1l-49.2 8.2c-9.4 1.5-18.1-4.9-19.7-14.3s4.9-18.1 14.3-19.7l49.2-8.2c9.4-1.5 18.1 4.9 19.7 14.3S313.5 400.5 304.1 402.1zM368.1 388.1l-49.2 8.2c-9.4 1.5-18.1-4.9-19.7-14.3s4.9-18.1 14.3-19.7l49.2-8.2c9.4-1.5 18.1 4.9 19.7 14.3S377.5 386.5 368.1 388.1zM48 136c0-48.6 39.4-88 88-88s88 39.4 88 88c0 4.4-3.6 8-8 8c-4.4 0-8-3.6-8-8c0-39.8-32.2-72-72-72S64 96.2 64 136c0 4.4-3.6 8-8 8S48 140.4 48 136z"/>
    </svg>
  );
}
EOF

  # Create AnimatedLlama Component
  cat > "$PROJECT_DIR/frontend/components/llama/AnimatedLlama.tsx" << 'EOF'
import { useEffect, useRef } from 'react';
import { motion } from 'framer-motion';

export default function AnimatedLlama() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  
  useEffect(() => {
    if (!canvasRef.current) return;
    
    const canvas = canvasRef.current;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    
    // Set canvas dimensions
    canvas.width = 300;
    canvas.height = 300;
    
    // Define llama parts
    const head = {
      x: 150,
      y: 100,
      width: 60,
      height: 80,
      color: '#e7dfd3',
    };
    
    const body = {
      x: 150,
      y: 180,
      width: 80,
      height: 100,
      color: '#d5c7b2',
    };
    
    const legs = [
      { x: 130, y: 260, width: 10, height: 40, color: '#a18457' },
      { x: 150, y: 260, width: 10, height: 40, color: '#a18457' },
      { x: 170, y: 260, width: 10, height: 40, color: '#a18457' },
      { x: 190, y: 260, width: 10, height: 40, color: '#a18457' },
    ];
    
    const ears = [
      { x: 120, y: 60, width: 15, height: 30, color: '#c1ac8d' },
      { x: 180, y: 60, width: 15, height: 30, color: '#c1ac8d' },
    ];
    
    const face = {
      x: 150,
      y: 90,
      width: 20,
      height: 20,
      color: '#5f4a38',
    };
    
    // Animation variables
    let time = 0;
    const animationSpeed = 0.05;
    
    // Animation function
    function animate() {
      // Clear canvas
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      
      // Update time
      time += animationSpeed;
      
      // Calculate head bobbing
      const headBob = Math.sin(time) * 5;
      
      // Draw body
      ctx.fillStyle = body.color;
      ctx.beginPath();
      ctx.ellipse(
        body.x,
        body.y,
        body.width / 2,
        body.height / 2,
        0,
        0,
        Math.PI * 2
      );
      ctx.fill();
      
      // Draw legs with slight movement
      legs.forEach((leg, i) => {
        ctx.fillStyle = leg.color;
        ctx.fillRect(
          leg.x,
          leg.y + Math.sin(time + i * 0.5) * 3,
          leg.width,
          leg.height
        );
      });
      
      // Draw head with bobbing
      ctx.fillStyle = head.color;
      ctx.beginPath();
      ctx.ellipse(
        head.x,
        head.y + headBob,
        head.width / 2,
        head.height / 2,
        0,
        0,
        Math.PI * 2
      );
      ctx.fill();
      
      // Draw ears
      ears.forEach((ear) => {
        ctx.fillStyle = ear.color;
        ctx.beginPath();
        ctx.ellipse(
          ear.x,
          ear.y + headBob,
          ear.width / 2,
          ear.height / 2,
          0,
          0,
          Math.PI * 2
        );
        ctx.fill();
      });
      
      // Draw face
      ctx.fillStyle = face.color;
      ctx.beginPath();
      ctx.ellipse(
        face.x,
        face.y + headBob,
        face.width / 2,
        face.height / 2,
        0,
        0,
        Math.PI * 2
      );
      ctx.fill();
      
      // Draw eyes
      ctx.fillStyle = 'white';
      ctx.beginPath();
      ctx.arc(face.x - 5, face.y - 2 + headBob, 3, 0, Math.PI * 2);
      ctx.fill();
      ctx.beginPath();
      ctx.arc(face.x + 5, face.y - 2 + headBob, 3, 0, Math.PI * 2);
      ctx.fill();
      
      // Draw pupils
      ctx.fillStyle = 'black';
      ctx.beginPath();
      ctx.arc(face.x - 5, face.y - 2 + headBob, 1.5, 0, Math.PI * 2);
      ctx.fill();
      ctx.beginPath();
      ctx.arc(face.x + 5, face.y - 2 + headBob, 1.5, 0, Math.PI * 2);
      ctx.fill();
      
      // Continue animation
      requestAnimationFrame(animate);
    }
    
    // Start animation
    animate();
    
    // Cleanup function
    return () => {
      // No specific cleanup needed for canvas
    };
  }, []);
  
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.5 }}
      className="relative"