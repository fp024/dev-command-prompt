:: 💡 Maven은 Maven 4 정식 출시가 되면 적용하자!, maven-compiler-plugin 3.x.x 버전대가 Java 25 지원을 못한다.
::    Maven 4로 업그레이드가되어야 정상 지원할 것 같다.
@SET JAVA_VERSION=25
@SET ANT_VERSION=1.10.x
@SET GRADLE_VERSION=9.x
@SET JAVA_HOME=C:\JDK\%JAVA_VERSION%
@SET ANT_HOME=C:\ant\%ANT_VERSION%
@SET GRADLE_HOME=C:\Gradle\%GRADLE_VERSION%
@echo === Java %JAVA_VERSION%, ant %ANT_VERSION%, Gradle %GRADLE_VERSION% Command Prompt ===
@echo JAVA_HOME=%JAVA_HOME%
@echo ANT_HOME=%ANT_HOME%
@echo GRADLE_HOME=%GRADLE_HOME%