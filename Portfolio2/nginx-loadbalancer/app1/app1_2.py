from flask import request, Flask
import socket

app1 = Flask(__name__)

@app1.route('/test')
def hello():
    return f"Hello from container {socket.gethostname()}"


if __name__ == '__main__':
   app1.run(debug=True, host='0.0.0.0')