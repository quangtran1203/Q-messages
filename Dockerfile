
# Dockerfile for Chinese-to-English Translation Webapp

# ---- Stage 1: Builder ----
# Use an official Python runtime as a parent image for the build stage
FROM python:3.9-slim as builder

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
# Assumes a requirements.txt file is present in the same directory as the Dockerfile
COPY requirements.txt .

# Install Python dependencies system-wide
# Using --no-cache-dir to reduce layer size
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY app.py .
COPY templates/ templates/

# ---- Stage 2: Production ----
# Use a slim Python runtime for the final production image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Create a non-root user and group for running the application
# -r: create a system user
# --no-log-init: do not add the user to the lastlog database
# -g appgroup: specify the primary group
# -d /app: set home directory to /app
# -s /sbin/nologin: set shell to /sbin/nologin (user cannot log in)
RUN groupadd -r appgroup && \
    useradd --no-log-init -r -g appgroup -d /app -s /sbin/nologin appuser

# Copy installed Python packages (site-packages) from the builder stage
# These are installed system-wide in the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
# Copy executables (like gunicorn) installed by pip from the builder stage
COPY --from=builder /usr/local/bin/ /usr/local/bin/

# Copy application code from the builder stage
# Use --chown to set ownership to the appuser and appgroup
COPY --chown=appuser:appgroup --from=builder /app/app.py .
COPY --chown=appuser:appgroup --from=builder /app/templates/ templates/

# Expose port 5000 (Flask/Gunicorn default)
EXPOSE 5000

# Set environment variable for Flask (Gunicorn can use this)
ENV FLASK_APP=app.py

# Switch to the non-root user
USER appuser

# Command to run the application using Gunicorn
# Gunicorn is a WSGI HTTP Server for UNIX, recommended for production
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

# --- How to Build and Run ---
#
# 1. Ensure you have Docker installed.
# 2. Create a 'requirements.txt' file in the same directory as this Dockerfile.
#    It should contain:
#    flask
#    translators
#    gunicorn
#
# 3. Build the Docker image:
#    Open your terminal in the directory containing this Dockerfile, 'app.py',
#    the 'templates' directory, and 'requirements.txt'.
#    Run the following command (replace 'chinese-translator-app' with your desired image name):
#    docker build -t chinese-translator-app .
#
# 4. Run the Docker container from the image:
#    After the build is successful, run the following command to start the container:
#    docker run -p 5000:5000 chinese-translator-app
#
# 5. Access the application:
#    Open your web browser and go to http://localhost:5000
#
