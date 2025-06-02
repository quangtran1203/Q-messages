
# Dockerfile for the Chinese-to-English Translation Webapp

# Instructions to build the Docker image:
# 1. Ensure this Dockerfile is in the root directory of your project.
# 2. Open a terminal in the project root directory.
# 3. Run the following command:
#    docker build -t chinese-translator-app .

# Instructions to run the Docker container:
# 1. After successfully building the image, run the following command:
#    docker run -p 5000:5000 chinese-translator-app
# 2. Open your web browser and navigate to http://localhost:5000 to use the application.

# Use an official Python runtime as a parent image (Python 3.9 slim version)
FROM python:3.9-slim

# Set the working directory within the container
WORKDIR /app

# Copy the requirements file into the working directory
# This file should list Flask and deep_translator as dependencies.
COPY requirements.txt .

# Install the Python dependencies specified in requirements.txt
# --no-cache-dir reduces image size by not storing the pip cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code and templates into the container
# Assumes app.py and translation_service.py are in the project root,
# and HTML templates are in a 'templates' subdirectory.
COPY app.py .
COPY translation_service.py .
COPY templates ./templates/

# Expose port 5000, which is the default port Flask runs on
EXPOSE 5000

# Set environment variables for Flask
# FLASK_APP tells Flask where to find the application instance
# FLASK_RUN_HOST=0.0.0.0 makes the application accessible from outside the container
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Define the command to run the application when the container starts
# This uses the Flask development server.
CMD ["flask", "run"]

# Note for production:
# For a more robust deployment, consider using a production-grade WSGI server
# like Gunicorn. If Gunicorn is included in your requirements.txt,
# you might change the CMD to something like:
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
# Ensure 'app:app' correctly points to your Flask application object (e.g., 'app.py' file, 'app' Flask instance).
