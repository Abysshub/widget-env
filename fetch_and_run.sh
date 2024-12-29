#!/bin/bash
WIDGET_DIR=/usr/src/app/widget

# Run the Python script
cd $WIDGET_DIR

python3 "$WIDGET_DIR/run.py"
exit_code=$?

if [ -d "$WIDGET_DIR/output" ] && [ "$exit_code" -eq 0 ]; then
    cd $WIDGET_DIR/output

    if find . -type f | grep -q .; then
        message="Successful run"

        if [ $? -ne 0 ]; then
            message="Oops! Something went wrong"
        fi
    else
        message="Error. Output folder is empty"
    fi
else
    message="Error. Output folder is not exist"
fi

if [ $exit_code -ne 0 ]; then
    message="Error encountered while executing run.py"
fi

echo $message
