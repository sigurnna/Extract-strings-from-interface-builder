#!/usr/bash

PROJECT_DIR="/Users/iseungjun/Development/upbit-ios-global"
SAVE_PATH="$PROJECT_DIR/extract_string"
SAVE_FILENAME="extract.strings"

cd $PROJECT_DIR

if [ ! -d "$SAVE_PATH" ]; then
    mkdir $SAVE_PATH
fi

# Extract strings from storyboards or xibs
find . -name "*.storyboard" -o -name "*.xib" | while read FILENAME; do
    ibtool --generate-strings-file "$FILENAME.txt" $FILENAME
    mv "$FILENAME.txt" $SAVE_PATH
done

cd $SAVE_PATH

# Concatenate string files to single file
find . -name "*.txt" | while read FILENAME; do
    cat $FILENAME >> $SAVE_FILENAME
    rm $FILENAME
done
