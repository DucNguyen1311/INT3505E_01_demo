#!/bin/bash

# Activate the virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Run Flask app
echo "Starting Flask app (http://127.0.0.1:5000)..."
python -m flask --app app run --debug