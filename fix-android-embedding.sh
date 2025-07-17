#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}===== Fixing Android Build Issues =====${NC}"
echo ""

# Navigate to the project directory
cd "$(dirname "$0")"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Error: Flutter is not installed or not in your PATH${NC}"
    exit 1
fi

# Backup the existing Android directory
echo -e "${YELLOW}Backing up existing Android directory...${NC}"
timestamp=$(date +%Y%m%d%H%M%S)
mkdir -p android_backup_$timestamp
cp -r android/* android_backup_$timestamp/ 2>/dev/null

# Clean the project
echo -e "${YELLOW}Cleaning the project...${NC}"
flutter clean

# Get dependencies
echo -e "${YELLOW}Getting dependencies...${NC}"
flutter pub get

# Create a fresh Android project
echo -e "${YELLOW}Recreating Android project...${NC}"
rm -rf android
flutter create --platforms=android .

# Restore keystore if it exists
if [ -f "android_backup_"*/app/upload-keystore.jks ]; then
    echo -e "${YELLOW}Restoring keystore...${NC}"
    cp android_backup_*/app/upload-keystore.jks android/app/
fi

# Create key.properties file
echo -e "${YELLOW}Creating key.properties file...${NC}"
cat > android/key.properties << EOL
storePassword=android
keyPassword=android
keyAlias=upload
storeFile=app/upload-keystore.jks
EOL

# Update build.gradle for release signing
echo -e "${YELLOW}Updating build.gradle for release signing...${NC}"
cat > android/app/build.gradle << 'EOL'
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace "com.example.quit_vaping"
    compileSdkVersion flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        applicationId "com.example.quit_vaping"
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    signingConfigs {
        release {
            if (keystoreProperties.containsKey('storeFile')) {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile file(keystoreProperties['storeFile'])
                storePassword keystoreProperties['storePassword']
            } else {
                keyAlias 'upload'
                keyPassword 'android'
                storeFile file('upload-keystore.jks')
                storePassword 'android'
            }
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}
EOL

# Create proguard-rules.pro file
echo -e "${YELLOW}Creating proguard-rules.pro file...${NC}"
cat > android/app/proguard-rules.pro << EOL
## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.plugin.editing.** { *; }
-dontwarn io.flutter.embedding.**
-dontwarn android.**
-dontwarn androidx.**
-dontwarn com.google.android.material.**
-dontwarn org.xmlpull.v1.**
EOL

echo -e "${GREEN}===== Android Build Issues Fixed =====${NC}"
echo ""
echo "Now you can build your app with:"
echo -e "${YELLOW}./prepare-playstore.sh${NC}"
echo ""
echo "Note: You may need to update the applicationId in android/app/build.gradle"
echo "to match your app's package name before building for the Play Store."