import pytest
from app import app # Ensure 'app' is imported from your main Flask application file (app.py)

# It's good practice to set up a test client fixture for pytest
@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_index_route_status_code(client):
    """Test that the index route (GET /) returns a 200 OK status."""
    response = client.get('/')
    assert response.status_code == 200

def test_get_index_route_renders_form_elements(client):
    """Test that the index route (GET /) renders the HTML form with required elements."""
    response = client.get('/')
    response_data = response.get_data(as_text=True)
    
    # Check for key HTML elements from templates/index.html
    assert '<title>Chinese to English Translator</title>' in response_data
    assert '<h1>Translate Chinese to English</h1>' in response_data
    assert '<form method="POST" action="/translate">' in response_data
    assert '<textarea name="chinese_text"' in response_data 
    assert 'placeholder="Enter Chinese text here..."' in response_data # Check placeholder too
    assert '<input type="submit" value="Translate">' in response_data

# The original placeholder test can be removed as we now have specific tests.
# If you had other tests, you would integrate these new ones.
