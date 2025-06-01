import unittest
from app import app # Assuming your Flask app instance is named 'app' in app.py
from flask import Flask

class AppTestCase(unittest.TestCase):
    def setUp(self):
        # Create a test client
        app.config['TESTING'] = True
        self.client = app.test_client()

    def test_flask_app_exists(self):
        # Test if the app instance exists and is a Flask app
        self.assertIsNotNone(app)
        self.assertIsInstance(app, Flask)

    def test_home_page_status_code_and_content(self): # Renamed for clarity
        # Test if the home page returns a 200 OK status and contains expected content
        result = self.client.get('/')
        self.assertEqual(result.status_code, 200)
        # Check for some distinctive content from index.html
        # result.data is bytes, so we decode it to string
        response_text = result.data.decode('utf-8')
        self.assertIn("<title>Chinese to English Translator</title>", response_text)
        self.assertIn("<h1>Chinese to English Translator</h1>", response_text) # Another check

    def test_index_html_static_elements(self):
        # Test if essential static elements are present in index.html
        # This test reads the file directly, it does not test rendering via Flask yet
        with open("templates/index.html", "r", encoding="utf-8") as f:
            html_content = f.read()

        self.assertIn("<form method=\"POST\" action=\"/translate\">", html_content)
        self.assertIn("<textarea name=\"chinese_text\"", html_content) # Check for the start of the textarea tag with the correct name
        self.assertIn("<button type=\"submit\">Translate</button>", html_content)
        # Also good to check for placeholders:
        self.assertIn("id=\"translation_result\"", html_content)
        self.assertIn("id=\"error_message_area\"", html_content)

if __name__ == '__main__':
    unittest.main()