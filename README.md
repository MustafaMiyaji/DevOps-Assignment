
# DevOps Assignment

This is a full-stack DevOps project with a **FastAPI backend** and a **Next.js frontend**, demonstrating a complete DevOps lifecycle — version control, containerization, CI/CD, infrastructure as code, monitoring, and security using AWS.

---

## 🏗️ Architecture Overview

This project is a **two-tier web application**:
- **Backend**: FastAPI (Python) serving RESTful APIs
- **Frontend**: Next.js (React) fetching data from the backend

The goal is to containerize and deploy the entire stack on AWS ECS using Terraform, with CI/CD pipelines, secure secrets management, and monitoring via AWS CloudWatch.

---

## 📁 Project Structure

```
.
├── backend/               # FastAPI backend
│   ├── app/
│   │   └── main.py        # Main FastAPI application
│   └── requirements.txt   # Python dependencies
└── frontend/              # Next.js frontend
    ├── pages/
    │   └── index.js       # Main page
    ├── public/            # Static files
    └── package.json       # Node.js dependencies
```

---

## 🌱 Prerequisites

- Python 3.8+
- Node.js 16+
- npm or yarn

---

## ⚙️ Backend Setup

```bash
cd backend
python -m venv venv
source venv/bin/activate        # On Windows: .\venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

- The backend will be available at `http://localhost:8000`

---

## 🖥️ Frontend Setup

```bash
cd frontend
npm install        # or yarn
```

#### Configure backend URL:
Create or update `.env.local` in the `frontend/` folder:

```
NEXT_PUBLIC_API_URL=http://localhost:8000
```

Then start the frontend server:

```bash
npm run dev        # or yarn dev
```

- The frontend will be available at `http://localhost:3000`

---

## 🧪 Testing the Integration

1. Start both frontend and backend
2. Open the browser at `http://localhost:3000`
3. You should see:
   - A success message from the backend
   - Backend status displayed
   - The API message: `"You've successfully integrated the backend!"`

---

## 🔀 Branching Strategy

We follow a standard **Git Flow** branching model:

- `main`: Production-ready code
- `develop`: Integration and staging
- `feature/*`: For new features and experiments

All development happens in `feature/*` branches, which are merged into `develop` via Pull Requests. Stable changes from `develop` are then merged into `main`.

---

## 🔁 Changing the Backend URL

Update `NEXT_PUBLIC_API_URL` in `frontend/.env.local`:

```env
NEXT_PUBLIC_API_URL=http://your-backend-url.com
```

Restart the Next.js dev server after any changes.

---

## 🚀 For Production Deployment

```bash
npm run build      # or yarn build
npm start          # or yarn start
```

---

## 🔌 API Endpoints

- `GET /api/health`
  - Returns: `{"status": "healthy", "message": "Backend is running successfully"}`
- `GET /api/message`
  - Returns: `{"message": "You've successfully integrated the backend!"}`
