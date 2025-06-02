
from deep_translator import GoogleTranslator
import unittest
from unittest.mock import patch

def translate_text(chinese_text: str) -> str | None:
    """
    Translates Chinese text to English using GoogleTranslator.

    Args:
        chinese_text: The Chinese text to translate.

    Returns:
        The translated English text, or None if translation fails.
    """
    if not chinese_text:
        return "" # Or handle as an error, TBD based on stricter reqs if any

    try:
        # According to TDD 3.2.1, source can be 'auto' or 'zh-CN'
        # Using 'zh-CN' for more explicitness as we know the source.
        translated_text = GoogleTranslator(source='zh-CN', target='en').translate(chinese_text)
        return translated_text
    except Exception as e:
        print(f"Translation error: {e}")
        return None

# Basic Unit Tests
class TestTranslationService(unittest.TestCase):

    def test_successful_translation(self):
        """Test successful translation of a known Chinese string."""
        chinese_input = "你好世界" # Hello World
        expected_english_output = "Hello World"
        # Note: Actual translation might vary slightly. This is a placeholder.
        # For robust testing, we might need to mock the translator's response
        # or use a very stable, simple phrase. Given the library's nature,
        # we'll proceed with an actual call for this basic test.
        # If this proves flaky, mocking `GoogleTranslator.translate` would be next.
        
        # To make the test more robust against minor variations from the live service,
        # we will mock the translate method for this specific test.
        with patch.object(GoogleTranslator, 'translate', return_value=expected_english_output) as mock_method:
            translated_text = translate_text(chinese_input)
            self.assertEqual(translated_text, expected_english_output)
            mock_method.assert_called_once_with(chinese_input)

    def test_translation_failure(self):
        """Test that the function returns None when translation fails."""
        with patch.object(GoogleTranslator, 'translate', side_effect=Exception("Simulated translation error")):
            translated_text = translate_text("你好")
            self.assertIsNone(translated_text)

    def test_empty_input(self):
        """Test translation with empty input string."""
        self.assertEqual(translate_text(""), "")

    def test_non_chinese_input_auto_detection(self):
        """
        Test with non-Chinese input.
        The function currently specifies source='zh-CN'.
        If we used source='auto', this test would be different.
        For now, this might lead to an error or incorrect translation.
        Let's assume it might return None or an attempt by Google to translate.
        This test depends on how GoogleTranslator handles non-Chinese text when source is 'zh-CN'.
        It will likely raise an exception or return something unexpected.
        """
        # This test is more complex as the behavior of GoogleTranslator with 'zh-CN' for non-Chinese text isn't strictly defined.
        # Forcing an error is a good way to test the exception handling.
        with patch.object(GoogleTranslator, 'translate', side_effect=Exception("Simulated error for non-Chinese")) as mock_method:
            result = translate_text("Hello")
            self.assertIsNone(result)
            mock_method.assert_called_once_with("Hello")


if __name__ == '__main__':
    # Example Usage:
    # text_to_translate = "你好，世界"
    # translation = translate_text(text_to_translate)
    # if translation:
    #     print(f"Original: {text_to_translate}")
    #     print(f"Translated: {translation}")
    # else:
    #     print("Translation failed.")
    
    # Running tests
    unittest.main()
