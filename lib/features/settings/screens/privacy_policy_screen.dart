import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: July 21, 2025',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Introduction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'QuitVaping ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how your personal information is collected, used, and disclosed by QuitVaping.',
            ),
            SizedBox(height: 16),
            Text(
              'This Privacy Policy applies to our app, and its associated services (collectively, our "Service"). By accessing or using our Service, you signify that you have read, understood, and agree to our collection, storage, use, and disclosure of your personal information as described in this Privacy Policy.',
            ),
            SizedBox(height: 24),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We collect information that you provide directly to us. For example, we collect information when you create an account, update your profile, use the interactive features of our app, participate in surveys, contests or promotions, request customer support, or otherwise communicate with us.',
            ),
            SizedBox(height: 16),
            Text(
              'The types of information we may collect include:',
            ),
            SizedBox(height: 8),
            Text('• Your name, email address, and other contact information'),
            Text('• Your quit date and vaping history'),
            Text('• Information about your cravings and triggers'),
            Text('• Your progress and achievements'),
            Text('• Your preferences and settings'),
            Text('• Any other information you choose to provide'),
            SizedBox(height: 24),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We use the information we collect to:',
            ),
            SizedBox(height: 8),
            Text('• Provide, maintain, and improve our Service'),
            Text('• Personalize your experience'),
            Text('• Send you technical notices, updates, and support messages'),
            Text('• Respond to your comments and questions'),
            Text('• Analyze usage patterns and trends'),
            Text('• Protect against, identify, and prevent fraud and other illegal activity'),
            SizedBox(height: 24),
            Text(
              'Data Storage and Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We use commercially reasonable security measures to protect your information. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
            ),
            SizedBox(height: 16),
            Text(
              'Your personal data is stored locally on your device and may be synchronized with our secure servers. We use encryption to protect sensitive information transmitted online.',
            ),
            SizedBox(height: 24),
            Text(
              'Your Rights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to:',
            ),
            SizedBox(height: 8),
            Text('• Access the personal information we have about you'),
            Text('• Correct inaccuracies in your personal information'),
            Text('• Delete your personal information'),
            Text('• Object to the processing of your personal information'),
            Text('• Request a copy of your personal information'),
            SizedBox(height: 16),
            Text(
              'To exercise these rights, please contact us at privacy@quitvaping.app.',
            ),
            SizedBox(height: 24),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
            ),
            SizedBox(height: 16),
            Text(
              'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
            ),
            SizedBox(height: 24),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at:',
            ),
            SizedBox(height: 8),
            Text('privacy@quitvaping.app'),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}