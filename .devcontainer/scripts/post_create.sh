#!/bin/bash

# Prompt user to create virtual environments for TensorFlow and/or PyTorch
clear

bash .devcontainer/scripts/create_python_env.sh "$1"

# Feel free to add setup commands here, they will run once after (re)building the devcontainer