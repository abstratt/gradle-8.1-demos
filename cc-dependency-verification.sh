#!/usr/bin/env bash

cd configuration-cache-dependency-management

# Start with Gradle 8.1
./gradlew wrapper --gradle-version=8.1 -q

# Clean up
./gradlew clean publish -q

# No verification metadata file at first 
rm -Rf gradle/verification-metadata.xml

# Generate the verification file (gradle/verification-metadata.xml)
./gradlew --write-verification-metadata pgp,sha256 resolve

# Cache miss, verification passes
./gradlew resolve -q

# Change the verification file so that ivy-lib.jar cannot be verified 
./gradlew breakVerificationMetadata -q

# Cache miss due to changed metadata file, 
# verification fails as we have incomplete metadata
./gradlew resolve -q

# Revert the change to verification file
./gradlew fixVerificationMetadata -q

# Cache miss, but verification passes again
./gradlew resolve -q

# Publish new versions, these will not be verified yet
./gradlew publish -DlibVersion=2.0 -q

# Fails due to failed verification
./gradlew resolve -q

# Missing dependency verification metadata detected. Success!

# Now update the verification metadata
./gradlew --write-verification-metadata pgp,sha256 resolve

# Verification now passes again
./gradlew resolve -q

