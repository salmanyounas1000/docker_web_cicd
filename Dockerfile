# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
# We install Flask directly to keep this file simple for beginners
RUN pip install flask

# Copy source code
COPY app.py .

# Expose port 5000 (Flask default)
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]