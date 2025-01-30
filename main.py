from flask import Flask
import time
import threading

app = Flask(__name__)

# CPU-intensive function to simulate load (Fibonacci calculation)
def fibonacci(n):
    if n <= 1:
        return n
    else:
        return fibonacci(n-1) + fibonacci(n-2)

# Function that simulates load
def simulate_cpu_load():
    while True:
        # Simulate high CPU usage by calculating Fibonacci(35)
        fibonacci(35)  # You can increase this number for more CPU load

@app.route('/')
def hello_world():
    return 'Hello, World from abhishek! CPU load simulation running...'

# No need for the `if __name__ == '__main__':` block when using Gunicorn
# Gunicorn will automatically call the app object and run it
# Start the CPU load simulation in a separate thread
threading.Thread(target=simulate_cpu_load, daemon=True).start()
