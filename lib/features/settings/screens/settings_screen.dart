import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/services/user_service.dart';
import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../subscription/screens/subscription_screen.dart';
import '../../breathing/screens/breathing_notification_settings_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final user = userService.currentUser;
    final isPremium = subscriptionService.isPremium;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Account section
          _buildSectionHeader(context, 'Account'),
          
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            subtitle: Text(user?.name ?? 'Not set'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Quit Date'),
            subtitle: Text(
              user?.quitDate != null
                  ? user!.quitDate!.toString().split(' ')[0]
                  : 'Not set',
            ),
            onTap: () async {
              if (user != null) {
                final date = await showDatePicker(
                  context: context,
                  initialDate: user.quitDate ?? DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                
                if (date != null) {
                  await userService.setQuitDate(date);
                }
              }
            },
          ),
          
          // Subscription section
          _buildSectionHeader(context, 'Subscription'),
          
          ListTile(
            leading: Icon(
              Icons.star,
              color: isPremium ? Colors.amber : null,
            ),
            title: Text(
              isPremium ? 'Premium Subscription' : 'Upgrade to Premium',
            ),
            subtitle: Text(
              isPremium
                  ? 'Active until ${subscriptionService.subscriptionExpiry?.toString().split(' ')[0] ?? 'Unknown'}'
                  : 'Get access to all premium features',
            ),
            trailing: isPremium
                ? const Icon(Icons.check_circle, color: AppColors.success)
                : const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
              );
            },
          ),
          
          if (isPremium)
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Restore Purchases'),
              onTap: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                
                await subscriptionService.restorePurchases();
                
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Purchases restored')),
                );
              },
            ),
          
          // Notifications section
          _buildSectionHeader(context, 'Notifications'),
          
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive reminders and updates'),
            value: true, // Replace with actual value from settings
            onChanged: (value) {
              // Update notification settings
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.spa),
            title: const Text('Breathing Exercise Reminders'),
            subtitle: const Text('Configure breathing exercise notifications'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BreathingNotificationSettingsScreen()),
              );
            },
          ),
          
          // App section
          _buildSectionHeader(context, 'App'),
          
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            onTap: () async {
              const url = 'https://llakterian.github.io/quitvaping/terms.html';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
          ),
          
          // Sign out
          const Divider(),
          
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              // Show confirmation dialog
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sign Out'),
                  content: const Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
              
              if (confirmed == true) {
                await userService.logout();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}