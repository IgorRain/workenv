#!/usr/bin/env bash
set -e

EXEC_NAME=$(basename $0)
if [[ -L $0 ]]; then
    RESOURCE_DIR=$(dirname $(readlink $0))
else
    RESOURCE_DIR=$(dirname $0)
fi

show_help() {
    echo "Usage: $EXEC_NAME [PATH_TO_JSON_FILE]"
    echo ""
    echo "Description:"
    echo "  Add my favorite bells and whistles to every devcontainer config."
    echo ""
    echo "Options:"
    echo "  --help    Show this help message and exit"
    exit 0
}

if ! type jq &> /dev/null; then
    echo "This script requires jq to work."
fi

if [[ "$1" == "--help" ]]; then
    show_help
fi

if [ -z "$1" ]; then
    echo "Error: No file path provided."
    echo "Type '$EXEC_NAME --help' for usage information."
    exit 1
fi

FILE_PATH="$1"
TMP_FILE=$FILE_PATH.tmp
PATCH_FILE=patch.json

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found."
    exit 1
fi

jq ".mounts += [\"source=$RESOURCE_DIR/setup.sh,target=/home/vscode/setup.sh,type=bind,consistency=cached\", \"source=$RESOURCE_DIR/Brewfile,target=/home/vscode/.Brewfile,type=bind,consistency=cached\"]" $RESOURCE_DIR/addition.json > $PATCH_FILE

jq -s '.[0] * .[1]' $FILE_PATH $PATCH_FILE > $FILE_PATH.tmp
rm $PATCH_FILE
mv $TMP_FILE $FILE_PATH
