# Requirements Document

## Introduction

The QuitVaping app is currently using the restricted package name "com.example.quit_vaping" which is being rejected by Google Play Console. We need to change the package name to a proper, unique identifier that will be accepted by Google Play Store and ensure all references are updated consistently across the entire Android project.

## Requirements

### Requirement 1

**User Story:** As a developer, I want to change the Android package name from the restricted "com.example.quit_vaping" to a proper package name, so that Google Play Console will accept the app bundle for publication.

#### Acceptance Criteria

1. WHEN the package name is changed THEN the new package name SHALL be "com.llakterian.quitvaping"
2. WHEN the package name is updated THEN all Android manifest files SHALL reflect the new package name
3. WHEN the package name is updated THEN the build.gradle.kts file SHALL use the new applicationId and namespace
4. WHEN the package name is updated THEN the MainActivity.kt file SHALL be moved to the correct package directory structure
5. WHEN the package name is updated THEN the MainActivity.kt file SHALL have the correct package declaration

### Requirement 2

**User Story:** As a developer, I want all package references to be updated consistently, so that the app builds successfully with the new package name.

#### Acceptance Criteria

1. WHEN the package name is changed THEN the directory structure SHALL match the new package name (com/llakterian/quitvaping)
2. WHEN the package name is changed THEN all old package directories SHALL be removed to avoid conflicts
3. WHEN the package name is changed THEN the app SHALL build successfully with flutter build appbundle --release
4. WHEN the package name is changed THEN the generated bundle SHALL have the new package name and be accepted by Google Play Console

### Requirement 3

**User Story:** As a developer, I want to verify the package name change is complete, so that I can confidently upload to Google Play Console without package name errors.

#### Acceptance Criteria

1. WHEN the package name fix is complete THEN running flutter clean and flutter build appbundle --release SHALL generate a bundle with the new package name
2. WHEN the bundle is generated THEN it SHALL NOT contain any references to "com.example"
3. WHEN the bundle is uploaded to Google Play Console THEN it SHALL NOT show package name restriction errors
4. WHEN the app is installed THEN it SHALL run correctly with the new package name