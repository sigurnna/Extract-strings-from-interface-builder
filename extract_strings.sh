#!/usr/bash

help() {
    echo "extract_strings_from_interface_builder: [-p <xcode_project_path>] [-e <strings_extract_path>]"
    exit 1
}

while getopts "p:e:h" opt; do
    case $opt in
        p) # project dir
            PROJECT_DIR="$OPTARG"
            ;;
        e) # extract dir
            EXTRACT_DIR="$OPTARG"
            ;;
        h) help ;;
    esac
done

if [ -z "$PROJECT_DIR" ] || [ -z "$EXTRACT_DIR" ]; then
    help
    exit 1
fi

EXTRACT_FILENAME="extract.strings"

cd $PROJECT_DIR

if [ ! -d "$EXTRACT_DIR" ]; then
    mkdir $EXTRACT_DIR
fi

# Extract strings from storyboards or xibs
find . -name "*.storyboard" -o -name "*.xib" | while read FILENAME; do
    ibtool --generate-strings-file "$FILENAME.txt" $FILENAME
    mv "$FILENAME.txt" $EXTRACT_DIR
done

cd $EXTRACT_DIR

# Concatenate string files to single file
find . -name "*.txt" | while read FILENAME; do
    cat $FILENAME >> $EXTRACT_FILENAME
    rm $FILENAME
done

exit 0
