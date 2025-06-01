
# Simple Chinese-to-English Web Translator (Prototype)

## 1. Overview

This project is a simple web application built with Python and Flask that aims to translate Chinese text into English. Currently, this is a prototype version where the translation functionality is **mocked**. Instead of performing a real translation, the application returns a placeholder string indicating that the translation was attempted.

This README provides instructions on how to set up and run the current prototype.

## 2. Implemented Features (Based on Completed Tasks)

*   **Basic Web Interface:** A web page with a form to input Chinese text.
*   **Text Submission:** Users can submit Chinese text through the form.
*   **Mock Translation Display:** Upon submission, the application displays the original Chinese text and a *mock* translated English text.
*   **Basic Error Handling:** If no text is submitted, a message prompts the user to enter text.
*   **Project Structure:** Basic project structure (`app.py`, `translator_module.py`, `templates/index.html`) is in place.
*   **Unit Tests:** Basic unit testing framework (pytest) is configured.

## 3. Directory Structure

The project follows this basic structure:

```
simple_translator/
├── app.py                 # Main Flask application logic and routes
├── translator_module.py   # Handles mock translation logic
├── templates/
│   └── index.html         # Jinja2 template for the form and results
└── requirements.txt       # Python dependencies
```

*(Note: `static/` directory for CSS/JS may be added later as per the TDD but is not part of the current completed tasks.)*

## 4. Setup and Installation

Follow these steps to set up your local environment and run the application.

### Prerequisites

*   Python 3.x (e.g., Python 3.7 or newer)
*   `pip` (Python package installer)

### Steps

1.  **Clone the Repository (if applicable):**
    If you have this project as a repository, clone it to your local machine. If you only have the files, ensure they are in a directory structure as described above, with `simple_translator` as the root project folder if `app.py` is inside it. Based on the TDD, the root is `simple_translator/`.

2.  **Navigate to the Project Directory:**
    Open your terminal or command prompt and navigate to the root directory of the project where `app.py` is located (e.g., `cd path/to/simple_translator`).

3.  **Create a Virtual Environment (Recommended):**
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
    You should see `(venv)` at the beginning of your terminal prompt, indicating the virtual environment is active.

4.  **Install Dependencies:**
    With the virtual environment activated, and ensuring you are in the directory containing `requirements.txt` (which should be `simple_translator/`), install the required Python packages:
    ```bash
    pip install -r requirements.txt
    ```
    This will install `Flask` and `pytest`.

## 5. Running the Application

1.  **Start the Flask Development Server:**
    Ensure you are in the `simple_translator` directory (the one containing `app.py`) and your virtual environment is active. Run the following command:
    ```bash
    python app.py
    ```
    You should see output similar to:
    ```
     * Serving Flask app 'app'
     * Running on http://127.0.0.1:5000 (Press CTRL+C to quit)
    ```
    *(The exact port might vary if 5000 is in use, but Flask's default is 5000).*

2.  **Access the Application:**
    Open your web browser and navigate to:
    ```
    http://127.0.0.1:5000/
    ```

## 6. How to Use

1.  When you open the application in your browser, you will see a simple web page with a text area.
2.  Enter any Chinese text (or any text, as the translation is currently mocked) into the text area.
3.  Click the "Submit" button.
4.  The page will reload, displaying:
    *   The original text you entered.
    *   A **mock translation** (e.g., "Mock translation of: [your_text]").
5.  If you submit the form with an empty text area, a message will prompt you to enter text.

---

This README reflects the state of the project after the completion of tasks up to "Task 1.3: Implement Mock Translation Logic and Basic POST Handling." The actual translation functionality using an external library is not yet implemented.
