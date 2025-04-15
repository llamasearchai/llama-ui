import os
import time
from typing import Any, Dict, List, Optional

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

# Record startup time for uptime calculation
START_TIME = time.time()

# Initialize FastAPI app
app = FastAPI(
    title="LlamaSeek API",
    description="Backend API for the LlamaSeek document search platform",
)

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
        "environment": os.environ.get("NODE_ENV", "development"),
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
        tags=["search", "nlp", "ai"],
    ),
    Document(
        id="2",
        title="Document Processing Techniques",
        content="Document processing involves extracting valuable information from documents using techniques like OCR, NLP, and machine learning.",
        date="2023-10-02",
        tags=["documents", "processing", "ocr"],
    ),
    Document(
        id="3",
        title="Vector Databases for Document Search",
        content="Vector databases store document embeddings that capture semantic meaning, enabling efficient similarity searches based on content.",
        date="2023-10-03",
        tags=["vectors", "databases", "embeddings"],
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

            results.append(
                {
                    "id": doc.id,
                    "title": doc.title,
                    "content": (
                        doc.content[:150] + "..."
                        if len(doc.content) > 150
                        else doc.content
                    ),
                    "score": score,
                    "date": doc.date,
                }
            )

    # Sort by score, descending
    results.sort(key=lambda x: x["score"], reverse=True)

    # Apply limit
    results = results[:limit]

    search_time = time.time() - start_time

    return {"results": results, "meta": {"total": len(results), "time": search_time}}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
