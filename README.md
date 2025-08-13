# Flask User API

A simple Flask REST API that provides user data and health check endpoints.

## Features

- 📋 **User List API**: Returns a list of users in JSON format
- 🏥 **Health Check**: Basic health check endpoint for load balancers
- 🌐 **Built-in CORS**: Cross-origin requests enabled with custom headers
- 🚀 **Simple Deployment**: Easy to deploy on any server

## API Endpoints

### GET /api/users
Returns a list of users in JSON format.

**Response:**
```json
{
  "users": ["Alice", "Bob", "Charlie"]
}
```

### GET /health
Health check endpoint that returns "OK" status.

**Response:**
```
OK
```

## Prerequisites

- Python 3.x
- pip (Python package installer)

## Installation & Setup

### 1. Update System (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install python3-pip
```

### 2. Install Required Packages
```bash
# Install Flask only
pip3 install flask
```

### 3. Create Application File
Create a file named `app.py` with the following content:

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response

@app.route("/api/users")
def get_users():
    return jsonify({"users": ["Alice", "Bob", "Charlie"]})

@app.route("/health")
def health_check():
    # Target Group health check endpoint
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

## Running the Application

### Development Mode
```bash
python3 app.py
```

### Production Mode (with Gunicorn)
```bash
# Install Gunicorn
pip3 install gunicorn

# Run with Gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Background Process
```bash
# Run in background
nohup python3 app.py &

# Check if running
ps aux | grep python3
```

## Testing the API

### Using curl
```bash
# Test users endpoint
curl http://localhost:5000/api/users

# Test health endpoint
curl http://localhost:5000/health

# Test from external IP
curl http://YOUR_PUBLIC_IP:5000/api/users
```

### Using browser
- Navigate to: `http://YOUR_PUBLIC_IP:5000/api/users`
- Navigate to: `http://YOUR_PUBLIC_IP:5000/health`

## AWS Deployment

### Security Group Configuration
Make sure your EC2 security group allows:
- **Port 5000** for HTTP traffic
- **Source**: 0.0.0.0/0 (or specific IP ranges)

### Load Balancer Setup
1. Create Application Load Balancer
2. Configure target group pointing to port 5000
3. Set health check path to `/health`
4. Register your EC2 instances

## File Structure
```
/var/www/html/
├── app.py          # Main Flask application
├── index.html      # Frontend interface (optional)
└── README.md       # This file
```

## Useful Commands

```bash
# Install Flask only
pip3 install flask

# Run with specific host and port
python3 app.py --host=0.0.0.0 --port=5000

# Check Python version
python3 --version

# Check installed packages
pip3 list | grep -i flask

# Stop all Python processes
sudo pkill -f python3
```
