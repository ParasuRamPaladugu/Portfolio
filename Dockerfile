# Use the Python 3.8 slim image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Node.js and npm
RUN apt-get update && apt-get install -y nodejs npm && rm -rf /var/lib/apt/lists/*

# Install BrowserSync globally
RUN npm install -g browser-sync

# Copy the rest of the application code
COPY . .

# Expose the port that BrowserSync will use
EXPOSE 3000

# Start both Python and BrowserSync using CMD
CMD ["sh", "-c", "echo 'Starting Python...' && python app.py & echo 'Starting BrowserSync...' && browser-sync start --server --files ."]

#CMD ["sh", "-c", "python app.py & browser-sync start --server --files ."]
