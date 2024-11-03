
from flask import request, Flask

app1 = Flask(__name__)


@app1.route('/')
def hello_world():
    return '<h1>Hello from server 2</h2>'


if __name__ == '__main__':
   app1.run(debug=True, host='0.0.0.0')