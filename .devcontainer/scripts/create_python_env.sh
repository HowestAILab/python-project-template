#!/bin/bash

# Function to create environment for PyTorch
poetry_add_pytorch() {
  echo "⚙️  Creating PyTorch environment..."
  poetry remove tensorflow >> .devcontainer/logs.log
  poetry add --source pytorch-gpu torch==2.7.0+cu128 torchvision==0.22.0+cu128 torchaudio==2.7.0+cu128 >> .devcontainer/logs.log
  echo "✅ PyTorch installed succesfully."
}

# Function to create environment for TensorFlow
poetry_add_tensorflow() {
  echo "⚙️  Creating TensorFlow environment..."
  poetry remove torch torchvision torchaudio >> .devcontainer/logs.log
  poetry add tensorflow[and-cuda]==2.19.0 >> .devcontainer/logs.log
  echo "✅ TensorFlow installed succesfully."
}

# Install Poetry and Poetry Shell
clear
echo "⚙️  Installing Poetry..."
python -m pip install poetry --no-warn-script-location --root-user-action=ignore  >> .devcontainer/logs.log
python -m pip install poetry-plugin-shell --no-warn-script-location --root-user-action=ignore  >> .devcontainer/logs.log
echo "✅ Poetry installed succesfully."
echo "⚙️  Installing dependencies..."
poetry install >> .devcontainer/logs.log
echo "✅ Dependencies installed succesfully."

# Ask if the user wants to create a PyTorch environment
echo "❓ What framework does your project require?"
echo "   1. PyTorch"
echo "   2. TensorFlow"
echo "   3. None of the above"
read -p "   Choice (1/2/3): " framework
if [[ "$framework" == "1" ]]; then
  poetry_add_pytorch
elif [[ "$framework" == "2" ]]; then
  poetry_add_tensorflow
fi

# Finished
echo ""
echo "😀 Setup completed, good luck with your project!"
echo ""

poetry shell