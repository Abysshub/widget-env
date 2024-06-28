#!/bin/bash
WIDGET_DIR=/usr/src/app/widget

# Function to send error message to callback URL
send_error() {
    local message=$1
    echo "Sending error: ${message}"
}

error_handler() {
    send_error "The widget didn't work correctly. Your byssiums will be transferred to your account."
    exit 1
}

trap 'error_handler' ERR
set -e

for var in $(compgen -e); do
    export "$var"
done

# Download python packages
pip install -r $WIDGET_DIR/requirements.pip

# Download system packages
apt-get update
xargs apt-get -y install < $WIDGET_DIR/requirements.system

# Run the Python script
cd $WIDGET_DIR
python3 $WIDGET_DIR/run.py

# Send output to S3
if [ -d "$WIDGET_DIR/output" ]; then
    echo "Sending output: Run successfull"
else
   send_error "The widget didn't work correctly. Your byssiums will be transferred to your account."
fi
