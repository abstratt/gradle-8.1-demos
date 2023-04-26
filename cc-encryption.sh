#!/usr/bin/env bash

cd hello-world

# Start with Gradle 8...
./gradlew wrapper --gradle-version=8.0 -q

# Remove configuration cache area
rm -Rf .gradle/configuration-cache

# Build with Gradle 8
./gradlew build -x sign --configuration-cache -q

# Gradle 8 stores configuration data as-is in the configuration area
grep "hello.world.App" -R .gradle/configuration-cache

# That is no good... that could include credentials and other sensitive info
sleep 3

# Let's try with Gradle 8.1 now
./gradlew wrapper --gradle-version=8.1 -q

# Remove configuration cache area again
rm -Rf .gradle/configuration-cache

# In Gradle 8.1, encryption is always on
./gradlew build -x sign --configuration-cache -q

sleep 2
# Since it is encrypted, grep finds nothing
grep "hello.world.App" -R .gradle/configuration-cache

# phew... :)
