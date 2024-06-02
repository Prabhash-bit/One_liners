import requests
from urllib.parse import urlparse, quote
import binascii
import codecs

# Existing encoding functions remain unmodified ...

encoders = {
    "ASCII": encode_ascii,
    "Unicode": encode_unicode,
    "Base64": encode_base64
}

def load_urls(file_path="urls.txt"):
    """Function to load URLs from a file"""

    with open(file_path, 'r', newline='', encoding='utf-8') as url_file:
        urls = [url.strip("\n") for url in url_file]
      
    return urls

def load_payloads(file_path="payloads.txt"): 
    '''Function to load Payloads from a file'''

    with open(file_path, 'r', newline='', encoding='utf-8') as payload_file:
        payloads = [payload.strip("\n") for payload in payload_file]

    return payloads

def check_encoded_vulnerability(urls, payloads, encodings=1):    
    """Check for XSS Vulnerabilities with Various Encodings ..."""      

    for url in urls:
        base_url = urlparse(url)        
        ...
        # Rest of the function remains unchanged ...

# Load URLs from file
urls = load_urls()

# Load Payloads from file
payloads = load_payloads()

# Execute the function
check_encoded_vulnerability(urls, payloads, 3)