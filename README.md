
# Chinese to English Translation Web Application

## 1. Overview

This project is a simple web application built with Python and Flask that translates Chinese text into English. It provides a user-friendly web interface for users to input Chinese text and receive its English translation. The application utilizes the `deep_translator` library for the translation service.

This application directly addresses the user requirement to "create a simple python webapp which translates chinese into english" by providing a functional web-based tool for this purpose.

## 2. Features

*   **Web Interface:** A clean and simple HTML page with a text area for inputting Chinese text and a button to initiate translation.
*   **Translation Display:** Shows both the original Chinese text and the translated English text on the same page.
*   **Core Translation:** Leverages the `deep_translator` library (specifically `GoogleTranslator`) to perform the translation.
*   **Basic Error Handling:** Displays a message if the translation process encounters an error.

## 3. Project Structure

The main components of this project are:

*   `app.py`: The main Flask application file. It handles HTTP requests, serves the HTML interface, and calls the translation service.
*   `translation_service.py`: Contains the logic for translating text from Chinese to English using the `deep_translator` library.
*   `templates/index.html`: The HTML template for the user interface, including the input form and the area for displaying results.
*   `requirements.txt`: Lists the Python dependencies required for the project (Flask, deep_translator).

## 4. Setup and Installation

To run this application locally, follow these steps:

**Prerequisites:**
*   Python 3.x installed on your system (you can check this by running `python --version` or `python3 --version` in your terminal).
*   Git (for cloning the repository, optional if you have the source code directly).

**Steps:**

1.  **Clone the Repository (if applicable):**
    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```
    (Replace `<repository_url>` and `<repository_directory>` with actual values if cloned. If you have the files directly, navigate to the project's root directory.)

2.  **Create and Activate a Virtual Environment:**
    It's highly recommended to use a virtual environment to manage project dependencies.

    *   On macOS and Linux:
        ```bash
        python3 -m venv venv
        source venv/bin/activate
        ```
    *   On Windows:
        ```bash
        python -m venv venv
        .\venv\Scripts\activate
        ```
    You should see `(venv)` at the beginning of your command prompt.

3.  **Install Dependencies:**
    Install the required Python libraries using the `requirements.txt` file:
    ```bash
    pip install -r requirements.txt
    ```
    This will install Flask and deep_translator.

## 5. Running the Application

Once the setup is complete, you can run the web application:

1.  **Execute the Flask Application:**
    Navigate to the root directory of the project (where `app.py` is located) and run:
    ```bash
    python app.py
    ```

2.  **Access the Application:**
    Open your web browser and go to the following URL:
    ```
    http://127.0.0.1:5000/
    ```
    (This is the default address and port for a Flask development server).

## 6. Usage and Expected Behavior

*   When you open `http://127.0.0.1:5000/`, you will see a webpage with:
    *   A title: "Chinese to English Translator".
    *   A text area for entering Chinese text (placeholder: '输入中文文本...').
    *   A "Translate" button.
*   Enter or paste Chinese characters into the text area.
*   Click the "Translate" button.
*   The page will reload or update, displaying:
    *   The original Chinese text you entered.
    *   The English translation of that text.
*   If the translation service encounters an issue (e.g., no internet connection, or an error from the `deep_translator` library), an error message should be displayed instead of the translation.
