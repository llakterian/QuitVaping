import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/theme/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Help'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need immediate support?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you\'re struggling with cravings or need someone to talk to, these resources can help:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildHelpResource(
              context,
              'Quitline',
              '1-800-QUIT-NOW (1-800-784-8669)',
              Icons.phone,
              () => _launchPhone('18007848669'),
            ),
            _buildHelpResource(
              context,
              'Crisis Text Line',
              'Text HOME to 741741',
              Icons.message,
              () => _launchSMS('741741', 'HOME'),
            ),
            _buildHelpResource(
              context,
              'Online Support Community',
              'Join our community forum',
              Icons.people,
              () => _launchURL('https://llakterian.github.io/quitvaping/community'),
            ),
            _buildHelpResource(
              context,
              'Find Local Resources',
              'Support groups near you',
              Icons.location_on,
              () => _showLocalResourcesDialog(context),
            ),
            
            const SizedBox(height: 32),
            
            // Emergency resources
            _buildEmergencyCard(context),
            
            const SizedBox(height: 32),
            
            // Coping strategies
            const Text(
              'Coping Strategies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildCopingStrategy(
              'The 4Ds Strategy',
              [
                'Delay - Wait out the craving, it typically passes in 3-5 minutes',
                'Deep breathe - Take slow, deep breaths to reduce stress',
                'Drink water - Stay hydrated and keep your mouth busy',
                'Distract - Find something else to focus on until the craving passes'
              ],
              Icons.psychology,
            ),
            
            _buildCopingStrategy(
              'H.A.L.T. Method',
              [
                'Hungry - Eat a healthy snack if you\'re hungry',
                'Angry - Find healthy ways to express and process anger',
                'Lonely - Reach out to supportive friends or family',
                'Tired - Get adequate rest and take breaks when needed'
              ],
              Icons.health_and_safety,
            ),
            
            _buildCopingStrategy(
              'Physical Activities',
              [
                'Go for a short walk or jog',
                'Do 10 push-ups or jumping jacks',
                'Stretch or do yoga poses',
                'Dance to your favorite song'
              ],
              Icons.directions_run,
            ),
            
            const SizedBox(height: 32),
            
            // Motivational quote
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    size: 32,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Every time you resist a craving, you're one step closer to being free.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Remember: Every craving passes, whether you give in to it or not.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Contact support
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _launchEmail('llakterian@gmail.com', 'QuitVaping App Support'),
                icon: const Icon(Icons.email),
                label: const Text('Contact Support'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Built by
            Center(
              child: Text(
                'Built by Llakterian',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHelpResource(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
  
  Widget _buildEmergencyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emergency, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                'Emergency Resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'If you\'re experiencing a mental health crisis or having thoughts of self-harm:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _launchPhone('988'),
                  icon: const Icon(Icons.phone),
                  label: const Text('988 Suicide & Crisis Lifeline'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Available 24/7 for free and confidential support.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCopingStrategy(String title, List<String> steps, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: Text(step)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
  
  void _showLocalResourcesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find Local Resources'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To find support groups and resources near you:'),
            SizedBox(height: 16),
            Text('• Check with your healthcare provider'),
            Text('• Contact your local health department'),
            Text('• Search for "smoking cessation" or "vaping cessation" programs in your area'),
            Text('• Ask at community centers or hospitals about support groups'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () => _launchURL('https://smokefree.gov/tools-tips/get-extra-help'),
            child: const Text('Find Online'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
  
  Future<void> _launchSMS(String phoneNumber, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }
  }
  
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
  
  Future<void> _launchEmail(String email, String subject) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}