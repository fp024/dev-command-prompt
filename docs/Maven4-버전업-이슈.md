# Maven 4 버전업 이슈



## mavenrc_pre.cmd가 Deprecated 되었다는 경고

mvn 실행시 경고가 아래 노출되었다.


```
C:\Maven>mvn -v
Warning: The mavenrc_pre.cmd script is deprecated and will be removed in a future version.
Apache Maven 4.0.0-rc-5 (fb3ecaef88106acb40467a450248dfdbd75f3b35)
Maven home: C:\Maven\4.0.x
Java version: 25, vendor: Eclipse Adoptium, runtime: C:\JDK\25
Default locale: en_US, platform encoding: UTF-8
OS name: "windows 11", version: "10.0", arch: "amd64", family: "winnt"

C:\Maven>
```

그래서 내가 쓰는 값을 확인해봄.

* mavenrc_pre.cmd

  ```cmd
  @echo off
  IF "%JAVA_HOME%"=="" (
    ECHO Setting JAVA_HOME=C:\JDK\17 from ~/mavenrc_pre.cmd
    SET JAVA_HOME=C:\JDK\17
  )
  ```

예전에 JAVA_HOME 없으면 자동 설정되게  해둔 흔적이 있는데, 현시점에서 반드시 필요하지 않긴 함..

지워도 될 것 같다. 😅





## Maven Upgrade Tool

* Maven Upgrade Tool
  * https://maven.apache.org/tools/mvnup.html
* Maven 4의 새로운 기능
  * https://maven.apache.org/whatsnewinmaven4.html


> maven 4에서는 빌드 POM과 컨슈머 POM으로 구분되기 때문에, 프로젝트의 pom.xml 파일이 마이그레이션이 되야한다고 한다.

### 예제


#### 기본 업그레이드 절차

모델 버전 4.1.0으로 전체 업그레이드가 가능한지 검증:

```sh
mvnup check --model-version 4.1.0 --all
```

모든 프로젝트 부분을 모델 버전 4.1.0으로 업그레이드:

```sh
mvnup apply --model-version 4.1.0 --all
```


#### 특정 항목 업그레이드

모든 플러그인과 모델을 버전 4.0.0으로 업그레이드:

```sh
mvnup apply --plugins --model
```

프로젝트 디렉토리를 지정하여 중복된 플러그인 및 의존성 선언 확인:

```sh
mvnup check --infer --directory /path/to/project
```





# 🤖 AI QnA

# >>> 빌드 pom과 컨슈머 pom의 차이를 알아야한다는데... 빌드 pom이 프로젝트 루트에 있는 pom.xml 말하는 것 같은데... 컨슈머는 뭔말일까?

**Build POM vs Consumer POM**의 차이를 설명드리겠습니다:

## Build POM (빌드 POM)
- 프로젝트 루트에 있는 **원본 `pom.xml`** 파일
- 개발자가 직접 작성하고 편집하는 파일
- 빌드 과정에서 사용되는 모든 정보 포함:
  - 플러그인 설정
  - 프로파일
  - 빌드 설정
  - 내부 변수 (`${project.version}` 등)

## Consumer POM (컨슈머 POM)
- Maven 4부터 도입된 개념
- **외부에 배포되는 "정리된" POM**
- 아티팩트(jar, war 등)와 함께 Maven 저장소에 업로드되는 버전
- 특징:
  - 빌드 관련 정보 **제거됨** (플러그인, 프로파일 등)
  - 변수가 **실제 값으로 치환됨** (`${project.version}` → `1.0.0`)
  - 의존성 정보만 포함 (다른 프로젝트가 이 라이브러리를 사용할 때 필요한 정보만)

## 예시

**Build POM (개발자가 작성)**
```xml
<version>${revision}</version>
<properties>
  <revision>1.0.0</revision>
</properties>
<build>
  <plugins>...</plugins>
</build>
```

**Consumer POM (Maven 저장소에 배포)**
```xml
<version>1.0.0</version>
<!-- build, plugins 등 제거됨 -->
<dependencies>...</dependencies>
```

## 왜 구분하나?
- **보안**: 내부 빌드 로직을 외부에 노출하지 않음
- **간결함**: 라이브러리 사용자에게 불필요한 정보 제거
- **호환성**: Maven 3와의 호환성 유지

Maven Upgrade Tool은 **Build POM만 업그레이드**하고, Consumer POM은 Maven 4가 자동으로 생성합니다! 😊



# >>> 빌드 POM은 사용자만 가지고있고, MvnRepo에 업로드 하지 않는다는 거구나!!

정확합니다! 👍

**Build POM**은:

- ✅ 개발자의 로컬/소스 저장소(GitHub 등)에만 존재
- ✅ 프로젝트를 빌드하는 데 필요한 모든 정보 포함
- ❌ Maven Central이나 회사 내부 Maven Repository에 **업로드되지 않음**

**Consumer POM**은:
- ✅ `mvn deploy` 시 Maven 4가 자동으로 생성
- ✅ 아티팩트(jar/war)와 함께 **Maven Repository에 업로드**
- ✅ 다른 개발자가 의존성으로 추가할 때 다운로드되는 POM

## 흐름 예시

```
[개발자 A]
Build POM (pom.xml) 
    ↓ mvn deploy
[Maven Repository] 
Consumer POM + JAR 업로드
    ↓ mvn install
[개발자 B]
Consumer POM만 다운로드하여 의존성 해결
```

Maven 3까지는 **Build POM을 그대로 업로드**해서 불필요한 정보까지 노출되었는데, Maven 4부터는 **Consumer POM을 자동 생성**해서 필요한 정보만 공유하도록 개선된 거죠! 😊


# >>> 보통 일반 스프링 웹 프로젝트 바꿀 때는 기본 업그레이드 절차만 하면 되려나?

네, 대부분의 일반 Spring 웹 프로젝트는 **기본 업그레이드 절차만으로 충분**합니다! 👍

## 권장 절차

```bash
# 1. 먼저 검증 (안전하게 확인)
mvnup check --model-version 4.1.0 --all

# 2. 문제 없으면 적용
mvnup apply --model-version 4.1.0 --all
```

## 추가 작업이 필요한 경우

다음과 같은 특수한 경우에만 추가 작업이 필요합니다:

- **멀티 모듈 프로젝트**에서 중복 선언이 많은 경우
  ```bash
  mvnup check --infer  # 중복 확인
  ```

- **레거시 플러그인**을 많이 사용하는 경우
  ```bash
  mvnup apply --plugins  # 플러그인만 업그레이드
  ```

- **Parent POM**을 직접 관리하는 경우
  - Spring Boot의 경우 `spring-boot-starter-parent`가 자동으로 처리해주므로 신경 안 써도 됨

## 일반적인 Spring Boot 프로젝트라면

```bash
mvnup check --all    # 검증
mvnup apply --all    # 적용
```

이것만 하면 99% 완료입니다! 😊

단, Maven 4.0.0 정식 릴리즈 전이라면 Spring Boot 최신 버전(3.3.x+)을 사용하는 것을 권장합니다.