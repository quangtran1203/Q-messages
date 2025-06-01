
# Chinese-to-English Translation Webapp (Prototype)

## Overview

This project is a simple web application designed to translate Chinese text into English, based on user requirements and a provided technical design.

Currently, the application is in its **prototype stage**. The implemented features based on the completed development tasks include:

*   A basic Flask web server (`app.py`).
*   A simple HTML user interface (`templates/index.html`) featuring a text area for Chinese input and a "Translate" button.
*   A `/translate` endpoint that processes the input.
*   A **stubbed** translation module (`translator.py`). This means that currently, the application does **not** perform real translation. Instead, it returns a fixed, hardcoded English phrase ("Stubbed English translation") regardless of the Chinese text entered.

The core functionality of receiving Chinese text and displaying a *placeholder* translation is operational.

## Environment Setup and Running Instructions

Follow these steps to set up and run the application locally.

### 1. Prerequisites

*   Python 3.x
*   `pip` (Python package installer, usually comes with Python)
*   A tool for creating virtual environments, like `venv` (recommended, part of Python's standard library).

### 2. Obtain the Code

Ensure you have the project files:
*   `app.py`
*   `translator.py`
*   `requirements.txt`
*   `templates/index.html`

(If this were a Git repository, you would typically clone it here.)

### 3. Setup Virtual Environment

It's highly recommended to use a virtual environment to manage project dependencies.

*   Navigate to the project's root directory in your terminal.
*   Create a virtual environment (e.g., named `venv`):
    ```bash
    python -m venv venv
    ```
*   Activate the virtual environment:
    *   On macOS and Linux:
        ```bash
        source venv/bin/activate
        ```
    *   On Windows:
        ```bash
        venv\Scripts\activate
        ```
    Your terminal prompt should change to indicate that the virtual environment is active.

### 4. Install Dependencies

The project's dependencies are listed in `requirements.txt`.

*   With your virtual environment active, install the dependencies:
    ```bash
    pip install -r requirements.txt
    ```
    (This will currently install Flask, as per the completed tasks.)

### 5. Expected Directory Structure

For context, your project directory should look similar to this:

```
.
├── app.py               # Main Flask application
├── translator.py        # Stubbed translation module
├── requirements.txt     # Project dependencies
└── templates/
    └── index.html       # HTML template for the UI
```

### 6. Running the Application

The application uses Flask's built-in development server.

*   Set the `FLASK_APP` environment variable to point to your main application file:
    *   On macOS and Linux:
        ```bash
        export FLASK_APP=app.py
        ```
    *   On Windows:
        ```bash
        set FLASK_APP=app.py
        ```
*   (Optional but recommended) Set Flask to development mode for debugging features:
    *   On macOS and Linux:
        ```bash
        export FLASK_ENV=development
        ```
    *   On Windows:
        ```bash
        set FLASK_ENV=development
        ```
*   Run the Flask development server:
    ```bash
    flask run
    ```
*   To stop the server, press `Ctrl+C` in the terminal where it is running.

### 7. Accessing the Application

*   Once the server is running (it will typically say something like `* Running on http://127.0.0.1:5000/`), open a web browser.
*   Navigate to: `http://127.0.0.1:5000/`

### 8. Expected Behavior

*   **Initial Page:** You should see a webpage with:
    *   A text area prompting for Chinese text.
    *   A "Translate" button.
*   **Submitting Text:**
    1.  Enter any text (or leave the text area empty) and click the "Translate" button.
    2.  The page will reload. You will see:
        *   The original text you entered (which will be blank if submitted empty).
        *   The phrase "Stubbed English translation" displayed as the translated output. This is because the current `translator.py` module is a stub and returns this fixed phrase regardless of the input.

## Future Work

This prototype serves as the foundation for the Chinese-to-English translation webapp. Future development will involve:

*   Implementing input validation (e.g., for empty submissions, as per TDD 3.1.4.2).
*   Replacing the stubbed translation module with one that interacts with an actual translation service (e.g., MyMemory API).
*   Implementing more robust error handling for API interactions.
*   Potentially adding styling and improving the user interface.
