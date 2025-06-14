from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import boto3
import json
import os
import openai

app = FastAPI()

# Enable CORS for all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_secret():
    secret_name = os.getenv("SECRET_ARN")
    print("🔍 SECRET_ARN:", secret_name)  # Temporary debug
    region_name = "ap-south-1"
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response["SecretString"])

@app.get("/api/health")
async def health_check():
    return {"status": "healthy", "message": "Backend is running successfully"}

@app.get("/api/message")
async def get_message():
    try:
        creds = get_secret()
        openai.api_key = creds["api_key"]

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": "Say hello from a DevOps container!"}],
            max_tokens=50
        )
        return {"message": response.choices[0].message.content}
    except Exception as e:
        return {"error": str(e)}
