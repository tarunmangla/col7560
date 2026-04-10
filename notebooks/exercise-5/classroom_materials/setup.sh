#!/bin/bash
# Setup script for Trustee Tutorial (Unix/Mac/Linux)

echo "======================================"
echo "Trustee Tutorial Setup"
echo "======================================"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "Python version:"
PYTHON_VERSION=$(python3 --version)
echo "$PYTHON_VERSION"

# Extract major and minor version
PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')

# Check Python version
if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]); then
    echo "❌ Error: Python 3.8 or higher required. You have Python $PYTHON_MAJOR.$PYTHON_MINOR"
    exit 1
fi

# Warn about Python 3.13+ compatibility issues
if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 13 ]; then
    echo ""
    echo "⚠️  WARNING: Python 3.13+ detected!"
    echo "Some packages may have compatibility issues."
    echo "Recommended: Use Python 3.11 or 3.12 for best compatibility."
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled. Please install Python 3.11 or 3.12 and try again."
        exit 1
    fi
fi

# Create virtual environment
echo ""
echo "Creating virtual environment..."
python3 -m venv trustee-env

# Activate virtual environment
echo "Activating virtual environment..."
source trustee-env/bin/activate

# Upgrade pip and setuptools
echo ""
echo "Upgrading pip and setuptools..."
pip install --upgrade pip setuptools wheel

# For Python 3.13+, install setuptools with pkg_resources
if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 13 ]; then
    echo ""
    echo "Installing setuptools compatibility packages for Python 3.13+..."
    pip install setuptools wheel
fi

# Install dependencies with error handling
echo ""
echo "Installing dependencies..."
echo "This may take 5-10 minutes..."

# Try to install requirements
if pip install -r requirements.txt; then
    echo ""
    echo "✅ All dependencies installed successfully!"
else
    echo ""
    echo "⚠️  Some packages failed to install."
    echo "Trying alternative installation method..."

    # Install packages one by one with fallbacks
    echo ""
    echo "Installing core packages..."
    pip install numpy pandas matplotlib scipy scikit-learn jupyter ipykernel || {
        echo "❌ Failed to install core packages. Please check your Python version."
        exit 1
    }

    echo "Installing trustee..."
    pip install trustee || {
        echo "⚠️  Trustee installation failed. Trying from source..."
        pip install git+https://github.com/TrusteeML/trustee.git || {
            echo "❌ Could not install trustee. You may need to install it manually."
        }
    }

    echo "Installing PyTorch..."
    pip install torch torchvision || {
        echo "⚠️  PyTorch installation failed. Installing CPU-only version..."
        pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu || {
            echo "⚠️  Could not install PyTorch. Some demo features may not work."
        }
    }

    echo "Installing OpenCV..."
    pip install opencv-python || pip install opencv-python-headless || {
        echo "⚠️  OpenCV installation failed. Image processing may not work."
    }
fi

# Verify installation
echo ""
echo "Verifying installation..."
python3 -c "
import sys
try:
    import trustee
    print('  ✓ trustee')
except ImportError:
    print('  ✗ trustee (FAILED)')
    sys.exit(1)

try:
    import sklearn
    print('  ✓ scikit-learn')
except ImportError:
    print('  ✗ scikit-learn (FAILED)')
    sys.exit(1)

try:
    import numpy
    print('  ✓ numpy')
except ImportError:
    print('  ✗ numpy (FAILED)')
    sys.exit(1)

try:
    import pandas
    print('  ✓ pandas')
except ImportError:
    print('  ✗ pandas (FAILED)')
    sys.exit(1)

try:
    import matplotlib
    print('  ✓ matplotlib')
except ImportError:
    print('  ✗ matplotlib (FAILED)')

try:
    import jupyter
    print('  ✓ jupyter')
except ImportError:
    print('  ✗ jupyter (FAILED)')
    sys.exit(1)

print()
print('Core packages verified successfully!')
" || {
    echo ""
    echo "❌ Installation verification failed!"
    echo "Please check the errors above and try manual installation."
    exit 1
}

echo ""
echo "======================================"
echo "✅ Setup complete!"
echo "======================================"
echo ""
echo "To activate the environment in the future, run:"
echo "  source trustee-env/bin/activate"
echo ""
echo "To verify your setup, run:"
echo "  python check_setup.py"
echo ""
echo "To launch Jupyter notebook, run:"
echo "  jupyter notebook"
echo ""
