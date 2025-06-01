
**Task P4: Implement Translation Endpoint and Dynamic Display**

*   **Description:** Implement the `POST /translate` endpoint to handle form submissions, integrate a mock translation service, and update the `index.html` template to dynamically display the original text, translated text, or error messages using Jinja2.
*   **Acceptance Criteria:**
    *   **`app.py`:**
        *   The `request` object from `flask` is imported.
        *   A new route `/translate` is defined that accepts `POST` requests.
        *   The `/translate` route function extracts `chinese_text` from the form data.
        *   A mock translation function is implemented within `app.py`.
            *   This function accepts Chinese text and returns a mock English translation (e.g., `"[mock translation of] " + chinese_text`).
            *   This function can simulate an error (e.g., if input is "error", it returns an error message and no translation).
        *   The `/translate` route function calls the mock translation function.
        *   The `index.html` template is re-rendered with `original_text`, `translated_text` (if successful), and `error_message` (if an error occurred) passed as context variables.
    *   **`templates/index.html`:**
        *   The `<textarea name="chinese_text">` is updated to display `{{ original_text }}`.
        *   The translation display area is updated to show `{{ translated_text }}` only if it's available (e.g., using `{% if translated_text %}`).
        *   The error display area is updated to show `{{ error_message }}` only if it's available (e.g., using `{% if error_message %}`).
    *   **`test_app.py`:**
        *   New unit tests are added for the `POST /translate` route.
        *   A test case for successful translation:
            *   Sends a `POST` request with `chinese_text`.
            *   Asserts a 200 OK status code.
            *   Asserts that the response HTML contains the mock translated text.
            *   Asserts that the response HTML contains the original text re-populated in the textarea.
        *   A test case for a translation error (e.g., by sending "error" as input):
            *   Asserts a 200 OK status code (as the page is re-rendered with the error).
            *   Asserts that the response HTML contains the mock error message.
            *   Asserts that no translated text is displayed.
            *   Asserts that the original text ("error") is re-populated in the textarea.
*   **Phase:** Prototyping
*   **Priority:** High
*   **Rationale:** Implements the core translation request handling, provides a mock backend for translation, and makes the UI dynamic, which are crucial steps towards a functional prototype as per the TDD.
*   **Goal:** To have a functional `POST /translate` endpoint that uses a mock translation service and dynamically updates the user interface with results or errors, verified by unit tests.
*   **Dependencies:** Task P1, Task P2, Task P3
