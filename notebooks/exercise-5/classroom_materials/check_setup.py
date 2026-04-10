#!/usr/bin/env python3
"""
Setup Verification Script for Trustee Tutorial

Run this script to check if your environment is correctly configured.
"""

import sys

def check_python_version():
    """Check if Python version is 3.8 or higher"""
    print("Checking Python version...")
    version = sys.version_info
    if version.major >= 3 and version.minor >= 8:
        print(f"  ✓ Python {version.major}.{version.minor}.{version.micro}")
        return True
    else:
        print(f"  ✗ Python {version.major}.{version.minor}.{version.micro} (need 3.8+)")
        return False

def check_imports():
    """Check if all required packages are installed"""
    print("\nChecking required packages...")

    packages = [
        ('trustee', 'Trustee'),
        ('sklearn', 'scikit-learn'),
        ('numpy', 'NumPy'),
        ('pandas', 'Pandas'),
        ('matplotlib', 'Matplotlib'),
        ('torch', 'PyTorch'),
        ('cv2', 'OpenCV'),
        ('scipy', 'SciPy'),
        ('jupyter', 'Jupyter'),
    ]

    all_ok = True
    for module_name, display_name in packages:
        try:
            module = __import__(module_name)
            version = getattr(module, '__version__', 'unknown')
            print(f"  ✓ {display_name:20s} (version: {version})")
        except ImportError:
            print(f"  ✗ {display_name:20s} (NOT INSTALLED)")
            all_ok = False

    return all_ok

def check_data():
    """Check if data files are present"""
    print("\nChecking data files...")

    import os

    data_files = [
        'data/os_fingerprinting/X.pkl',
        'data/os_fingerprinting/y.pkl',
        'data/os_fingerprinting/X_val.pkl',
        'data/os_fingerprinting/y_val.pkl',
    ]

    all_ok = True
    for filepath in data_files:
        if os.path.exists(filepath):
            size = os.path.getsize(filepath)
            size_mb = size / (1024 * 1024)
            print(f"  ✓ {filepath:40s} ({size_mb:.2f} MB)")
        else:
            print(f"  ✗ {filepath:40s} (NOT FOUND)")
            all_ok = False

    return all_ok

def check_notebooks():
    """Check if notebooks are present"""
    print("\nChecking notebook files...")

    import os

    notebooks = [
        'demo/trustee_demo.ipynb',
        'exercise/trustee_exercise.ipynb',
    ]

    all_ok = True
    for filepath in notebooks:
        if os.path.exists(filepath):
            print(f"  ✓ {filepath}")
        else:
            print(f"  ✗ {filepath} (NOT FOUND)")
            all_ok = False

    return all_ok

def test_basic_functionality():
    """Test basic Trustee functionality"""
    print("\nTesting basic functionality...")

    try:
        import numpy as np
        from sklearn.datasets import make_classification
        from sklearn.ensemble import RandomForestClassifier
        from trustee import ClassificationTrustee

        # Create small test dataset
        X, y = make_classification(n_samples=100, n_features=5, random_state=42)

        # Train a simple model
        model = RandomForestClassifier(n_estimators=10, max_depth=3, random_state=42)
        model.fit(X, y)

        # Apply Trustee
        trustee = ClassificationTrustee(expert=model)
        trustee.fit(X, y, num_iter=2, num_stability_iter=1, samples_size=0.5, verbose=False)
        dt, pruned_dt, agreement, reward = trustee.explain()

        print(f"  ✓ Successfully ran Trustee")
        print(f"    - Agreement: {agreement:.3f}")
        print(f"    - Reward: {reward:.3f}")
        print(f"    - Tree nodes: {pruned_dt.tree_.node_count}")

        return True

    except Exception as e:
        print(f"  ✗ Error running Trustee: {e}")
        return False

def main():
    """Run all checks"""
    print("="*60)
    print("Trustee Tutorial - Setup Verification")
    print("="*60)

    results = []

    # Run all checks
    results.append(("Python version", check_python_version()))
    results.append(("Package imports", check_imports()))
    results.append(("Data files", check_data()))
    results.append(("Notebooks", check_notebooks()))
    results.append(("Basic functionality", test_basic_functionality()))

    # Summary
    print("\n" + "="*60)
    print("Summary")
    print("="*60)

    all_passed = all(result for _, result in results)

    for name, result in results:
        status = "✓ PASS" if result else "✗ FAIL"
        print(f"{status:10s} {name}")

    print("="*60)

    if all_passed:
        print("\n🎉 All checks passed! You're ready for the tutorial.")
        print("\nNext steps:")
        print("  1. Activate your virtual environment:")
        print("     - Mac/Linux: source trustee-env/bin/activate")
        print("     - Windows: trustee-env\\Scripts\\activate")
        print("  2. Launch Jupyter: jupyter notebook")
        print("  3. Open: exercise/trustee_exercise.ipynb")
        return 0
    else:
        print("\n⚠️  Some checks failed. Please review the errors above.")
        print("\nTroubleshooting:")
        print("  1. Make sure you ran the setup script:")
        print("     - Mac/Linux: ./setup.sh")
        print("     - Windows: setup.bat")
        print("  2. Check that you're in the virtual environment")
        print("  3. Try manual installation: pip install -r requirements.txt")
        print("  4. See SETUP_INSTRUCTIONS.md for detailed help")
        return 1

if __name__ == "__main__":
    sys.exit(main())
