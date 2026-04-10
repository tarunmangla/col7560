# Instructor Guide - Trustee Tutorial

## Overview

This is a minimal, classroom-ready tutorial for teaching ML explainability using Trustee on OS fingerprinting data.

### What's Included

✓ Complete setup scripts (Mac/Linux/Windows)
✓ OS fingerprinting dataset (~4MB, 7,836 samples, 416 features)
✓ Demo notebook with shortcut learning example
✓ Exercise notebook with TODO sections for students
✓ Comprehensive documentation and troubleshooting guides

### Time Required

- **Setup:** 10-15 minutes (students do before class)
- **Demo:** 10-20 minutes (instructor-led)
- **Exercise:** 40-50 minutes (student work)
- **Total class time:** ~60-75 minutes

---

## File Structure

```
classroom_materials/
├── README.md                     # Main README for students
├── SETUP_INSTRUCTIONS.md         # Detailed setup guide
├── INSTRUCTOR_GUIDE.md          # This file
├── requirements.txt              # Python dependencies
├── setup.sh                      # Setup script (Mac/Linux)
├── setup.bat                     # Setup script (Windows)
├── check_setup.py               # Verification script
├── demo/
│   └── trustee_demo.ipynb       # Complete demo (instructor-led)
├── exercise/
│   └── trustee_exercise.ipynb   # Student exercise (with TODOs)
└── data/
    └── os_fingerprinting/
        ├── X.pkl                # Features (7,836 × 416)
        ├── y.pkl                # Labels (4 OS classes)
        ├── X_val.pkl            # Validation features
        └── y_val.pkl            # Validation labels
```

---

## Pre-Class Setup

### 1. Test the Environment (Recommended)

Run the setup and verification on your own machine first:

```bash
cd classroom_materials
./setup.sh                    # or setup.bat on Windows
source trustee-env/bin/activate
python check_setup.py
jupyter notebook
```

Open both notebooks and run all cells to ensure everything works.

### 2. Distribute to Students

**Option A: Share the entire `classroom_materials/` folder**
- Via cloud storage (Google Drive, Dropbox, etc.)
- Via course management system (Canvas, Blackboard, etc.)
- Via USB drive

**Option B: Create a Git repository**
```bash
cd classroom_materials
git init
git add .
git commit -m "Initial commit"
# Push to GitHub/GitLab and share the link
```

### 3. Student Pre-Work

Send students these instructions before class:

```
Before Class:
1. Download the classroom_materials folder
2. Run the setup script:
   - Mac/Linux: ./setup.sh
   - Windows: setup.bat
3. Run verification: python check_setup.py
4. If any issues, see SETUP_INSTRUCTIONS.md

Bring your laptop with the setup completed!
```

---

## Suggested Class Flow

### Introduction (10 min)

**Learning Objectives:**
- Understand why explainability matters in cybersecurity
- Learn how Trustee extracts interpretable decision trees
- Apply Trustee to real network traffic classification

**Key Points to Cover:**
- Black-box models (random forests, neural networks) are hard to interpret
- Trustee extracts a single decision tree that mimics the model
- Use case: OS fingerprinting from network traffic
- Security implications of understanding model decisions

**Suggested Opening:**
> "Imagine you build a network intrusion detection system. It flags a packet as malicious.
> Your security team asks: WHY? Can you explain it? Today we'll learn how to answer that question."

### Demo - Part 1 (10-15 min)

**Use:** `exercise/trustee_exercise.ipynb` Part 1 (cells 1-8)

**What to Show:**
1. Load a simple "two moons" dataset
2. Train a Random Forest with 100 trees
3. Apply Trustee to extract ONE decision tree
4. Compare: 100 trees → 1 tree, same accuracy!

**Key Concepts:**
- **Fidelity:** How well the explanation matches the original model
- **Agreement:** Accuracy on training data
- **Reward:** Accuracy on validation data
- **Feature Importance:** Which features matter most

**Interactive Questions:**
- "Why is a single tree easier to understand than 100 trees?"
- "What does high fidelity tell us?"
- "Is this explanation trustworthy?"

### Transition to Exercise (5 min)

**Introduce the OS Fingerprinting Task:**

> "Now you'll apply the same technique to a real cybersecurity problem:
> - Dataset: Real network traffic from 4 operating systems
> - 416 features from packet headers (TCP/IP fields, flags, etc.)
> - Your job: Train a classifier and explain what it learned"

**Show the data briefly:**
```python
# Run cells in Part 2 Task 1
print(X_os.shape)  # 7,836 × 416
print(y_os.value_counts())
```

**Explain the TODOs:**
- Task 2: Train Random Forest (fill in model parameters)
- Task 3: Apply Trustee (similar to demo)
- Task 4: Analyze features (extract top features)
- Task 5: Answer questions (security implications)

### Student Work Time (40-50 min)

**Students work on:**
- Task 2: Train classifier (~10 min)
- Task 3: Apply Trustee (~10 min)
- Task 4: Analyze features (~15 min)
- Task 5: Answer questions (~15 min)

**Your Role:**
- Circulate and help with issues
- Check for common errors (see below)
- Encourage students to discuss with neighbors

**Common Issues & Quick Fixes:**

| Issue | Solution |
|-------|----------|
| "My model has 0.5 accuracy" | Check `random_state=42` is set |
| "Trustee is taking forever" | Reduce `num_iter` or `samples_size` |
| "I get a KeyError" | Check the column names match |
| "How do I sort features?" | Use `sorted(zip(names, importance), key=lambda x: x[1], reverse=True)` |
| "What's a good fidelity?" | >0.9 is excellent, >0.8 is good |

### Wrap-up Discussion (10 min)

**Class Discussion Questions:**

1. **Feature Discovery:**
   - "What were the top 3 features for OS classification?"
   - Expected: TTL values, TCP window size, TCP options
   - "Why do these features differ between OS?"
   - Answer: Different network stack implementations

2. **Model Explanation:**
   - "How many nodes in your decision tree?"
   - Compare: Simple tree (10-20 nodes) vs. 100-tree Random Forest
   - "Did Trustee maintain high accuracy?"
   - Should see >90% fidelity

3. **Security Implications:**
   - "Could an attacker evade OS fingerprinting?"
   - Answer: Yes, by spoofing the top features (TTL, window size, etc.)
   - "Is this a problem? How can we defend against it?"
   - Answer: Use multiple features, detect anomalies, etc.

4. **Real-World Applications:**
   - "Where else would you use explainability in security?"
   - Ideas: Intrusion detection, malware classification, fraud detection
   - "Why is explainability important for compliance?"
   - Answer: Regulations require transparency (GDPR, etc.)

**Key Takeaways to Emphasize:**

✓ Explainability helps debug models and detect shortcuts

✓ Trustee provides high-fidelity explanations with decision trees

✓ Feature importance reveals which patterns the model learned

✓ Understanding model decisions is critical for security applications

---

## Answer Key - Task 5 Questions

### Question 1: Top 3 Features

**Expected Answer:**
Features will vary based on the dataset, but typically include:
1. `nprint_X_Y` fields related to TTL (Time-To-Live)
2. TCP window size fields
3. TCP options or flags

**Why:** Different OS use different default TTL values and TCP stack configurations.

### Question 2: Feature Interpretation

**Expected Answer:**
- TTL features: IP Time-To-Live (different defaults: Linux=64, Windows=128, etc.)
- TCP window: Window size varies by OS TCP stack implementation
- TCP options: OS-specific options (timestamps, SACK, etc.)

### Question 3: Fidelity

**Expected Answer:**
Should see fidelity >0.9 (90%+). This is high enough to trust the explanation because:
- The decision tree makes the same predictions as the Random Forest
- We can analyze the tree's logic with confidence
- Any errors are minor and don't affect the overall interpretation

### Question 4: Complexity Reduction

**Expected Answer:**
- Original: 100 trees × ~50 nodes each = ~5,000 total nodes
- Explanation: 1 tree with ~15-30 nodes
- Benefit: Human-interpretable! Security analysts can understand the logic

### Question 5: Security Implications

**Expected Answer:**
Yes, attackers could evade by:
- Spoofing TTL values (easy to change)
- Modifying TCP window size (requires OS modification)
- Changing TCP options (possible but harder)

**Defense:** Use multiple features, monitor for anomalies, combine with other detection methods

### Question 6: Real-World Applications

**Expected Answers:**
- Intrusion Detection Systems (IDS)
- Malware classification
- Fraud detection
- Phishing detection
- VPN/encrypted traffic classification
- Network anomaly detection

---

## Extensions & Advanced Topics

If students finish early or want to go deeper:

### 1. Feature Selection Experiment

"Try training with only the top 50 features. Does accuracy change?"

```python
top_50_features = [f for f, _ in os_top_features[:50]]
X_train_reduced = X_train[top_50_features]
X_test_reduced = X_test[top_50_features]
# Retrain and compare
```

### 2. Different Model Types

"Try explaining a neural network or gradient boosting model."

```python
from sklearn.ensemble import GradientBoostingClassifier
gb_model = GradientBoostingClassifier()
# Train and explain with Trustee
```

### 3. Per-Class Feature Importance

"Which features are most important for each OS?"

```python
# Analyze decision paths for each class
# Look at top splits in the tree
```

### 4. Adversarial Testing

"Can you fool the model by changing only the top feature?"

```python
# Create adversarial examples
X_adv = X_test.copy()
X_adv[top_feature] = X_adv[top_feature] * 1.5
# Check if predictions change
```

---

## Troubleshooting During Class

### Setup Issues

**Problem: Students didn't run setup before class**

Quick fix:
```bash
# Skip virtual environment for speed
pip install --user trustee scikit-learn numpy pandas matplotlib jupyter
jupyter notebook
```

**Problem: Windows security blocks scripts**

Solution:
```cmd
# Run as administrator or use PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Runtime Issues

**Problem: Trustee takes too long**

Quick fix:
```python
# Reduce iterations
trustee.fit(X, y, num_iter=5, num_stability_iter=2, samples_size=0.2)
```

**Problem: Jupyter kernel crashes**

Solution:
```bash
# Reduce memory usage
# Use smaller subset of data
X_train_small = X_train[:1000]
y_train_small = y_train[:1000]
```

**Problem: Visualizations don't show**

Quick fix:
```python
# Add this at top of notebook
%matplotlib inline
```

---

## Assessment Suggestions

### Formative Assessment (During Class)

- Check student progress on TODOs
- Ask students to explain their top features
- Poll: "What's your model accuracy?"
- Quick quiz: "What does fidelity measure?"

### Summative Assessment (Homework/Quiz)

**Short Answer Questions:**
1. Explain what Trustee does in 2-3 sentences.
2. Why is a decision tree more interpretable than a random forest?
3. What is fidelity and why does it matter?
4. Give two reasons why explainability matters in cybersecurity.

**Coding Tasks:**
1. Apply Trustee to a different dataset (provide dataset)
2. Extract and visualize feature importance
3. Analyze the decision tree and explain the top split

**Analysis Tasks:**
1. Compare two different classifiers using Trustee
2. Identify potential security vulnerabilities based on feature importance
3. Propose defenses against adversarial evasion

---

## Additional Resources

### For Further Learning

Share with interested students:

- **Trustee Paper:** [FAT* 2022](https://dl.acm.org/doi/10.1145/3531146.3533227)
- **Emperor Paper:** [CCS 2022](https://dl.acm.org/doi/10.1145/3548606.3560609) - "AI/ML and Network Security: The Emperor has no Clothes"
- **Trustee Docs:** https://trusteeml.github.io
- **Emperor Examples:** https://github.com/TrusteeML/emperor

### Related Topics

- LIME (Local Interpretable Model-agnostic Explanations)
- SHAP (SHapley Additive exPlanations)
- Adversarial Machine Learning
- Explainable AI (XAI) in general

---

## Feedback & Improvements

After teaching, consider:

1. **What worked well?**
   - Which examples resonated with students?
   - What questions generated good discussions?

2. **What could be improved?**
   - Were any TODO sections too hard/easy?
   - Did students finish early or run out of time?
   - Were there common confusion points?

3. **Technical issues?**
   - Setup problems?
   - Runtime errors?
   - Platform-specific issues?

---

## License & Attribution

This tutorial is based on:
- **Trustee Framework:** https://github.com/TrusteeML/trustee
- **Emperor Use Cases:** https://github.com/TrusteeML/emperor
- **nPrint OS Case:** CIC-IDS-2017 dataset processed with nPrint

Please cite the original works if you publish based on this tutorial.

---

## Contact & Support

For issues with the tutorial materials:
- Check SETUP_INSTRUCTIONS.md
- Review error messages carefully
- Search GitHub issues for Trustee

For questions about Trustee itself:
- GitHub: https://github.com/TrusteeML/trustee
- Documentation: https://trusteeml.github.io

---

**Good luck with your class! 🎓**
