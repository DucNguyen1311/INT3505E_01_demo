# Allow scripts to run in this session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Activate the virtual environment
& "$PSScriptRoot/venv/Scripts/Activate.ps1"

# Run Flask app
python -m flask --app app run --debug
