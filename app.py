from flask import Flask, render_template, request
from deep_translator import GoogleTranslator # New import

app = Flask(__name__)

# Internal helper function for translation as per TDD
def _translate_text(text_to_translate):
    """
    Translates a given text from Chinese to English.
    Returns a tuple (translated_text, error_message).
    """
    try:
        # Initialize translator
        translator = GoogleTranslator(source='zh-CN', target='en')
        # Perform translation
        translated_text = translator.translate(text_to_translate)
        return translated_text, None  # Success: return translated text, no error
    except Exception as e:
        # Handle potential errors from the deep-translator library (e.g., network issues)
        # Log the error for debugging (optional, but good practice for real apps)
        # print(f"Translation error: {e}")
        return None, "Translation service unavailable or an error occurred during translation." # Failure: return None for text, and an error message

@app.route('/', methods=['GET', 'POST'])
def index_page():
    error_message = None
    original_text = None
    translated_text = None # Initialize translated_text

    if request.method == 'POST':
        original_text = request.form.get('chinese_text')

        if not original_text or not original_text.strip():
            error_message = "Input text cannot be empty."
        else:
            # Input is valid, proceed with translation
            translated_text, translation_error = _translate_text(original_text)
            if translation_error:
                error_message = translation_error # If translation fails, set its error message
                # translated_text will remain None as returned by _translate_text on error

    return render_template('index.html', 
                           original_text=original_text, 
                           translated_text=translated_text, # Pass translated_text to template
                           error_message=error_message)

if __name__ == '__main__':
    app.run(debug=True)