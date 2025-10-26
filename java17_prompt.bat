@echo off
SET BATCH_ENV_PATH=%1
SET BATCH_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\user\setenv-java17.bat
SET BATCH_DEFAULT_ENV_FILE=%BATCH_ENV_PATH:"=%\setenv\default\setenv-java17.bat
IF NOT EXIST "%BATCH_ENV_FILE%" (
  SET BATCH_ENV_FILE=%BATCH_DEFAULT_ENV_FILE%
)
call "%BATCH_ENV_FILE%"
%ComSpec% /s /k "SET PATH=%JAVA_HOME%\bin;%ANT_HOME%\bin;%MAVEN_HOME%\bin;%GRADLE_HOME%\bin;%PATH% && pushd "%2""