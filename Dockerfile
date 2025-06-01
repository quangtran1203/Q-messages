
# Dockerfile for the Chinese-to-English Translation Webapp

# ---- Build Instructions ----
# To build the Docker image, navigate to the directory containing this Dockerfile
# and the application code, then run:
#
# docker build -t chinese-translator .
#
# It is highly recommended to use a .dockerignore file in your build context
# to exclude unnecessary files (e.g., .git, __pycache__, .venv, Dockerfile itself)
# from being copied into the image, keeping it small and secure.
#
# ---- Run Instructions ----
# To run the Docker container after building the image, use the following command.
# Replace "your_api_key_here" with your actual Translation API key.
# This command maps port 8080 on your host to port 8000 in the container.
#
# docker run -p 8080:8000 -e TRANSLATION_API_KEY="your_api_key_here" chinese-translator
#
# You can then access the application at http://localhost:8080
#

# 1. Base Image
# Use an official Python runtime as a parent image.
# python:3.9-slim is a good choice for a balance of features and size.
FROM python:3.9-slim

# 2. Set Working Directory
# Set the working directory in the container.
WORKDIR /app

# 3. Copy Dependencies File
# Copy the requirements.txt file first to leverage Docker's build cache.
# Assumes requirements.txt contains Flask, requests, and gunicorn.
COPY requirements.txt .

# 4. Install Dependencies
# Install any needed packages specified in requirements.txt.
# --no-cache-dir reduces image size.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy Application Code
# Copy the rest of the application code into the container's /app directory.
# Ensure a .dockerignore file is used in the build context for a lean image.
COPY . .

# 6. Create a non-root user and group
# Running the application as a non-root user is a security best practice.
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# 7. Set ownership of app files
# Ensure the application files are owned by the non-root user.
RUN chown -R appuser:appgroup /app

# 8. Expose Port
# Expose the port the app runs on. Gunicorn will be configured to run on port 8000.
EXPOSE 8000

# 9. Define Environment Variable for API Key (Informational)
# The TRANSLATION_API_KEY must be provided at runtime using the -e flag with docker run.
# Example: -e TRANSLATION_API_KEY="your_actual_api_key"
# This Dockerfile does not embed the API key.

# 10. Switch to the non-root user
USER appuser

# 11. Command to Run the Application
# Run the application using Gunicorn.
# -w 4 specifies 4 worker processes.
# -b 0.0.0.0:8000 binds Gunicorn to all network interfaces on port 8000.
# app:app assumes your Flask application instance is named 'app' in 'app.py'.
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
