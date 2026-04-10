# Trustee Tutorial: Explaining ML Models in Cybersecurity

This tutorial teaches students how to use **Trustee** to explain machine learning models in cybersecurity applications, specifically focusing on OS fingerprinting from network traffic.

## What is Trustee?

Trustee is a model explanation framework that extracts **interpretable decision trees** from complex black-box models (neural networks, random forests, gradient boosting, etc.).

### Why Explainability Matters in Security

- **Debugging:** Identify if your model learned the right patterns or shortcuts
- **Trust:** Understand why a network packet was classified as malicious
- **Compliance:** Meet regulatory requirements for explainable AI
- **Adversarial Robustness:** Detect vulnerabilities in your model's decision-making

## Tutorial Structure

- **demo/**: Instructor-led demo notebook (Moon & Stars shortcut learning detection)
- **exercise/**: Student exercise notebook (OS Fingerprinting with TODO sections)
- **data/**: OS fingerprinting dataset (included, ~4MB)

---

## Quick Start Guide

### Option 1: Automated Setup (Recommended)

#### On Mac/Linux:
```bash
chmod +x setup.sh
./setup.sh
```

#### On Windows:
```cmd
setup.bat
```

The setup script will:
1. Create a virtual environment (`trustee-env`)
2. Install all required dependencies
3. Prepare the environment for Jupyter

### Option 2: Manual Setup

#### 1. Create Virtual Environment

```bash
# Mac/Linux
python3 -m venv trustee-env
source trustee-env/bin/activate

# Windows
python -m venv trustee-env
trustee-env\Scripts\activate
```

#### 2. Install Dependencies

```bash
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
```

### Launch Jupyter Notebook

After setup, activate the environment and launch Jupyter:

```bash
# Mac/Linux
source trustee-env/bin/activate

# Windows
trustee-env\Scripts\activate

# Launch Jupyter
jupyter notebook
```

Then navigate to:
- **Demo:** `demo/trustee_demo.ipynb` (instructor-led)
- **Exercise:** `exercise/trustee_exercise.ipynb` (student work)

---

## Exercise Overview

### Part 1: Quick Demo (~10 minutes)
- Simple "two moons" classification example
- Train a Random Forest with 100 trees
- Use Trustee to extract a single decision tree explanation
- Understand fidelity, agreement, and feature importance

### Part 2: OS Fingerprinting Exercise (~45 minutes)

**Scenario:** You have network traffic data from 4 different operating systems. Can you build a classifier to identify the OS, and then explain which network features the model uses?

**Dataset:**
- **Source:** nPrint features from CIC-IDS-2017 network captures
- **Samples:** 7,836 network flows
- **Features:** 416 network packet features (TCP/IP headers, flags, etc.)
- **Classes:** 4 operating systems
  - Linux 3.11+
  - Windows 7/8
  - MacOS X
  - Kali Linux

**Your Tasks:**
1. Load and explore the OS fingerprinting dataset
2. **[TODO]** Train a Random Forest classifier
3. **[TODO]** Apply Trustee to extract a decision tree explanation
4. **[TODO]** Analyze feature importance to identify key network patterns
5. **[TODO]** Answer analysis questions about security implications

**Learning Goals:**
- Hands-on experience with Trustee on real cybersecurity data
- Understand which network features distinguish operating systems
- Think critically about model vulnerabilities and adversarial attacks
- Practice analyzing feature importance for security insights

---

## What Students Will Learn

By completing this tutorial, students will:

✓ Understand the importance of model explainability in cybersecurity

✓ Use Trustee to extract interpretable decision trees from complex models

✓ Train and evaluate ML models on real network traffic data

✓ Analyze feature importance to understand model decisions

✓ Identify potential security vulnerabilities through explainability

✓ Think critically about adversarial robustness

---

## Technical Requirements

- Python 3.8 or higher
- ~500MB disk space
- 4GB RAM recommended
- Works on Mac, Linux, and Windows

### Dependencies (installed automatically by setup scripts)

- trustee==1.1.0
- numpy>=1.21.0
- pandas>=1.3.0
- matplotlib>=3.4.0
- scikit-learn>=1.0.0
- torch>=1.9.0
- opencv-python>=4.5.0
- scipy>=1.7.0
- jupyter

---

## Troubleshooting

### Common Issues

**Issue:** `pip install trustee` fails
- **Solution:** Run `pip install --upgrade pip setuptools wheel` first, then retry

**Issue:** OpenCV installation fails
- **Solution:** Try `pip install opencv-python-headless` instead

**Issue:** Memory errors during training
- **Solution:** Reduce the dataset size in the notebook or close other applications

**Issue:** Jupyter kernel not found
- **Solution:** Make sure you activate the virtual environment before running `jupyter notebook`

**Issue:** Setup script won't run (Mac/Linux)
- **Solution:** Make sure it's executable: `chmod +x setup.sh`

### Getting Help

If you encounter issues:
1. Check the error message carefully
2. Make sure your Python version is 3.8 or higher: `python --version`
3. Ensure you're in the activated virtual environment
4. Try the manual setup steps if automated setup fails

---

## File Structure

```
classroom_materials/
├── README.md              # This file
├── requirements.txt       # Python dependencies
├── setup.sh              # Setup script (Mac/Linux)
├── setup.bat             # Setup script (Windows)
├── demo/
│   └── trustee_demo.ipynb        # Instructor demo
├── exercise/
│   └── trustee_exercise.ipynb    # Student exercise (with TODOs)
└── data/
    └── os_fingerprinting/
        ├── X.pkl         # Feature data (7,836 samples × 416 features)
        ├── y.pkl         # Labels (OS classes)
        ├── X_val.pkl     # Validation features
        └── y_val.pkl     # Validation labels
```

---

## Citation

If you use Trustee in your research or projects, please cite:

```bibtex
@inproceedings{trustee2022,
  title={Trustee: A Framework for Model Interpretation via Decision Tree Extraction},
  author={Soares, Eduardo and Gomes, Plinio and Amaro, Francisco},
  booktitle={Proceedings of the 2022 ACM Conference on Fairness, Accountability, and Transparency},
  year={2022}
}
```

For the Emperor use cases and cybersecurity examples:

```bibtex
@inproceedings{emperor2022,
  title={AI/ML and Network Security: The Emperor has no Clothes},
  author={Apruzzese, Giovanni and Anderson, Hyrum and Dambra, Savino and others},
  booktitle={Proceedings of the 2022 ACM SIGSAC Conference on Computer and Communications Security},
  year={2022}
}
```

---

## Additional Resources

- **Trustee Documentation:** https://trusteeml.github.io
- **Trustee GitHub:** https://github.com/TrusteeML/trustee
- **Emperor Repository:** https://github.com/TrusteeML/emperor (more cybersecurity examples)
- **nPrint Tool:** https://nprint.github.io/nprint/ (network packet fingerprinting)

---

## License

This tutorial is based on the Trustee and Emperor projects. Please refer to the original repositories for license information.
