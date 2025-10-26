@echo off
SET BATCH_ENV_PATH=%1
SET BATCH_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\user\setenv-cmake.bat
SET BATCH_DEFAULT_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\default\setenv-cmake.bat
IF NOT EXIST "%BATCH_ENV_FILE%" (
  SET BATCH_ENV_FILE=%BATCH_DEFAULT_ENV_FILE%
)
call "%BATCH_ENV_FILE%"
%ComSpec% /s /k "SET PATH=%MINGW_W64_HOME%\bin;%LLVM_CLANG_HOME%\bin;%CMAKE_HOME%\bin;%NINJA_HOME%;%PATH% && pushd "%2""