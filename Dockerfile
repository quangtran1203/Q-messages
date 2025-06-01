
# Dockerfile for the Chinese-to-English Translation Webapp

# ---- Build Instructions ----
# To build the Docker image, navigate to the directory containing this Dockerfile
# and the application code, then run:
#
# docker build -t translation-app .
#
# Replace 'translation-app' with your desired image name.

# ---- Run Instructions ----
# To run the application in a Docker container from the built image, run:
#
# docker run -d -p 5000:5000 translation-app
#
# This will run the container in detached mode (-d) and map port 5000 of the
# container to port 5000 on the host. You can then access the application
# at http://localhost:5000.
#
# The application inside the container will be run using Gunicorn on port 5000.

# Stage 1: Base image
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
# This ensures that dependencies are installed before copying application code,
# leveraging Docker's layer caching.
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# We use --no-cache-dir to reduce image size.
# Gunicorn should be listed in requirements.txt as the WSGI server.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
# This includes app.py, translator.py, and the templates directory.
# Consider adding a .dockerignore file for more complex projects.
COPY . .

# Create a non-privileged user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Make port 5000 available to the world outside this container
# This informs Docker that the container listens on this port.
EXPOSE 5000

# Switch to the non-privileged user
USER appuser

# Run app.py when the container launches using Gunicorn
# The TDD suggests Gunicorn for simple production (section 7).
# We'll bind to 0.0.0.0 to make it accessible from outside the container.
# `app:app` assumes your Flask application instance is named `app` in `app.py`.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
