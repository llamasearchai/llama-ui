FROM python:3.11-slim

WORKDIR /app

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file 
COPY requirements.txt .

# Comment out MLX in requirements as it's Apple Silicon specific
RUN sed -i 's/^mlx/#mlx/' requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create a note about MLX
RUN echo "Note: MLX package requires Apple Silicon and is not installed in this container." > MLX_NOTE.txt

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"] 