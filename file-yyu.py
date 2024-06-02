import subprocess

# Add your own file path here. Each URL must be on its own line.
with open('path/to/your/url_list.txt', 'r') as file:
    urls = file.readlines()

encodings = ["url","hex","unicode"]
    
for url in urls:
    url = url.strip() # Remove leading/trailing whitespaces
    
    for encoding in encodings:
        command = f"sqlmap -u '{url}' --tamper={encoding}"
        
        print(f"\nRunning command: {command}\n")
        
        process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
        output, error = process.communicate()
