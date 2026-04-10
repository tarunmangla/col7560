@echo off
REM Setup script for Trustee Tutorial (Windows)
setlocal enabledelayedexpansion

echo ======================================
echo Trustee Tutorial Setup
echo ======================================

REM Check if Python 3 is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python 3 is not installed. Please install Python 3.8 or higher.
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo Python version:
python --version
echo.

REM Get Python version
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
for /f "tokens=1,2 delims=." %%a in ("%PYTHON_VERSION%") do (
    set PYTHON_MAJOR=%%a
    set PYTHON_MINOR=%%b
)

REM Check if Python version is sufficient
if %PYTHON_MAJOR% LSS 3 (
    echo Error: Python 3.8 or higher required. You have Python %PYTHON_VERSION%
    pause
    exit /b 1
)
if %PYTHON_MAJOR% EQU 3 if %PYTHON_MINOR% LSS 8 (
    echo Error: Python 3.8 or higher required. You have Python %PYTHON_VERSION%
    pause
    exit /b 1
)

REM Warn about Python 3.13+ compatibility
if %PYTHON_MAJOR% EQU 3 if %PYTHON_MINOR% GEQ 13 (
    echo.
    echo WARNING: Python 3.13+ detected!
    echo Some packages may have compatibility issues.
    echo Recommended: Use Python 3.11 or 3.12 for best compatibility.
    echo.
    choice /C YN /M "Do you want to continue anyway"
    if errorlevel 2 (
        echo Setup cancelled. Please install Python 3.11 or 3.12 and try again.
        pause
        exit /b 1
    )
)

REM Create virtual environment
echo.
echo Creating virtual environment...
python -m venv trustee-env

REM Activate virtual environment
echo Activating virtual environment...
call trustee-env\Scripts\activate.bat

REM Upgrade pip and setuptools
echo.
echo Upgrading pip and setuptools...
python -m pip install --upgrade pip setuptools wheel

REM For Python 3.13+, ensure setuptools is installed
if %PYTHON_MAJOR% EQU 3 if %PYTHON_MINOR% GEQ 13 (
    echo.
    echo Installing setuptools compatibility packages for Python 3.13+...
    pip install setuptools wheel
)

REM Install dependencies with error handling
echo.
echo Installing dependencies...
echo This may take 5-10 minutes...
echo.

pip install -r requirements.txt
if errorlevel 1 (
    echo.
    echo WARNING: Some packages failed to install.
    echo Trying alternative installation method...
    echo.

    REM Install core packages first
    echo Installing core packages...
    pip install numpy pandas matplotlib scipy scikit-learn jupyter ipykernel
    if errorlevel 1 (
        echo Error: Failed to install core packages. Please check your Python version.
        pause
        exit /b 1
    )

    REM Try to install trustee
    echo Installing trustee...
    pip install trustee
    if errorlevel 1 (
        echo Warning: Trustee installation failed.
        echo You may need to install it manually or use Python 3.11/3.12.
    )

    REM Try to install PyTorch
    echo Installing PyTorch...
    pip install torch torchvision
    if errorlevel 1 (
        echo Warning: PyTorch installation failed. Some demo features may not work.
    )

    REM Try to install OpenCV
    echo Installing OpenCV...
    pip install opencv-python-headless
    if errorlevel 1 (
        echo Warning: OpenCV installation failed. Image processing may not work.
    )
)

REM Verify installation
echo.
echo Verifying installation...
python -c "import trustee; print('  OK trustee')" 2>nul || echo   FAILED trustee
python -c "import sklearn; print('  OK scikit-learn')" 2>nul || echo   FAILED scikit-learn
python -c "import numpy; print('  OK numpy')" 2>nul || echo   FAILED numpy
python -c "import pandas; print('  OK pandas')" 2>nul || echo   FAILED pandas
python -c "import jupyter; print('  OK jupyter')" 2>nul || echo   FAILED jupyter

echo.
echo ======================================
echo Setup complete!
echo ======================================
echo.
echo To activate the environment in the future, run:
echo   trustee-env\Scripts\activate.bat
echo.
echo To verify your setup, run:
echo   python check_setup.py
echo.
echo To launch Jupyter notebook, run:
echo   jupyter notebook
echo.
pause
