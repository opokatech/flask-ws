from flask import Flask, render_template
from flask_socketio import SocketIO

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 1

socketio = SocketIO(app)

@app.route('/')
def index():
    return render_template('index.html')

@socketio.on('connect')
def test_connect():
    return False


if __name__ == '__main__':
    socketio.run(app)
