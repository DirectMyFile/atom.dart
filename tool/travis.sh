#!/bin/bash

# Fast fail the script on failures.
set -e

# Verify that the libraries are error free.
pub global activate tuneup
pub global run tuneup check

# Run the tests.
#dart test/all.dart
