#!/usr/bin/env bash

cd hello-world

# Start with Gradle 8...
./gradlew wrapper --gradle-version=8.0 -q

# Gradle 8 does not support signing with CC
./gradlew clean build --configuration-cache -q
sleep 2

# Let's try with Gradle 8.1 now
./gradlew wrapper --gradle-version=8.1 -q

# After cleaning, no signatures exist
./gradlew clean --configuration-cache -q
find . -name "*.asc"

# In Gradle 8.1, signing plugin works fine
./gradlew clean build --configuration-cache -q 
sleep 2

# Let's confirm signatures were generated
find . -name "*.asc"
sleep 4
