# Trustee Tutorial - Setup Instructions

## For Instructors

This document provides detailed setup instructions for the Trustee tutorial.

### Pre-Class Preparation

1. **Test the setup scripts:**
   - Run `setup.sh` (Mac/Linux) or `setup.bat` (Windows)
   - Verify all dependencies install correctly
   - Test both notebooks run without errors

2. **Review the notebooks:**
   - `demo/trustee_demo.ipynb` - Complete demo for instructor-led session
   - `exercise/trustee_exercise.ipynb` - Exercise with TODO sections for students

3. **Prepare teaching materials:**
   - The demo notebook has a simple shortcut learning example (~20 min)
   - The exercise has a complete OS fingerprinting workflow
   - Students will complete Tasks 2-4 with TODO markers

### Recommended Class Flow

**Total Time: ~90 minutes**

1. **Introduction (10 min)**
   - Explain importance of ML explainability in cybersecurity
   - Introduce Trustee framework
   - Overview of OS fingerprinting use case

2. **Demo (20 min)**
   - Walk through Part 1 of exercise notebook (simple demo)
   - Show how Trustee works on a toy example
   - Explain key concepts: fidelity, agreement, feature importance

3. **Guided Exercise Setup (10 min)**
   - Students load and explore OS fingerprinting data
   - Review the dataset structure and features
   - Explain the task

4. **Independent Work (40 min)**
   - Students complete Tasks 2-4:
     - Train Random Forest classifier
     - Apply Trustee to extract explanation
     - Analyze feature importance
   - Circulate to help with issues

5. **Discussion & Wrap-up (10 min)**
   - Review top features discovered
   - Discuss security implications
   - Answer analysis questions as a class

---

## For Students

### Before Class

Make sure you have:
- Python 3.8 or higher installed
- ~500MB free disk space
- Stable internet connection (for downloading packages)

### Setup Steps

#### Option 1: Automated Setup (Easiest)

**Mac/Linux:**
```bash
cd classroom_materials
chmod +x setup.sh
./setup.sh
```

**Windows:**
```cmd
cd classroom_materials
setup.bat
```

Wait for the setup to complete. You should see:
```
======================================
Setup complete!
======================================
```

#### Option 2: Manual Setup

If automated setup fails, follow these steps:

**Step 1: Create Virtual Environment**
```bash
# Mac/Linux
python3 -m venv trustee-env
source trustee-env/bin/activate

# Windows
python -m venv trustee-env
trustee-env\Scripts\activate
```

**Step 2: Upgrade pip**
```bash
pip install --upgrade pip setuptools wheel
```

**Step 3: Install Dependencies**
```bash
pip install -r requirements.txt
```

This may take 5-10 minutes depending on your internet speed.

### Verify Installation

Run this command to check if Trustee installed correctly:

```bash
python -c "import trustee; print('✓ Trustee version:', trustee.__version__)"
```

You should see:
```
✓ Trustee version: 1.1.0
```

### Launch Jupyter

**Every time you want to work on the tutorial:**

1. Activate the virtual environment:
   ```bash
   # Mac/Linux
   source trustee-env/bin/activate

   # Windows
   trustee-env\Scripts\activate
   ```

2. Launch Jupyter:
   ```bash
   jupyter notebook
   ```

3. Open the exercise notebook:
   - Navigate to `exercise/trustee_exercise.ipynb`

---

## Common Setup Issues

### Issue: `python3` command not found (Mac/Linux)

**Solution:** Try using `python` instead:
```bash
python -m venv trustee-env
```

### Issue: `pip install trustee` fails with "command error"

**Solution:** Upgrade pip and try again:
```bash
pip install --upgrade pip setuptools wheel
pip install trustee
```

### Issue: OpenCV installation error

**Solution:** Install headless version:
```bash
pip install opencv-python-headless
```

### Issue: Jupyter kernel not found

**Solution:** Install ipykernel explicitly:
```bash
pip install ipykernel
python -m ipykernel install --user --name=trustee-env
```

### Issue: Permission denied on setup.sh (Mac/Linux)

**Solution:** Make it executable:
```bash
chmod +x setup.sh
./setup.sh
```

### Issue: Windows security blocks setup.bat

**Solution:** Right-click → "Run as Administrator" or use PowerShell:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup.bat
```

---

## Testing Your Setup

After setup, test everything works:

### Quick Test

Open Python and run:
```python
import trustee
import sklearn
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

print("✓ All imports successful!")
```

### Full Test

Run the demo notebook:
1. Open `demo/trustee_demo.ipynb`
2. Click "Kernel" → "Restart & Run All"
3. Wait for all cells to execute
4. Verify no errors appear

---

## Data Information

The OS fingerprinting dataset is included in `data/os_fingerprinting/`:

- **X.pkl**: Feature matrix (7,836 samples × 416 features)
  - Network packet features extracted using nPrint
  - Features include TCP/IP header fields, flags, options, etc.

- **y.pkl**: Labels (7,836 samples)
  - 0: Linux 3.11+
  - 1: Windows 7/8
  - 2: MacOS X
  - 3: Kali Linux

- **X_val.pkl**, **y_val.pkl**: Validation sets (not used in basic exercise)

**Dataset Size:** ~4MB total

**Source:** Extracted from CIC-IDS-2017 network traffic dataset using nPrint tool

---

## Package Versions

If you encounter version conflicts, here are the tested versions:

```
trustee==1.1.0
scikit-learn==1.3.0
numpy==1.24.3
pandas==2.0.3
matplotlib==3.7.2
torch==2.0.1
opencv-python==4.8.0.74
scipy==1.11.1
jupyter==1.0.0
ipykernel==6.25.0
```

To install exact versions:
```bash
pip install -r requirements.txt
```

---

## Getting Help

**During Setup:**
1. Check error messages carefully - they often tell you what's wrong
2. Try the manual setup if automated fails
3. Search the error message online (Stack Overflow is your friend!)
4. Ask your instructor or TA

**During Exercise:**
1. Check the demo notebook for examples
2. Read the TODO hints carefully
3. Use `help()` function: e.g., `help(RandomForestClassifier)`
4. Ask classmates or raise your hand

---

## Advanced: Using Your Own Data

After completing the exercise, you can try Trustee on your own models:

```python
from trustee import ClassificationTrustee
from sklearn.ensemble import RandomForestClassifier

# Train your model
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Extract explanation
trustee = ClassificationTrustee(expert=model)
trustee.fit(X_train, y_train, num_iter=10, num_stability_iter=5)
dt, pruned_dt, agreement, reward = trustee.explain()

# Visualize
from sklearn import tree
tree.plot_tree(pruned_dt, filled=True)
```

Trustee works with any sklearn-compatible classifier!

---

## Cleanup

When you're done, you can remove the virtual environment to save space:

```bash
# Deactivate first
deactivate

# Remove the environment
# Mac/Linux
rm -rf trustee-env

# Windows
rmdir /s trustee-env
```

The data files and notebooks will remain.
