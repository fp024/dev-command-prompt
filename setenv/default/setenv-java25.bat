:: 💡 Maven은 Maven 4 정식 출시가 되면 적용하자!, maven-compiler-plugin 3.x.x 버전대가 Java 25 지원을 못한다.
::    Maven 4의 RC가 나온 상태이니 일단 적용해보자!
@SET JAVA_VERSION=25
@SET ANT_VERSION=1.10.x
@SET GRADLE_VERSION=9.x
@SET MAVEN_VERSION=4.0.x
@SET JAVA_HOME=C:\JDK\%JAVA_VERSION%
@SET ANT_HOME=C:\ant\%ANT_VERSION%
@SET MAVEN_HOME=C:\Maven\%MAVEN_VERSION%
@SET GRADLE_HOME=C:\Gradle\%GRADLE_VERSION%
@echo === Java %JAVA_VERSION%, ant %ANT_VERSION%, Maven %MAVEN_VERSION%, Gradle %GRADLE_VERSION% Command Prompt ===
@echo JAVA_HOME=%JAVA_HOME%
@echo ANT_HOME=%ANT_HOME%
@echo MAVEN_HOME=%MAVEN_HOME%
@echo GRADLE_HOME=%GRADLE_HOME%