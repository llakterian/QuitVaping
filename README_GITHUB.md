# QuitVaping - AI-Powered Vaping Cessation App

QuitVaping is an intelligent mobile application designed to help users quit vaping through personalized AI-driven insights, progress tracking, and comprehensive support tools.

## Features

- **Vape-Free Tracker**: Track your progress in real-time with days, hours, and minutes since your last vape
- **Health Milestone Tracking**: Visualize your body's healing process with scientifically-backed health milestones
- **Financial Savings Calculator**: See how much money you're saving by not vaping
- **AI-Powered Support Chat**: Get personalized advice and motivation from our AI coach
- **Craving Management Tools**: Log and analyze your cravings to identify patterns and triggers
- **Panic Mode**: Quick access to distraction techniques during intense cravings
- **Guided Breathing Exercises**: Reduce stress and manage cravings with scientifically-proven breathing techniques
- **NRT Tracker**: Track and manage your nicotine replacement therapy (patches, gum, etc.) with reduction planning
- **Personalized Reminders & Motivations**: Stay on track with custom notifications and motivational content

## Screenshots

[Coming soon]

## Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Local Storage**: Hive
- **AI Integration**: Custom NLP models
- **Analytics**: Firebase Analytics
- **Notifications**: Flutter Local Notifications

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio / VS Code
- Firebase project (optional for analytics)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/llakterian/QuitVaping.git
   cd QuitVaping
   ```

2. Set up environment variables
   ```bash
   cp .env.example .env
   # Edit .env file with your API keys and configuration
   ```

3. Install dependencies
   ```bash
   flutter pub get
   ```

4. Run the app
   ```bash
   flutter run
   ```

## Deployment

### Web (Netlify)

1. Build and prepare for Netlify
   ```bash
   ./prepare-netlify.sh
   ```

2. Upload the generated zip file to Netlify
   - Go to [Netlify Drop](https://app.netlify.com/drop)
   - Drag and drop the `deploy/quitvaping-netlify.zip` file

### Android

1. Build the APK
   ```bash
   flutter build apk --release
   ```

2. The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

## Environment Variables

The following environment variables are used in the app:

- `OPENAI_API_KEY`: API key for OpenAI services
- `FIREBASE_API_KEY`: Firebase API key
- `FIREBASE_PROJECT_ID`: Firebase project ID
- `FIREBASE_APP_ID`: Firebase app ID
- `FIREBASE_MESSAGING_SENDER_ID`: Firebase messaging sender ID
- `FIREBASE_STORAGE_BUCKET`: Firebase storage bucket
- `ANALYTICS_ENABLED`: Enable/disable analytics (true/false)
- `ENABLE_COMMUNITY_FEATURES`: Enable/disable community features (true/false)
- `ENABLE_ADVANCED_AI`: Enable/disable advanced AI features (true/false)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Special thanks to all the addiction specialists and behavioral scientists who provided insights for this app
- Icons by [Material Design Icons](https://material.io/resources/icons/)
- Breathing exercise techniques based on scientific research in stress management and addiction recovery