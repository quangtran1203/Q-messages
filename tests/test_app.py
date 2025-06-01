
import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_index_page_loads(client):
    """Test the / route serves index.html with the form."""
    response = client.get('/')
    assert response.status_code == 200
    response_data = response.data
    assert b'<form method="POST" action="/translate">' in response_data
    assert b'<textarea id="chinese_text" name="chinese_text"' in response_data
    assert b'<button type="submit">Translate</button>' in response_data
    # Ensure placeholder is not shown on initial load
    assert b"Translation will appear here." not in response_data

def test_translate_route(client):
    """Test the /translate route."""
    test_input_text = "你好"
    response = client.post('/translate', data={'chinese_text': test_input_text})
    assert response.status_code == 200
    response_data = response.data
    # Check that the original text is repopulated in the textarea
    expected_textarea_content = f'<textarea id="chinese_text" name="chinese_text" rows="10" cols="50">{test_input_text}</textarea>'
    assert bytes(expected_textarea_content, 'utf-8') in response_data
    # Check that the translation placeholder is shown
    assert b"Translation will appear here." in response_data
    # Check that the form is still present
    assert b'<form method="POST" action="/translate">' in response_data
