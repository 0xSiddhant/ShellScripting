#!/bin/bash
set -euo pipefail

# Function to clean iOS
clean_ios() {
    echo "🍎 Detected iOS Project..."
    
    # 1. Clean Build Folder
    if xcodebuild -quiet clean; then
        echo "✅ xcodebuild clean complete."
    else
        echo "⚠️  xcodebuild failed (ignoring)..."
    fi

    # 2. Delete DerivedData (The magic fix for most Xcode bugs)
    # Warning: This forces a full re-index next time you open Xcode.
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    echo "🗑️  Deleted DerivedData."
    
    # 3. Pods (if used)
    if [[ -f "Podfile" ]]; then
        echo "CocoaPods detected. Cleaning Pods..."
        rm -rf Pods
        rm -f Podfile.lock
        pod install
    fi
}

# Function to clean Android
clean_android() {
    echo "🤖 Detected Android Project..."
    if [[ -f "./gradlew" ]]; then
        ./gradlew clean
        echo "✅ Gradle clean complete."
    else
        echo "❌ No gradlew wrapper found."
    fi
}

# Function to clean Flutter
clean_flutter() {
    echo "💙 Detected Flutter Project..."
    flutter clean
    flutter pub get
    echo "✅ Flutter clean & pub get complete."
    
    # Flutter often leaves iOS artifacts behind, so check that too
    if [[ -d "ios" ]]; then
        cd ios
        clean_ios
        cd ..
    fi
}

# --- Main Logic ---
if [[ -f "pubspec.yaml" ]]; then
    clean_flutter
elif [[ -f "build.gradle" || -f "app/build.gradle" ]]; then
    clean_android
elif [[ -d *.xcodeproj || -d *.xcworkspace ]]; then
    clean_ios
else
    echo "❌ Unknown project type. Are you in the root folder?"
fi