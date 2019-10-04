import os
import sys
import http.server
from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

BASE_DIR = sys.argv[1]
HOSTNAME = os.path.join(BASE_DIR, '.dev.local')
CERT_PATH = os.getenv('CERTS_PERSONAL')
PORT = 4443

Handler = http.server.SimpleHTTPRequestHandler
httpd = HTTPServer((HOSTNAME, PORT), SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
    keyfile = os.path.join(CERT_PATH, 'localhost-key.pem'),
    certfile = os.path.join(CERT_PATH, 'localhost.pem'),
    server_side = True
)
print("serving on port", PORT)
httpd.serve_forever()
