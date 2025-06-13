from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import os
from dotenv import load_dotenv
import threading
import time

# Load environment variables
load_dotenv()

app = FastAPI()

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health")
async def health_check():
    return {"status": "healthy", "message": "Backend is running successfully"}

@app.get("/api/message")
async def get_message():
    return {"message": "You've successfully integrated the backend!"}


def burn_cpu():
    while True:
        print("Burning CPU...")
        _ = [x**2 for x in range(10000)]
        time.sleep(0.1)

threading.Thread(target=burn_cpu, daemon=True).start()
