
# Dockerfile for the Chinese-to-English Web Translator

# --- Build Instructions ---
# To build the Docker image, navigate to the directory containing this Dockerfile
# (e.g., 'simple_translator/'), the application code, and 'requirements.txt', then run:
#
# docker build -t simple-translator .
#
# Example: If your Dockerfile and app code are in '~/projects/simple_translator',
# cd ~/projects/simple_translator
# docker build -t simple-translator .
#
# Ensure 'requirements.txt' includes Flask, the translation library (e.g., translators), and Gunicorn.
# Example requirements.txt:
# Flask
# translators
# gunicorn
#
# --- Run Instructions ---
# To run the Docker container from the built image:
#
# docker run -d -p 5000:5000 --name simple-translator-app simple-translator
#
# This command does the following:
# - '-d': Runs the container in detached mode (in the background).
# - '-p 5000:5000': Maps port 5000 of your host machine to port 5000 in the container.
#   The application inside the container listens on port 5000.
# - '--name simple-translator-app': Assigns a name to the running container for easier management.
# - 'simple-translator': Specifies the image to run.
#
# After running, you can access the application at http://localhost:5000 in your web browser.
#
# --- Other Useful Docker Commands ---
# To view the logs of the running container:
# docker logs simple-translator-app
#
# To stop the container:
# docker stop simple-translator-app
#
# To remove the container (must be stopped first):
# docker rm simple-translator-app
#
# To list running containers:
# docker ps
#
# To list all containers (including stopped ones):
# docker ps -a

# 1. Base Image
# Use an official Python runtime as a parent image.
# python:3.9-slim is a good choice for a balance of features and size.
FROM python:3.9-slim

# 2. Set Working Directory
# Sets the working directory in the container for subsequent commands.
WORKDIR /app

# 3. Copy Application Files & Install Dependencies
# Copy the requirements file first to leverage Docker's layer caching.
# If requirements.txt doesn't change, this layer won't be rebuilt.
COPY requirements.txt .

# Install dependencies from requirements.txt (ensure Gunicorn is listed here).
# --no-cache-dir is used to reduce image size by not storing the pip cache.
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the application code into the /app directory in the container.
COPY app.py .
COPY translator_module.py .
COPY templates/ ./templates/
# If you have a 'static' directory for CSS/JS, ensure it's in the same directory
# as this Dockerfile and uncomment the following line to copy it:
# COPY static/ ./static/

# 4. Expose Port
# Informs Docker that the container listens on the specified network ports at runtime.
# This does not actually publish the port to the host. The -p flag in `docker run` does that.
EXPOSE 5000

# 5. Command to Run the Application
# Specifies the command to execute when the container starts.
# We use Gunicorn as the WSGI server to run the Flask application.
# -b 0.0.0.0:5000: Binds Gunicorn to all available network interfaces on port 5000 within the container.
# app:app: Tells Gunicorn to look for a Flask app instance named 'app' in a Python module named 'app.py'.
# Ensure your Flask app instance in app.py is named 'app' (e.g., app = Flask(__name__)).
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
