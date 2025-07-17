# Google Play Store Submission Checklist

## Before Building

- [ ] Update app version in `pubspec.yaml` (both version number and build number)
- [ ] Test the app thoroughly on multiple Android devices/emulators
- [ ] Ensure all Firebase configurations are set up correctly
- [ ] Check that all API keys and sensitive data are properly secured
- [ ] Verify app icon meets Play Store requirements (512x512 PNG, 32-bit)
- [ ] Prepare feature graphic (1024x500 PNG)
- [ ] Prepare at least 2-8 screenshots for different device sizes
- [ ] Write compelling app description, short description, and release notes
- [ ] Prepare privacy policy URL (required for all apps)

## Building the App

- [ ] Run `./prepare-playstore.sh` to generate signed AAB and APK files
- [ ] Verify the AAB file works by testing the APK on a real device

## Play Console Setup

- [ ] Create/access your Google Play Developer account
- [ ] Pay the one-time $25 registration fee (if not already done)
- [ ] Set up your developer profile
- [ ] Create a new application in the Play Console

## App Store Listing

- [ ] App name (30 characters max)
- [ ] Short description (80 characters max)
- [ ] Full description (4000 characters max)
- [ ] Upload app icon (512x512 PNG)
- [ ] Upload feature graphic (1024x500 PNG)
- [ ] Upload at least 2-8 screenshots for phones (16:9 aspect ratio recommended)
- [ ] Upload screenshots for tablets (if supporting tablets)
- [ ] Add promo video (optional)
- [ ] Select app category and tags
- [ ] Add contact details (email, website, phone)

## Content Rating

- [ ] Complete the content rating questionnaire
- [ ] Confirm your app's target audience and content

## Pricing & Distribution

- [ ] Select free or paid app
- [ ] Choose countries for distribution
- [ ] Confirm the app contains no ads (or declare ad networks used)
- [ ] Confirm app complies with US export laws
- [ ] Set up app pricing (if applicable)

## App Release

- [ ] Upload the AAB file to a new release
- [ ] Add release notes
- [ ] Choose release type (internal testing, closed testing, open testing, or production)
- [ ] Submit for review

## Post-Submission

- [ ] Monitor the review status in the Play Console
- [ ] Be prepared to address any policy violations or issues raised by the review team
- [ ] Once approved, monitor app performance and user feedback

## Common Reasons for Rejection

- Missing or insufficient privacy policy
- Crashes and bugs
- Intellectual property violations
- Misleading app description or functionality
- Poor user experience
- Requesting unnecessary permissions
- Non-compliance with Play Store policies regarding content