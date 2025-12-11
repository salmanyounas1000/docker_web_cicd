from flask import Flask
import os
import socket

app = Flask(__name__)

@app.route("/")
def hello():
    # We display the container ID to prove it's running inside Docker
    html = f"""
    <h3>Hello, DevOps Engineer!</h3>
    <b>Hostname:</b> {socket.gethostname()}<br/>
    <b>Status:</b> Application is Running!
    """
    return html

@app.route("/health")
def health():
    # A health check endpoint is standard for DevOps projects
    return {"status": "up"}, 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)