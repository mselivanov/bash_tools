#!/bin/bash

# Find all the files in the current dir and subdirs by file name mask and then remove
find . -type f -name "*.pyc" -exec rm {} \;
