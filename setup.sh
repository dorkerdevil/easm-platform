#!/bin/bash

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt

# Run external tools installer script
chmod +x scripts/install_tools.sh
./scripts/install_tools.sh

# Initialize database by running a small script
python3 -c "
from app import create_app
app = create_app()
with app.app_context():
    pass
"

echo "Setup complete. To start the server, run:"
echo "source venv/bin/activate"
echo "flask run --host=0.0.0.0 --port=8000"