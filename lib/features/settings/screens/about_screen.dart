import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../shared/theme/app_colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = '';
  String _buildNumber = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _version = '1.0.0';
        _buildNumber = '1';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // App name and version
                  const Text(
                    'QuitVaping',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version $_version (Build $_buildNumber)',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // App description
                  const Text(
                    'QuitVaping is an AI-powered app designed to help you quit vaping through personalized tracking, support, and evidence-based strategies.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  
                  // Features section
                  _buildSectionHeader('Key Features'),
                  _buildFeatureItem(
                    'Personalized Tracking',
                    'Track your cravings, triggers, and progress over time',
                    Icons.analytics,
                  ),
                  _buildFeatureItem(
                    'NRT Management',
                    'Track and manage your nicotine replacement therapy',
                    Icons.medication,
                  ),
                  _buildFeatureItem(
                    'Breathing Exercises',
                    'Guided breathing techniques to manage cravings',
                    Icons.air,
                  ),
                  _buildFeatureItem(
                    'Health Insights',
                    'See how your health improves as you quit',
                    Icons.favorite,
                  ),
                  _buildFeatureItem(
                    'Community Support',
                    'Connect with others on the same journey',
                    Icons.people,
                  ),
                  const SizedBox(height: 32),
                  
                  // Health benefits section
                  _buildSectionHeader('Health Benefits of Quitting'),
                  _buildTimelineItem(
                    '20 Minutes',
                    'Heart rate and blood pressure drop',
                  ),
                  _buildTimelineItem(
                    '12 Hours',
                    'Carbon monoxide level in blood drops to normal',
                  ),
                  _buildTimelineItem(
                    '2-3 Days',
                    'Sense of smell and taste begin to improve',
                  ),
                  _buildTimelineItem(
                    '1-3 Months',
                    'Circulation and lung function improve',
                  ),
                  _buildTimelineItem(
                    '1-9 Months',
                    'Coughing and shortness of breath decrease',
                  ),
                  _buildTimelineItem(
                    '1 Year',
                    'Risk of heart disease drops to half that of a vaper',
                  ),
                  const SizedBox(height: 32),
                  
                  // Contact section
                  _buildSectionHeader('Contact Us'),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('llakterian@gmail.com'),
                    onTap: () => _launchUrl('mailto:llakterian@gmail.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Website'),
                    subtitle: const Text('llakterian.github.io/quitvaping'),
                    onTap: () => _launchUrl('https://llakterian.github.io/quitvaping'),
                  ),
                  const SizedBox(height: 32),
                  
                  // Credits section
                  _buildSectionHeader('Credits'),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'This app was developed by Llakterian. Icons and images used in this app are either original or from free, properly licensed sources.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '© 2025 QuitVaping. All rights reserved. Built by Llakterian.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 2,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String time, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}