@echo off
SET BATCH_ENV_PATH=%1
SET BATCH_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\user\setenv-python.bat
SET BATCH_DEFAULT_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\default\setenv-python.bat
IF NOT EXIST "%BATCH_ENV_FILE%" (
  SET BATCH_ENV_FILE=%BATCH_DEFAULT_ENV_FILE%
)
call "%BATCH_ENV_FILE%"

REM Check if virtual environment exists and activate it
SET VENV_ACTIVATE=%2\.venv\Scripts\activate.bat
IF EXIST "%VENV_ACTIVATE%" (
  echo ✨ virtual environment enabled ^(.venv^) ✨
  %ComSpec% /s /k "SET PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%PATH% && pushd "%2" && call "%VENV_ACTIVATE%""
) ELSE (
  %ComSpec% /s /k "SET PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%PATH% && pushd "%2""
)
