# 安装
1. 先去sonaqube中文插件的git仓库查看最新支持的中文插件版本并下载
https://github.com/xuhuisheng/sonar-l10n-zh/releases

2. 然后如docker hub下载匹配中间插件的sonarqube镜像

3. 用本项目中的docker-compose.yml文件也行，想要最新的docker-compose.yml文件可以去sona的github仓库
https://github.com/SonarSource/docker-sonarqube/blob/master/example-compose-files/sq-with-postgres/docker-compose.yml

4. 安装完后默认用户名密码为  admin / admin

5. 安装中文插件
将之前下载的中文插件jar包拷贝到extensions/plugins  路径中重启sonar容器  ，注意文件权限

6. Sonar其它插件安装
登录SonarQube-配置-应用市场-全部-选择相应的插件进行安装

# 扫描
去以下页面下载scanner
https://docs.sonarsource.com/sonarqube-server/analyzing-source-code/scanners/sonarscanner

SonarScanner CLI  这里有一个下拉箭头点一下就能看到



查看一下页面要求的jdk版本，本次下载的sonar-scanner-cli-7.3.0.5189-linux-aarch64需要jdk17  扫描静态页面的话本机需要有node20+
https://docs.sonarsource.com/sonarqube-server/analyzing-source-code/scanners/scanner-environment/general-requirements



```
sonar-scanner \
  -Dsonar.projectKey=mat-data-manage \
  -Dsonar.projectName="mat-data-manage" \
  -Dsonar.projectVersion=2.1.0 \
  -Dsonar.sources=./ \
  -Dsonar.java.binaries="data-manage-api/target,data-manage-common/target,data-manage-mapper/target,data-manage-service/target" \
  -Dsonar.exclusions="**/.gitignore" \
  -Dsonar.java.source=8 \
  -Dsonar.java.target=8 \
  -Dsonar.host.url=http://10.100.12.22:9000 \
  -Dsonar.organization=tydic \
  -Dsonar.token=squ_59cdbcb4d475f5136bd1f797a5a3e35cf7b80871

# -Dsonar.login=squ_4eec30d1178deb0e19629e99c22251192ea90b0e \
```



# 报告
高版本不能产生报告，sonar-pdfreport-plugin-4.0.1.jar最高支持到了9.9.6 ，如果需要导出报告的话最好使用低版本sonarqube，如果不需要导出报告，使用高版本即可




sona插件  
jdk8版本
org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar
jdk17版本
org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar 


1. 创建令牌
SonarQube 25.x 不再允许登录使用用户名密码做扫描，必须：
UI → 头像 → My Account → Security → Generate Token

2.  mvn执行扫描有两种方式
a. 在项目根目录创建 sonar-project.properties
```
sonar.projectKey=my-project
sonar.projectName=my-project
sonar.host.url=http://10.100.12.22:9000
sonar.login=sonar_token_123456

# Java 配置
sonar.sources=src/main/java
sonar.tests=src/test/java
sonar.java.binaries=target/classes
```
然后执行
```
mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar -Dproject.settings=sonar.properties
```

b. 直接使用命令，带入所有参数 

注意事项：代码监测必须是jdk17版本，代码版本是多少无所谓，可以通过  -Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8 来制定代码版本
如果不关心测试覆盖率，test相关的部分可以不用写
```
mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar \
-Dsonar.projectKey=my-project \
-Dsonar.host.url=http://10.100.12.22:9000 \
-Dsonar.login=<token> \
-Dsonar.sources=src/main/java \
-Dsonar.tests=src/test/java \
-Dsonar.java.binaries=target/classes
```
举例

```
 /middleware/apache-maven-3.8.8_jdk17/bin/mvn clean verify \
  -Dmaven.compiler.source=1.8 \
  -Dmaven.compiler.target=1.8 \
  org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar \
  -Dsonar.projectKey=mat-data-manage \
  -Dsonar.projectName="mat-data-manage" \
  -Dsonar.host.url=http://10.100.12.22:9000 \
  -Dsonar.login=squ_8470916e4254f0eaed1ded8eb4863892d4c568ab \
  -Dsonar.modules=data-manage-service,data-manage-mapper,data-manage-common,data-manage-api \
  -Ddata-manage-service.sonar.sources=data-manage-service/src/main \
  -Ddata-manage-mapper.sonar.sources=data-manage-mapper/src/main \
  -Ddata-manage-common.sonar.sources=data-manage-common/src/main \
  -Dsonar.java.binaries=data-manage-service/target 

```
