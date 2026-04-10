# Python Version Compatibility Guide

## TL;DR - Recommended Setup

**Use Python 3.11 or 3.12 for best compatibility with all packages.**

---

## The Problem with Python 3.13+

You're seeing installation errors because Python 3.13+ (including 3.14) made breaking changes that affect many scientific Python packages:

1. **Removed `pkg_resources`**: No longer bundled with Python
2. **Changed build system**: Some packages haven't updated yet
3. **Compatibility lag**: Scientific packages typically support Python versions 6-12 months after release

### Your Error Specifically

```
ModuleNotFoundError: No module named 'pkg_resources'
```

This happens because:
- Some packages (like older versions of `pandas`, `trustee`) use `pkg_resources` during installation
- Python 3.14 doesn't include this by default
- The packages need to be updated to work with the new Python version

---

## Solutions (Pick One)

### Option 1: Use Python 3.11 or 3.12 (RECOMMENDED)

**Best for:** Everyone, especially students new to Python

**Steps:**

1. **Install Python 3.11 or 3.12:**
   - Download from https://www.python.org/downloads/
   - Mac users: `brew install python@3.12`
   - Windows: Download installer from python.org
   - Linux: `sudo apt install python3.12` or `sudo yum install python312`

2. **Verify version:**
   ```bash
   python3.12 --version
   # or
   python3.11 --version
   ```

3. **Create virtual environment with specific version:**
   ```bash
   cd classroom_materials
   python3.12 -m venv trustee-env
   source trustee-env/bin/activate  # Mac/Linux
   # OR
   trustee-env\Scripts\activate     # Windows
   ```

4. **Run setup:**
   ```bash
   ./setup.sh  # Mac/Linux
   # OR
   setup.bat   # Windows
   ```

---

### Option 2: Manual Installation for Python 3.13+ (ADVANCED)

**Best for:** Advanced users who want to use Python 3.13/3.14

**Steps:**

1. **Create virtual environment:**
   ```bash
   cd classroom_materials
   python3 -m venv trustee-env
   source trustee-env/bin/activate  # Mac/Linux
   ```

2. **Upgrade pip and install setuptools:**
   ```bash
   pip install --upgrade pip setuptools wheel
   ```

3. **Install packages in order (to handle dependencies):**
   ```bash
   # Core packages first
   pip install numpy scipy
   pip install pandas matplotlib
   pip install scikit-learn
   pip install jupyter ipykernel notebook

   # Try trustee (may need latest version)
   pip install trustee

   # Or try from source if packaged version fails
   pip install git+https://github.com/TrusteeML/trustee.git

   # Optional: PyTorch (for demo only)
   pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu

   # Optional: OpenCV (for demo only)
   pip install opencv-python-headless
   ```

4. **Verify:**
   ```bash
   python check_setup.py
   ```

---

### Option 3: Use Conda (ALTERNATIVE)

**Best for:** Users familiar with conda/anaconda

Conda often has better compatibility because it manages binary dependencies.

**Steps:**

1. **Install Miniconda or Anaconda:**
   - Download from https://docs.conda.io/en/latest/miniconda.html

2. **Create conda environment:**
   ```bash
   cd classroom_materials
   conda create -n trustee-env python=3.11
   conda activate trustee-env
   ```

3. **Install packages:**
   ```bash
   conda install numpy pandas matplotlib scipy scikit-learn jupyter
   pip install trustee
   conda install pytorch torchvision -c pytorch
   conda install opencv -c conda-forge
   ```

4. **Verify:**
   ```bash
   python check_setup.py
   ```

---

## Quick Compatibility Reference

| Python Version | Status | Notes |
|----------------|--------|-------|
| 3.8 | ✅ Fully supported | End of life: Oct 2024 (still works) |
| 3.9 | ✅ Fully supported | Recommended for older systems |
| 3.10 | ✅ Fully supported | Good balance of features/compatibility |
| 3.11 | ✅ **RECOMMENDED** | Fast, stable, great compatibility |
| 3.12 | ✅ **RECOMMENDED** | Latest stable with good support |
| 3.13 | ⚠️ Partial support | Some packages may fail |
| 3.14 | ❌ Limited support | Many packages not updated yet |

---

## Troubleshooting Specific Errors

### Error: `ModuleNotFoundError: No module named 'pkg_resources'`

**Cause:** Python 3.13+ removed pkg_resources

**Fix:**
```bash
pip install setuptools
```

### Error: `error: subprocess-exited-with-error` when installing pandas

**Cause:** pandas wheel not available for your Python version

**Fix:**
```bash
# Option 1: Install pre-release if available
pip install --pre pandas

# Option 2: Use older pandas version
pip install "pandas<2.2"

# Option 3: Use conda
conda install pandas
```

### Error: `ERROR: Failed to build 'trustee'`

**Cause:** trustee may not support Python 3.13+ yet

**Fix:**
```bash
# Try installing from source
pip install git+https://github.com/TrusteeML/trustee.git

# Or use Python 3.11/3.12
```

### Error: PyTorch installation fails

**Cause:** PyTorch has specific version requirements

**Fix:**
```bash
# CPU-only version (smaller, faster install)
pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu

# Or skip PyTorch - it's only needed for one demo
# The main OS fingerprinting exercise doesn't require it
```

---

## For Instructors

### Classroom Setup Recommendations

1. **Pre-install Python 3.11 or 3.12** on lab computers
2. **Test setup scripts** before class on all platforms
3. **Have offline installers ready** in case of network issues
4. **Provide USB drives** with pre-downloaded wheel files

### Alternative: Docker Container

Create a Docker container with all dependencies:

```dockerfile
FROM python:3.12-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
```

Students can then use:
```bash
docker run -p 8888:8888 -v $(pwd):/app trustee-tutorial
```

---

## Minimal Installation (If All Else Fails)

If you absolutely cannot get the full setup working, here's a minimal version that works for the exercise:

```bash
pip install numpy pandas scikit-learn matplotlib jupyter
```

Then **skip the demo** (Part 1) and go straight to the exercise (Part 2), which only needs these core packages. You'll need to manually implement a simple decision tree extraction instead of using Trustee.

---

## Still Having Issues?

1. **Check your Python version:**
   ```bash
   python --version
   # or
   python3 --version
   ```

2. **Try creating a fresh virtual environment:**
   ```bash
   rm -rf trustee-env
   python3.12 -m venv trustee-env
   source trustee-env/bin/activate
   ```

3. **Clear pip cache:**
   ```bash
   pip cache purge
   ```

4. **Use verbose output to see what's failing:**
   ```bash
   pip install -v trustee
   ```

5. **Check package compatibility:**
   ```bash
   pip index versions trustee
   ```

---

## Summary

**RECOMMENDED PATH:**
1. Install Python 3.11 or 3.12
2. Run `./setup.sh` or `setup.bat`
3. Verify with `python check_setup.py`
4. Start learning!

**QUICK FIX FOR PYTHON 3.14 USERS:**
```bash
# Use Python 3.12 instead
brew install python@3.12  # Mac
python3.12 -m venv trustee-env
source trustee-env/bin/activate
./setup.sh
```

Good luck! 🚀
