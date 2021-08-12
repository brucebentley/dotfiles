import os
import sys
import http.server
from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

BASE_DIR = os.path.dirname(__file__)
HOSTNAME = os.path.join(BASE_DIR, '.dev.local')
CERT_PATH = os.getenv('CERT_LOCALHOST')
PORT = 4443

Handler = http.server.SimpleHTTPRequestHandler
httpd = HTTPServer((HOSTNAME, PORT), SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
    keyfile = os.path.join(CERT_PATH, 'local-key.pem'),
    certfile = os.path.join(CERT_PATH, 'local-cert.pem'),
    server_side = True
)
print("serving on port", PORT)
httpd.serve_forever()
