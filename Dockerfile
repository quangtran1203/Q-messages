
# Dockerfile for the Chinese to English Translation Webapp

# ---- Build Instructions ----
# To build the Docker image, navigate to the directory containing this Dockerfile,
# your `app.py` file, and your `templates` directory, then run the following
# command in your terminal:
#
# docker build -t chinese-translator-app .
#
# ---- Run Instructions ----
# To run the application from the built image, use the following command:
#
# docker run -p 5000:5000 chinese-translator-app
#
# This will start the Flask development server on port 5000 inside the container
# and map it to port 5000 on your host machine. You can then access the
# application at http://localhost:5000 in your web browser.
#

# 1. Base Image
# Use an official Python runtime as a parent image.
# python:3.9-slim is a good balance of features and size.
FROM python:3.9-slim

# 2. Set Working Directory
# Set the working directory in the container to /app.
WORKDIR /app

# 3. Copy Application Files
# Copy the main application script and the templates directory into the container.
# It's assumed that `app.py` and the `templates` directory (containing `index.html`)
# are in the same directory as this Dockerfile (the build context).
COPY app.py .
COPY templates ./templates/

# 4. Install Dependencies
# Install Flask and deep-translator as specified in the Technical Design Document.
# In a production scenario, these would typically be listed in a requirements.txt file.
RUN pip install --no-cache-dir Flask deep-translator

# 5. Expose Port
# Expose port 5000, which is the default port Flask's development server runs on.
EXPOSE 5000

# 6. Define Environment Variables for Flask
# FLASK_APP tells Flask where to find the application.
# FLASK_RUN_HOST=0.0.0.0 makes the server accessible from outside the container.
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# 7. Define Command to Run the Application
# Use 'flask run' to start the Flask development server.
# The host is set to 0.0.0.0 via FLASK_RUN_HOST to be accessible.
CMD ["flask", "run"]
