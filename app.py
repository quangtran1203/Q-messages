
from flask import Flask, render_template, request
from translation_service import translate_text

app = Flask(__name__)

@app.route('/')
def index():
    """
    Serves the main HTML page.
    """
    return render_template('index.html')

@app.route('/translate', methods=['POST'])
def translate_route():
    """
    Handles the translation request.
    Receives Chinese text from the form, translates it, and re-renders the page
    with the translation or an error message.
    """
    chinese_text_input = request.form.get('chinese_text', '').strip()
    original_text_for_template = chinese_text_input
    translated_text_for_template = None
    error_message_for_template = None

    if not chinese_text_input:
        error_message_for_template = "Input text cannot be empty. Please enter some Chinese text to translate."
    else:
        try:
            # Call the translation service
            translation_result = translate_text(chinese_text_input)

            if translation_result is None:
                # This case handles exceptions from deep_translator as per translation_service.py
                error_message_for_template = "Translation failed. The translation service encountered an error."
            elif translation_result == "" and chinese_text_input != "":
                 # This case could happen if translate_text itself returns "" for non-empty input
                 # for some reason, though current translate_text doesn't do this for non-empty valid inputs.
                 # More likely, if translate_text returned "", it was for an empty input, which we already checked.
                 # However, to be safe, if we get an empty string back for non-empty input, treat as error.
                 error_message_for_template = "Translation resulted in an empty string. Please try different text."
            else:
                translated_text_for_template = translation_result
        except Exception as e:
            # Catch any other unexpected errors during the process
            app.logger.error(f"Unexpected error in /translate route: {e}")
            error_message_for_template = "An unexpected error occurred. Please try again later."

    return render_template('index.html',
                           original_text=original_text_for_template,
                           translated_text=translated_text_for_template,
                           error_message=error_message_for_template)

if __name__ == '__main__':
    app.run(debug=True)
