#!/bin/bash

# Function to create environment for PyTorch
poetry_add_pytorch() {
  echo "⚙️  Creating PyTorch environment..."
  poetry remove tensorflow >> .devcontainer/logs.log
  poetry source add --priority=explicit pytorch-cu124 https://download.pytorch.org/whl/cu124 >> .devcontainer/logs.log
  poetry add --source pytorch-cu124 torch==2.5.0+cu124 torchvision==0.20.0+cu124 torchaudio==2.5.0+cu124 >> .devcontainer/logs.log
  echo "✅ PyTorch environment setup complete."
}

# Function to create environment for TensorFlow
poetry_add_tensorflow() {
  echo "⚙️  Creating TensorFlow environment..."
  poetry remove torch torchvision torchaudio >> .devcontainer/logs.log
  poetry add tensorflow[and-cuda]==2.17.0 >> .devcontainer/logs.log
  echo "✅ TensorFlow environment setup complete."
}

# Function to create environment for PyTorch
venv_add_pytorch() {
  echo "⚙️  Creating PyTorch environment..."
  python -m venv .venv-pt
  .venv-pt/bin/python -m pip install --upgrade pip --no-warn-script-location --root-user-action=ignore >> .devcontainer/logs.log
  .venv-pt/bin/python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124 --no-warn-script-location --root-user-action=ignore >> .devcontainer/logs.log
  echo "✅ PyTorch environment setup complete."
}

# Function to create environment for TensorFlow
venv_add_tensorflow() {
  echo "⚙️  Creating TensorFlow environment..."
  python -m venv .venv-tf
  .venv-tf/bin/python -m pip install --upgrade pip --no-warn-script-location --root-user-action=ignore >> .devcontainer/logs.log
  .venv-tf/bin/python -m pip install tensorflow[and-cuda]==2.17.0 --no-warn-script-location --root-user-action=ignore >> .devcontainer/logs.log
  echo "✅ TensorFlow environment setup complete."
}

# Allow running of Jupyter Notebook cells with global Python environment
clear
echo "⚙️  Instaling dependencies..."
python -m pip install poetry --no-warn-script-location --root-user-action=ignore  >> .devcontainer/logs.log
python -m pip install poetry-plugin-shell --no-warn-script-location --root-user-action=ignore  >> .devcontainer/logs.log
poetry install >> .devcontainer/logs.log

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