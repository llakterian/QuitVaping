import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/services/user_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/health_milestone_card.dart';
import '../widgets/health_tip_card.dart';
import '../../../features/breathing/services/breathing_health_metrics_service.dart';
import '../../../features/breathing/screens/breathing_health_impact_screen.dart';

class HealthInfoScreen extends StatefulWidget {
  const HealthInfoScreen({Key? key}) : super(key: key);

  @override
  State<HealthInfoScreen> createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Information'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Milestones'),
            Tab(text: 'Benefits'),
            Tab(text: 'Resources'),
            Tab(text: 'Breathing Impact'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMilestonesTab(),
          _buildBenefitsTab(),
          _buildResourcesTab(),
          _buildBreathingImpactTab(),
        ],
      ),
    );
  }
  
  Widget _buildMilestonesTab() {
    final userService = Provider.of<UserService>(context);
    final user = userService.currentUser;
    final quitDate = user?.quitDate;
    
    if (quitDate == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No quit date set',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Set your quit date in the profile section to track your health milestones',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                
                if (date != null && mounted) {
                  await userService.setQuitDate(date);
                }
              },
              child: const Text('Set Quit Date'),
            ),
          ],
        ),
      );
    }
    
    final now = DateTime.now();
    final daysSinceQuit = now.difference(quitDate).inDays;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress overview
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '$daysSinceQuit days',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quit date: ${DateFormat('MMMM d, yyyy').format(quitDate)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your body is healing! Here are the health improvements you\'ve already achieved:',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Milestones
          const Text(
            'Health Milestones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          HealthMilestoneCard(
            title: '20 Minutes',
            description: 'Your heart rate and blood pressure drop to normal levels.',
            isAchieved: daysSinceQuit >= 1,
            icon: Icons.favorite,
          ),
          
          HealthMilestoneCard(
            title: '8 Hours',
            description: 'Nicotine and carbon monoxide levels in your blood reduce by half.',
            isAchieved: daysSinceQuit >= 1,
            icon: Icons.bloodtype,
          ),
          
          HealthMilestoneCard(
            title: '24 Hours',
            description: 'Nicotine is eliminated from your body. Your lungs start to clear out mucus and debris.',
            isAchieved: daysSinceQuit >= 1,
            icon: Icons.air,
          ),
          
          HealthMilestoneCard(
            title: '48 Hours',
            description: 'Your sense of taste and smell begin to improve as nerve endings start to regrow.',
            isAchieved: daysSinceQuit >= 2,
            icon: Icons.restaurant,
          ),
          
          HealthMilestoneCard(
            title: '72 Hours',
            description: 'Your bronchial tubes relax, making breathing easier and increasing energy levels.',
            isAchieved: daysSinceQuit >= 3,
            icon: Icons.directions_run,
          ),
          
          HealthMilestoneCard(
            title: '1 Week',
            description: 'Your body has eliminated most nicotine metabolites. Success rates for quitting increase if you make it this far.',
            isAchieved: daysSinceQuit >= 7,
            icon: Icons.check_circle,
          ),
          
          HealthMilestoneCard(
            title: '2 Weeks',
            description: 'Circulation improves and lung function increases by up to 30%.',
            isAchieved: daysSinceQuit >= 14,
            icon: Icons.trending_up,
          ),
          
          HealthMilestoneCard(
            title: '1 Month',
            description: 'Many vaping-related symptoms like coughing, sinus congestion, and shortness of breath decrease.',
            isAchieved: daysSinceQuit >= 30,
            icon: Icons.healing,
          ),
          
          HealthMilestoneCard(
            title: '3 Months',
            description: 'Lung function continues to improve. Circulation is significantly better.',
            isAchieved: daysSinceQuit >= 90,
            icon: Icons.air_outlined,
          ),
          
          HealthMilestoneCard(
            title: '6 Months',
            description: 'Stress levels are similar to those of non-vapers. Respiratory issues like coughing and shortness of breath continue to improve.',
            isAchieved: daysSinceQuit >= 180,
            icon: Icons.spa,
          ),
          
          HealthMilestoneCard(
            title: '1 Year',
            description: 'Your risk of heart disease drops to half that of a vaper.',
            isAchieved: daysSinceQuit >= 365,
            icon: Icons.favorite_border,
          ),
          
          const SizedBox(height: 16),
          
          // Disclaimer
          Card(
            elevation: 0,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Health milestones are based on general research and may vary from person to person.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBenefitsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Benefits of Quitting',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildBenefitCard(
            'Physical Health',
            [
              'Improved lung function and reduced respiratory symptoms',
              'Lower risk of heart disease and stroke',
              'Better immune system function',
              'Improved circulation and oxygen delivery',
              'Reduced risk of cancer',
              'Better dental health and reduced gum disease',
            ],
            Icons.favorite,
            Colors.red.shade100,
          ),
          
          _buildBenefitCard(
            'Mental Health',
            [
              'Reduced anxiety and stress levels over time',
              'Improved mood and mental clarity',
              'Better sleep quality',
              'Increased self-esteem and confidence',
              'Reduced dependency and addiction behaviors',
              'Greater sense of control over your life',
            ],
            Icons.psychology,
            Colors.blue.shade100,
          ),
          
          _buildBenefitCard(
            'Lifestyle Improvements',
            [
              'More energy for daily activities',
              'Better physical fitness and endurance',
              'Improved sense of taste and smell',
              'Financial savings from not buying vaping products',
              'No more worrying about when you can vape next',
              'Freedom from addiction and dependency',
            ],
            Icons.emoji_emotions,
            Colors.green.shade100,
          ),
          
          _buildBenefitCard(
            'Social Benefits',
            [
              'No more stepping outside or finding vaping areas',
              'Being a positive role model for others',
              'No vape smell on clothes, hair, or breath',
              'Improved relationships with non-vapers',
              'Contributing to a healthier environment',
              'Being part of the solution to the vaping epidemic',
            ],
            Icons.people,
            Colors.purple.shade100,
          ),
          
          const SizedBox(height: 16),
          
          // Scientific evidence
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.science, color: AppColors.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'Scientific Evidence',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Research has shown that quitting vaping leads to significant health improvements. A 2020 study published in the Journal of the American Medical Association found that former vapers had improved lung function and reduced inflammation markers after just 30 days of abstinence.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Another study by the American Heart Association demonstrated that ex-vapers showed improved cardiovascular health metrics within 1-3 months of quitting.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Helpful Resources',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Tips
          HealthTipCard(
            title: 'Identify Your Triggers',
            content: 'Understanding what makes you want to vape is the first step to overcoming cravings. Common triggers include stress, social situations, after meals, or while drinking alcohol.',
            actionText: 'Track Triggers',
            onAction: () {
              // Navigate to trigger tracking
            },
          ),
          
          HealthTipCard(
            title: 'Use the 4 Ds Strategy',
            content: 'When a craving hits: Delay (wait it out), Deep breathe (use breathing exercises), Drink water, and Distract yourself with another activity.',
            actionText: 'Try Breathing Exercise',
            onAction: () {
              // Navigate to breathing exercises
            },
          ),
          
          HealthTipCard(
            title: 'Consider Nicotine Replacement Therapy',
            content: 'NRT products like patches, gum, or lozenges can help manage withdrawal symptoms and double your chances of quitting successfully.',
            actionText: 'Open NRT Tracker',
            onAction: () {
              // Navigate to NRT tracker
            },
          ),
          
          HealthTipCard(
            title: 'Stay Physically Active',
            content: 'Exercise can reduce cravings, manage stress, and help prevent weight gain that sometimes occurs when quitting.',
            actionText: 'Learn More',
            onAction: () {
              // Show more information
            },
          ),
          
          HealthTipCard(
            title: 'Join a Support Group',
            content: 'Connecting with others who are also quitting can provide motivation, tips, and accountability.',
            actionText: 'Find Support',
            onAction: () {
              // Show support resources
            },
          ),
          
          const SizedBox(height: 24),
          
          // External resources
          const Text(
            'External Resources',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildResourceLink(
            'Smokefree.gov',
            'Free, science-based resources to help you quit',
            'https://smokefree.gov',
            Icons.language,
          ),
          
          _buildResourceLink(
            'Truth Initiative',
            'Information and support for quitting vaping',
            'https://truthinitiative.org/research-resources/quitting-smoking-vaping/quitting-e-cigarettes',
            Icons.language,
          ),
          
          _buildResourceLink(
            'This is Quitting',
            'Text-based support program for teens and young adults',
            'https://truthinitiative.org/thisisquitting',
            Icons.sms,
          ),
          
          _buildResourceLink(
            'CDC - Vaping Information',
            'Facts and resources about e-cigarettes',
            'https://www.cdc.gov/tobacco/basic_information/e-cigarettes/index.htm',
            Icons.language,
          ),
          
          _buildResourceLink(
            'National Quitline',
            'Call 1-800-QUIT-NOW for free coaching',
            'tel:1-800-784-8669',
            Icons.phone,
          ),
        ],
      ),
    );
  }
  
  Widget _buildBreathingImpactTab() {
    final breathingHealthMetricsService = Provider.of<BreathingHealthMetricsService>(context, listen: false);
    
    return FutureBuilder<Map<String, dynamic>?>(
      future: breathingHealthMetricsService.getTopHealthImpact(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final topImpact = snapshot.data;
        final totalMinutes = breathingHealthMetricsService.getTotalBreathingMinutes();
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Breathing Practice Impact',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              FutureBuilder<int>(
                future: totalMinutes,
                builder: (context, minutesSnapshot) {
                  final minutes = minutesSnapshot.data ?? 0;
                  
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.spa, color: AppColors.primary),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Your Breathing Practice',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Practice Time:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '$minutes minutes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (topImpact != null) ...[
                            const Text(
                              'Top Health Impact:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  topImpact['icon'] as IconData,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${topImpact['impact']}% ${topImpact['metric']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 16),
                          const Text(
                            'Regular breathing exercises help reduce stress, improve focus, and manage cravings during your quit journey.',
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BreathingHealthImpactScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('View Detailed Impact'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Breathing & Quitting Connection',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.psychology, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'How Breathing Helps Your Quit Journey',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildBreathingBenefitItem(
                        'Reduces Cravings',
                        'Deep breathing activates your parasympathetic nervous system, reducing the intensity of cravings.',
                        Icons.trending_down,
                      ),
                      _buildBreathingBenefitItem(
                        'Manages Stress',
                        'Controlled breathing lowers cortisol levels, helping you manage stress without turning to vaping.',
                        Icons.spa,
                      ),
                      _buildBreathingBenefitItem(
                        'Improves Lung Function',
                        'Regular breathing exercises help restore lung capacity affected by vaping.',
                        Icons.air,
                      ),
                      _buildBreathingBenefitItem(
                        'Enhances Self-Control',
                        'Practicing breathing techniques strengthens your ability to resist impulses.',
                        Icons.psychology_alt,
                      ),
                      _buildBreathingBenefitItem(
                        'Boosts Mood',
                        'Proper breathing increases oxygen to your brain, improving your mood and reducing irritability during withdrawal.',
                        Icons.sentiment_very_satisfied,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.science, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Text(
                            'Scientific Evidence',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'A 2021 study in the Journal of Addiction Medicine found that participants who practiced breathing exercises during nicotine withdrawal experienced 40% fewer cravings and reported lower anxiety levels.',
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Research from the American Lung Association shows that breathing exercises can help restore lung function affected by vaping, with measurable improvements in just 2-4 weeks of regular practice.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildBreathingBenefitItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(width: 12),
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
  
  Widget _buildBenefitCard(String title, List<String> benefits, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.black54),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...benefits.map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: Text(benefit)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResourceLink(String title, String description, String url, IconData icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary),
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
                      ),
                    ),
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
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}