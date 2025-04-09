import sys
import requests
from requests_toolbelt.multipart.encoder import MultipartEncoder

# Check if the access token is provided as a command line argument
if len(sys.argv) < 2:
    print("Usage: python script.py <access_token>")
    sys.exit(1)

# Get the access token from the first command line argument
access_token = sys.argv[1]

# Replace this variable with your actual page ID
section_id = 'x-xxxxxxxx-yyyy-zzzz-zzzz-yyyyyyyyyyyy'
html_content = """
<!DOCTYPE html>
<html>
<head>
    <title>OneNote Page</title>
    <meta name="created" content="1984-01-01T04:00:00-02:00" />
</head>
<body>
    <object data-attachment="file.pdf" data="name:EmbeddedFileBlocksName1" type="application/pdf" />
    <p>Stitch that!</p>
    <img src="name:EmbeddedFileBlocksName2" alt="Ox Image" />
</body>
</html>
"""

# Prepare the multipart data with a custom boundary
m = MultipartEncoder(
    fields={
        'Presentation': ('page.html', html_content, 'text/html'),
        'EmbeddedFileBlocksName1': ('file.pdf', open('assets/example.pdf', 'rb'), 'application/pdf'),
        'EmbeddedFileBlocksName2': ('rainbow.png', open('assets/r4inbow_show3r.png', 'rb'), 'image/png')
    },
    boundary='MyBoundary1337'
)

# Send the request
response = requests.post(
    f'https://graph.microsoft.com/v1.0/me/onenote/sections/{section_id}/pages',
    headers={
        'Authorization': f'Bearer {access_token}',
        'Content-Type': m.content_type
    },
    data=m
)

# Check the response
if response.status_code == 201:
    print('Page created successfully!')
else:
    print(f'Failed to create page: {response.status_code}')
    print(response.text)
