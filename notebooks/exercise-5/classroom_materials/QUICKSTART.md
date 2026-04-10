# Quick Start - Trustee Tutorial

## ⚠️ You Have Python 3.14 - Read This First!

Your error indicates you're using Python 3.14, which is too new for some packages. Here's how to fix it:

---

## Option 1: Install Python 3.12 (RECOMMENDED - 15 minutes)

### Mac Users:
```bash
# Install Python 3.12 using Homebrew
brew install python@3.12

# Verify installation
python3.12 --version

# Go to classroom_materials directory
cd classroom_materials

# Create virtual environment with Python 3.12
python3.12 -m venv trustee-env

# Activate it
source trustee-env/bin/activate

# Run setup
./setup.sh
```

### Windows Users:
1. Download Python 3.12 from https://www.python.org/downloads/
2. Install it (check "Add to PATH")
3. Open Command Prompt:
```cmd
cd classroom_materials
python -m venv trustee-env
trustee-env\Scripts\activate
setup.bat
```

### Linux Users:
```bash
# Ubuntu/Debian
sudo apt install python3.12 python3.12-venv

# Or use pyenv
pyenv install 3.12.0
pyenv local 3.12.0

# Then proceed
cd classroom_materials
python3.12 -m venv trustee-env
source trustee-env/bin/activate
./setup.sh
```

---

## Option 2: Manual Installation with Python 3.14 (ADVANCED - 20 minutes)

If you must use Python 3.14:

```bash
cd classroom_materials

# Create virtual environment
python3 -m venv trustee-env

# Activate it
source trustee-env/bin/activate  # Mac/Linux
# OR
trustee-env\Scripts\activate     # Windows

# Upgrade pip and install setuptools
pip install --upgrade pip setuptools wheel

# Install packages one by one
pip install numpy scipy
pip install pandas matplotlib
pip install scikit-learn
pip install jupyter ipykernel notebook

# Try trustee (may fail)
pip install trustee

# If trustee fails, try from source
pip install git+https://github.com/TrusteeML/trustee.git

# Optional packages (for demo only)
pip install opencv-python-headless
pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
```

---

## Verify Your Setup

After installation, verify everything works:

```bash
# Make sure you're in the virtual environment
# You should see (trustee-env) in your terminal prompt

cd classroom_materials
python check_setup.py
```

You should see:
```
✓ PASS Python version
✓ PASS Package imports
✓ PASS Data files
✓ PASS Notebooks
✓ PASS Basic functionality
```

---

## Start the Tutorial

Once setup is verified:

```bash
# Activate virtual environment (if not already)
source trustee-env/bin/activate  # Mac/Linux
# OR
trustee-env\Scripts\activate     # Windows

# Launch Jupyter
jupyter notebook

# Open the exercise notebook:
# exercise/trustee_exercise.ipynb
```

---

## File Structure

Your classroom_materials folder should contain:

```
classroom_materials/
├── setup.sh / setup.bat        # Setup scripts
├── check_setup.py              # Verification script
├── requirements.txt            # Package list
├── QUICKSTART.md              # This file
├── PYTHON_VERSION_GUIDE.md    # Detailed version guide
├── demo/
│   └── trustee_demo.ipynb     # Demo notebook
├── exercise/
│   └── trustee_exercise.ipynb # Main exercise
└── data/
    └── os_fingerprinting/
        ├── X.pkl              # Feature data
        └── y.pkl              # Label data
```

---

## Common Issues

### Issue: "No module named 'trustee'"
**Solution:** Install from source:
```bash
pip install git+https://github.com/TrusteeML/trustee.git
```

### Issue: "No module named 'pkg_resources'"
**Solution:** Install setuptools:
```bash
pip install setuptools
```

### Issue: Pandas installation fails
**Solution:** Try older version or use conda:
```bash
pip install "pandas<2.2"
# OR
conda install pandas
```

### Issue: Setup script won't run (Mac/Linux)
**Solution:** Make it executable:
```bash
chmod +x setup.sh
./setup.sh
```

---

## Need More Help?

- **Detailed version guide:** See `PYTHON_VERSION_GUIDE.md`
- **Setup instructions:** See `SETUP_INSTRUCTIONS.md`
- **Instructor guide:** See `INSTRUCTOR_GUIDE.md` (if you're teaching)

---

## Summary

**FASTEST PATH:**
1. Install Python 3.12: `brew install python@3.12` (Mac) or download from python.org
2. Run: `python3.12 -m venv trustee-env`
3. Activate: `source trustee-env/bin/activate`
4. Setup: `./setup.sh`
5. Verify: `python check_setup.py`
6. Start: `jupyter notebook`

**TIME REQUIRED:** ~15 minutes total

Good luck! 🚀
