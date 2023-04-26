#!/usr/bin/env bash

cd hello-world

# Remove file repositories
rm -Rf /tmp/file-repos

# Start with Gradle 8...
./gradlew wrapper --gradle-version=8.0 -q

# Gradle 8 does not support ivy-publish with CC
./gradlew publish --configuration-cache
sleep 2

# No repos published
find /tmp/file-repos
sleep 2

# Let's try with Gradle 8.1 now
./gradlew wrapper --gradle-version=8.1 -q

# In Gradle 8.1, ivy-publish and maven-publish with CC and file-based repos work fine
./gradlew publish --configuration-cache 
sleep 2

# Let's check the ivy and maven repos
find /tmp/file-repos
sleep 4
