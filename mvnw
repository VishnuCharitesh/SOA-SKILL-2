#!/bin/sh
set -e
DIRNAME=$(dirname "$0")
[ -z "$DIRNAME" ] && DIRNAME='.'
MAVEN_PROJECTBASEDIR="$DIRNAME"
WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_LAUNCHER="org.apache.maven.wrapper.MavenWrapperMain"

if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
  else
    JAVACMD='java'
  fi
fi

if [ ! -f "$WRAPPER_JAR" ]; then
    echo "Downloading maven-wrapper.jar..."
    mkdir -p "$MAVEN_PROJECTBASEDIR/.mvn/wrapper"
    if command -v curl > /dev/null 2>&1; then
        curl -fL -o "$WRAPPER_JAR" "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
    elif command -v wget > /dev/null 2>&1; then
        wget -O "$WRAPPER_JAR" "https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
    fi
fi

exec "$JAVACMD" \
  -Dmaven.multiModuleProjectDirectory="$MAVEN_PROJECTBASEDIR" \
  -classpath "$WRAPPER_JAR" \
  "$WRAPPER_LAUNCHER" "$@"
