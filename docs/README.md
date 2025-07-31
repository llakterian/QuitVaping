# QuitVaping - Your Journey to Freedom

A comprehensive mobile application designed to support individuals on their journey to quit vaping through evidence-based breathing exercises, progress tracking, and personalized support tools.

## About QuitVaping

QuitVaping empowers users to break free from vaping addiction by providing scientifically-backed breathing techniques, comprehensive progress monitoring, and supportive tools that make the quitting process more manageable and successful.

### Why QuitVaping?

Quitting vaping is challenging, but you don't have to do it alone. QuitVaping combines:

- **Evidence-Based Techniques**: Proven breathing exercises that reduce cravings and anxiety
- **Personalized Support**: Tailored tracking and insights based on your unique journey
- **Comprehensive Tools**: Everything you need in one app - from breathing exercises to NRT tracking
- **Progress Motivation**: Visual progress tracking that celebrates your achievements

## Key Features

### 🫁 Guided Breathing Exercises
Transform cravings into calm with our collection of therapeutic breathing techniques:

- **4-7-8 Breathing**: Reduces anxiety and promotes relaxation
- **Box Breathing**: Improves focus and stress management
- **Triangle Breathing**: Quick technique for immediate craving relief
- **Deep Relaxation** (Premium): Extended sessions for deep stress relief
- **Quick Calm** (Premium): Rapid techniques for urgent situations

### 📊 Progress Tracking
Stay motivated with comprehensive tracking features:

- **Quit Timeline**: Visual representation of your smoke-free journey
- **Health Milestones**: Track improvements in lung function and overall health
- **Savings Calculator**: See how much money you've saved by quitting
- **Achievement System**: Unlock badges and celebrate your progress

### 💊 NRT (Nicotine Replacement Therapy) Support
Manage your nicotine replacement therapy effectively:

- **Usage Tracking**: Log patches, gum, lozenges, and other NRT products
- **Dosage Management**: Track and gradually reduce nicotine intake
- **Smart Reminders** (Premium): Personalized alerts based on your usage patterns
- **Analytics Dashboard** (Premium): Detailed insights into your NRT effectiveness

### 📱 Daily Support Tools
Stay on track with daily support features:

- **Mood Check-ins**: Monitor emotional patterns and triggers
- **Craving Log**: Track intensity and frequency of cravings
- **Health Information**: Educational content about quitting benefits
- **Emergency Support**: Quick access to breathing exercises during intense cravings

### 💎 Premium Features
Unlock advanced tools for enhanced support:

- **Advanced Breathing Library**: Access to specialized breathing techniques
- **Detailed Analytics**: Comprehensive insights into your quitting patterns
- **Personalized Recommendations**: AI-driven suggestions based on your progress
- **Ad-Free Experience**: Focus on your journey without distractions
- **Priority Support**: Direct access to help when you need it most

## Screenshots

Get a glimpse of QuitVaping's intuitive interface and powerful features:

<div align="center">
  <img src="screenshots/app-features/01_dashboard_home.png" alt="Dashboard Home" width="200"/>
  <img src="screenshots/app-features/03_breathing_exercise_active.png" alt="Breathing Exercise" width="200"/>
  <img src="screenshots/app-features/05_progress_tracking.png" alt="Progress Tracking" width="200"/>
  <img src="screenshots/app-features/06_nrt_tracker.png" alt="NRT Tracker" width="200"/>
</div>

*From left to right: Dashboard with progress overview, Active breathing exercise session, Progress tracking with milestones, NRT usage tracking*

## App Icon

<div align="center">
  <img src="play_store_assets/graphics/app_icon.png" alt="QuitVaping App Icon" width="120"/>
</div>

## Feature Highlights

### 🎯 **Immediate Craving Relief**
When a craving hits, QuitVaping provides instant access to proven breathing techniques that can reduce the intensity and duration of nicotine cravings within minutes.

### 📈 **Visual Progress Motivation**
See your journey unfold with beautiful charts and milestone celebrations that keep you motivated during challenging moments.

### 🧠 **Science-Backed Approach**
Every feature is built on research-proven methods for addiction recovery, ensuring you have the most effective tools at your disposal.

### 🤝 **Personalized Experience**
The app learns from your patterns and provides customized recommendations to optimize your quitting strategy.## G
etting Started

### Prerequisites

Before you begin, ensure you have the following installed on your development machine:

#### Required Software
- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Version 2.18.0 or higher (included with Flutter)
- **Android Studio**: Latest stable version (recommended) or VS Code with Flutter extension
- **Git**: For version control

#### Platform-Specific Requirements

**For Android Development:**
- Android SDK (API level 21 or higher)
- Android device or emulator for testing

**For iOS Development (macOS only):**
- Xcode 12.0 or higher
- iOS device or simulator for testing
- CocoaPods (installed via `sudo gem install cocoapods`)

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/llakterian/QuitVaping.git
cd QuitVaping
```

#### 2. Install Flutter Dependencies
```bash
flutter pub get
```

#### 3. Verify Flutter Installation
```bash
flutter doctor
```
Ensure all checkmarks are green. If not, follow the Flutter documentation to resolve any issues.

#### 4. Run the Application

**On Android:**
```bash
# Connect an Android device or start an emulator
flutter run
```

**On iOS (macOS only):**
```bash
# Open iOS simulator or connect an iOS device
flutter run
```

### Building for Release

#### Android App Bundle (Recommended for Play Store)
```bash
flutter build appbundle --release
```
The generated file will be located at: `build/app/outputs/bundle/release/app-release.aab`

#### Android APK
```bash
flutter build apk --release
```
The generated file will be located at: `build/app/outputs/flutter-apk/app-release.apk`

#### iOS (macOS only)
```bash
flutter build ios --release
```

### Development Commands

#### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

#### Code Analysis
```bash
# Analyze code for issues
flutter analyze

# Format code
dart format .
```

#### Clean Build
```bash
# Clean build files
flutter clean
flutter pub get
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: "Flutter command not found"
**Solution:** Ensure Flutter is added to your PATH environment variable.
```bash
export PATH="$PATH:`pwd`/flutter/bin"
```

#### Issue: "Android license status unknown"
**Solution:** Accept Android licenses:
```bash
flutter doctor --android-licenses
```

#### Issue: "CocoaPods not installed" (iOS)
**Solution:** Install CocoaPods:
```bash
sudo gem install cocoapods
cd ios && pod install
```

#### Issue: "Gradle build failed"
**Solution:** 
1. Clean the project: `flutter clean`
2. Delete `android/.gradle` folder
3. Run `flutter pub get`
4. Try building again

#### Issue: "Version conflict" errors
**Solution:** 
1. Delete `pubspec.lock`
2. Run `flutter pub get`
3. If issues persist, run `flutter pub deps` to check dependency conflicts

### Performance Optimization

For the best development experience:

1. **Use a physical device** when possible for more accurate performance testing
2. **Enable hot reload** during development for faster iteration
3. **Profile your app** using `flutter run --profile` to identify performance bottlenecks
4. **Use release builds** for final testing and distribution

### Getting Help

If you encounter issues not covered here:

1. Check the [Flutter documentation](https://flutter.dev/docs)
2. Search existing [GitHub issues](https://github.com/llakterian/QuitVaping/issues)
3. Create a new issue with detailed information about your problem
4. Join the Flutter community on [Discord](https://discord.gg/flutter) or [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

### System Requirements

**Minimum Requirements:**
- **RAM**: 4GB (8GB recommended)
- **Storage**: 2GB free space
- **OS**: Windows 10, macOS 10.14, or Ubuntu 18.04 (or equivalent Linux distribution)

**Recommended for Optimal Performance:**
- **RAM**: 8GB or more
- **Storage**: SSD with 5GB+ free space
- **CPU**: Multi-core processor## Contr
ibuting

We welcome contributions from the community! Whether you're fixing bugs, adding features, or improving documentation, your help makes QuitVaping better for everyone.

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

For detailed contribution guidelines, please see [CONTRIBUTING.md](docs/CONTRIBUTING.md).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Contact

### Getting Help
- **Documentation**: Check our [docs](docs/) folder for detailed guides
- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/llakterian/QuitVaping/issues)
- **Email**: For direct support, contact llakterian@gmail.com

### Community
Join our community of users and contributors working together to help people quit vaping and live healthier lives.

## Acknowledgments

- Thanks to all contributors who have helped improve QuitVaping
- Breathing exercise techniques based on established mindfulness and stress-reduction practices
- Icons and images sourced from free resources (see [image credits](assets/free_images/image_credits.md))

---

**🌟 Help people live healthier, vape-free lives with QuitVaping! 🌟**

*Made with ❤️ for those on their journey to freedom from vaping addiction.*