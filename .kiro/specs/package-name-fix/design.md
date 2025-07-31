# Design Document

## Overview

This design outlines the systematic approach to change the Android package name from the restricted "com.example.quit_vaping" to "com.llakterian.quitvaping" across all Android configuration files and directory structures. The change must be comprehensive to ensure Google Play Console acceptance and proper app functionality.

## Architecture

### Current State Analysis
- **Package Name**: `com.example.quit_vaping` (restricted by Google Play)
- **Namespace**: `com.example.quit_vaping` in build.gradle.kts
- **ApplicationId**: `com.example.quit_vaping` in build.gradle.kts
- **Directory Structure**: `android/app/src/main/kotlin/com/example/quit_vaping/`
- **MainActivity Package**: `package com.example.quit_vaping`
- **Manifest Files**: Missing package declarations (relying on build.gradle.kts)

### Target State
- **Package Name**: `com.llakterian.quitvaping`
- **Namespace**: `com.llakterian.quitvaping`
- **ApplicationId**: `com.llakterian.quitvaping`
- **Directory Structure**: `android/app/src/main/kotlin/com/llakterian/quitvaping/`
- **MainActivity Package**: `package com.llakterian.quitvaping`
- **Manifest Files**: Explicit package declarations added

## Components and Interfaces

### 1. Build Configuration Component
**File**: `android/app/build.gradle.kts`
- **Current**: 
  - `namespace = "com.example.quit_vaping"`
  - `applicationId = "com.example.quit_vaping"`
- **Target**:
  - `namespace = "com.llakterian.quitvaping"`
  - `applicationId = "com.llakterian.quitvaping"`

### 2. Android Manifest Component
**Files**: 
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/debug/AndroidManifest.xml`
- `android/app/src/profile/AndroidManifest.xml`

**Current**: No explicit package declarations
**Target**: Add explicit package declarations to all manifest files

### 3. MainActivity Component
**Current Location**: `android/app/src/main/kotlin/com/example/quit_vaping/MainActivity.kt`
**Target Location**: `android/app/src/main/kotlin/com/llakterian/quitvaping/MainActivity.kt`
**Package Declaration**: Change from `com.example.quit_vaping` to `com.llakterian.quitvaping`

### 4. Directory Structure Component
**Current**: `com/example/quit_vaping/`
**Target**: `com/llakterian/quitvaping/`
**Action**: Create new directory structure and remove old structure

## Data Models

### Package Name Configuration
```kotlin
// build.gradle.kts configuration
android {
    namespace = "com.llakterian.quitvaping"
    defaultConfig {
        applicationId = "com.llakterian.quitvaping"
    }
}
```

### Manifest Configuration
```xml
<!-- AndroidManifest.xml -->
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.llakterian.quitvaping">
```

### MainActivity Configuration
```kotlin
// MainActivity.kt
package com.llakterian.quitvaping

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
```

## Error Handling

### 1. Build Failures
- **Issue**: Package name conflicts during build
- **Solution**: Ensure complete cleanup of old package references
- **Verification**: Run `flutter clean` before rebuilding

### 2. Directory Structure Conflicts
- **Issue**: Old package directories interfering with new structure
- **Solution**: Remove old directories completely before creating new ones
- **Verification**: Check that only new package structure exists

### 3. Manifest Parsing Errors
- **Issue**: Invalid package declarations in manifest files
- **Solution**: Use consistent package name format across all manifests
- **Verification**: Validate XML syntax and package name format

### 4. Google Play Console Rejection
- **Issue**: Bundle still contains old package references
- **Solution**: Verify bundle contents and rebuild if necessary
- **Verification**: Check bundle metadata before upload

## Testing Strategy

### 1. Build Verification
- **Test**: `flutter clean && flutter pub get && flutter build appbundle --release`
- **Expected**: Successful build with no package-related errors
- **Verification**: Check generated bundle for correct package name

### 2. Package Name Verification
- **Test**: Extract and inspect app bundle contents
- **Expected**: All references show `com.llakterian.quitvaping`
- **Verification**: No occurrences of `com.example` in bundle

### 3. App Functionality Testing
- **Test**: Install and run app with new package name
- **Expected**: App launches and functions normally
- **Verification**: All features work as expected

### 4. Google Play Console Upload
- **Test**: Upload bundle to Google Play Console
- **Expected**: No package name restriction errors
- **Verification**: Bundle accepted for internal testing

## Implementation Sequence

### Phase 1: Configuration Updates
1. Update `build.gradle.kts` with new package name
2. Add explicit package declarations to all manifest files
3. Verify configuration consistency

### Phase 2: Directory Structure Migration
1. Create new package directory structure
2. Move MainActivity to new location
3. Update MainActivity package declaration
4. Remove old package directories

### Phase 3: Build and Verification
1. Clean build environment
2. Rebuild app bundle
3. Verify package name in generated bundle
4. Test app functionality

### Phase 4: Google Play Console Validation
1. Upload new bundle to Google Play Console
2. Verify acceptance without package name errors
3. Complete internal testing setup

## Security Considerations

### Package Name Uniqueness
- **Requirement**: Package name must be globally unique
- **Solution**: Use domain-based naming convention (`com.llakterian.quitvaping`)
- **Verification**: Check Google Play Console for name availability

### Bundle Signing
- **Requirement**: Maintain consistent signing with new package name
- **Solution**: Use existing release keystore with new package
- **Verification**: Ensure bundle is properly signed for release

## Performance Impact

### Build Time
- **Impact**: Minimal - only configuration changes
- **Mitigation**: Clean build required but no ongoing performance impact

### App Size
- **Impact**: None - package name change doesn't affect app size
- **Verification**: Compare bundle sizes before and after change

### Runtime Performance
- **Impact**: None - package name is metadata only
- **Verification**: App performance remains unchanged