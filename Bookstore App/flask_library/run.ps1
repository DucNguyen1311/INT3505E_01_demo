# Activate the virtual environment
& "$PSScriptRoot/venv/Scripts/Activate.ps1"
# Run Flask app
python -m flask --app app run --debug
