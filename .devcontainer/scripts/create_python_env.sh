#!/bin/bash

mode="$1"

echo "⚙️  Checking hardware config..."
if [[ "$mode" == "cpu" ]]; then
  echo "✅ Running in CPU-only mode."
elif [[ "$mode" == "gpu" ]]; then
  echo "✅ Running in GPU-accelerated mode."
else
  echo "⚠️  Unknown hardware config. Defaulting to CPU-only mode."
fi


# Function to create environment for PyTorch
uv_add_pytorch() {
  echo "⚙️  Creating PyTorch environment..."
  #uv remove tensorflow >> .devcontainer/logs.log

  if [[ "$mode" == "gpu" ]]; then
    uv sync --extra pt-gpu >> .devcontainer/logs.log
    echo "✅ PyTorch (GPU) installed succesfully."
  else
    uv sync --extra pt-cpu >> .devcontainer/logs.log
    echo "✅ PyTorch (CPU) installed succesfully."
  fi
}

# Function to create environment for TensorFlow
uv_add_tensorflow() {
  echo "⚙️  Creating TensorFlow environment..."
  #uv remove torch torchvision torchaudio >> .devcontainer/logs.log

  if [[ "$mode" == "gpu" ]]; then
    uv sync --extra tf-gpu >> .devcontainer/logs.log
    echo "✅ Tensorflow (GPU) installed succesfully."
  else
    uv sync --extra tf-cpu >> .devcontainer/logs.log
    echo "✅ Tensorflow (CPU) installed succesfully."
  fi
}

# Function to create default environment
uv_add_default() {
  echo "⚙️  Creating normal environment..."
  #uv remove torch torchvision torchaudio >> .devcontainer/logs.log
  #uv remove tensorflow >> .devcontainer/logs.log
  uv sync >> .devcontainer/logs.log
  echo "✅ Normal environment installed succesfully."
}

complete() {
  # Finished
  echo ""
  echo "😀 Setup completed, good luck with your project!"
  echo ""
  source .venv/bin/activate
}

# Install uv
echo "⚙️  Installing uv..."
python -m pip install uv --no-warn-script-location --root-user-action=ignore >> .devcontainer/logs.log
echo "✅ uv installed succesfully."

# Ask if the user wants to create a PyTorch environment
echo "❓ What framework does your project require?"
echo "   1. PyTorch"
echo "   2. TensorFlow"
echo "   3. None of the above"
read -p "   Choice (1/2/3): " framework
if [[ "$framework" == "1" ]]; then
  uv_add_pytorch
  complete
elif [[ "$framework" == "2" ]]; then
  uv_add_tensorflow
  complete
elif [[ "$framework" == "3" ]]; then
  uv_add_default
  complete
else
  echo "❌ Invalid choice."
  complete
fi