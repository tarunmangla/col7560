#!/usr/bin/env python3
"""
Data Setup Script for Trustee Tutorial

This script copies the OS fingerprinting data to the classroom_materials/data directory.
Run this from the parent directory that contains both 'classroom_materials' and 'emperor_data'.
"""

import os
import shutil
import sys

def setup_data():
    """Copy OS fingerprinting data from emperor repository"""
    print("="*60)
    print("Trustee Tutorial - Data Setup")
    print("="*60)

    # Check if we're in the right directory
    if not os.path.exists('classroom_materials'):
        print("\n❌ Error: classroom_materials directory not found!")
        print("Please run this script from the parent directory.")
        print("Expected structure:")
        print("  your_directory/")
        print("    ├── classroom_materials/")
        print("    └── emperor_data/")
        return 1

    # Source and destination paths
    source_dir = 'emperor_data/use_cases/nprint_os_case/res/dataset/nprintml/model/utils/data'
    dest_dir = 'classroom_materials/data/os_fingerprinting'

    # Check if source exists
    if not os.path.exists(source_dir):
        print(f"\n❌ Error: Source data not found at {source_dir}")
        print("\nPlease ensure you have the emperor_data directory with OS fingerprinting data.")
        print("You can clone it with:")
        print("  git clone https://github.com/TrusteeML/emperor.git emperor_data")
        return 1

    # Create destination directory
    print(f"\nCreating directory: {dest_dir}")
    os.makedirs(dest_dir, exist_ok=True)

    # Copy data files
    data_files = ['X.pkl', 'y.pkl', 'X_val.pkl', 'y_val.pkl']

    print("\nCopying OS fingerprinting data...")
    for filename in data_files:
        src = os.path.join(source_dir, filename)
        dst = os.path.join(dest_dir, filename)

        if os.path.exists(src):
            shutil.copy2(src, dst)
            size_mb = os.path.getsize(dst) / (1024 * 1024)
            print(f"  ✓ {filename:15s} ({size_mb:.2f} MB)")
        else:
            print(f"  ❌ {filename:15s} (not found)")

    print("\n" + "="*60)
    print("✅ Data setup complete!")
    print("="*60)
    print("\nData files are now in: classroom_materials/data/os_fingerprinting/")
    print("\nNext steps:")
    print("  1. cd classroom_materials")
    print("  2. Run setup script:")
    print("     - Mac/Linux: ./setup.sh")
    print("     - Windows: setup.bat")

    return 0

if __name__ == "__main__":
    sys.exit(setup_data())
