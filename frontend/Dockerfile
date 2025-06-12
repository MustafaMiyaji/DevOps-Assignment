# Stage 1: Build
FROM python:3.10-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.10-slim

ENV PATH="/root/.local/bin:$PATH"
WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY app/ app/

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
