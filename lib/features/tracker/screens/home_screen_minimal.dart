import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/user_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../checkins/screens/checkin_screen.dart';
import '../../ai_chat/screens/ai_chat_screen.dart';
import '../../breathing/screens/breathing_screen.dart';
import '../../panic_mode/screens/panic_mode_screen.dart';
import '../../nrt_tracker/screens/nrt_tracker_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/health_milestone_card.dart';
import '../widgets/savings_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/premium_insights_card.dart';
import '../widgets/mcp_motivation_card.dart';
import '../widgets/mcp_health_insights_card.dart';

class HomeScreenMinimal extends StatefulWidget {
  const HomeScreenMinimal({Key? key}) : super(key: key);

  @override
  State<HomeScreenMinimal> createState() => _HomeScreenMinimalState();
}

class _HomeScreenMinimalState extends State<HomeScreenMinimal> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      const _HomeTab(),
      const CheckinScreen(),
      const AIChatScreen(),
      const BreathingScreen(),
      const NRTTrackerScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserService>(
          builder: (context, userService, child) {
            return Text(
              'Hello, ${userService.currentUser?.name ?? 'User'}!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Check-in',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI Coach',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Breathe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'NRT',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PanicModeScreen()),
          );
        },
        backgroundColor: AppColors.error,
        child: const Icon(Icons.emergency, color: Colors.white),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        final user = userService.currentUser;
        final progress = userService.progress;
        
        if (user == null) {
          return const Center(child: Text('No user data available'));
        }

        if (user.quitDate == null) {
          return _buildSetQuitDatePrompt(context, userService);
        }

        return RefreshIndicator(
          onRefresh: () async {
            // Refresh data if needed
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Web Demo Banner
                _buildWebDemoBanner(context),
                
                // Progress Tracker
                ProgressTracker(user: user, progress: progress ?? userService.createDefaultProgress(user)),
                const SizedBox(height: 16),
                
                // Quick Actions
                const QuickActions(),
                const SizedBox(height: 16),
                
                // MCP-Powered Motivation Card
                const MCPMotivationCard(),
                const SizedBox(height: 16),
                
                // MCP-Powered Health Insights
                const MCPHealthInsightsCard(),
                const SizedBox(height: 16),
                
                // Health Milestone Card
                HealthMilestoneCard(user: user, progress: progress ?? userService.createDefaultProgress(user)),
                const SizedBox(height: 16),
                
                // Savings Card
                SavingsCard(user: user, progress: progress ?? userService.createDefaultProgress(user)),
                const SizedBox(height: 16),
                
                // Recent Activity
                _buildRecentActivity(context),
                const SizedBox(height: 16),
                
                // Motivational Quote
                _buildMotivationalQuote(context),
                
                // Premium Insights Card
                const SizedBox(height: 16),
                PremiumInsightsCard(user: user, progress: progress ?? userService.createDefaultProgress(user)),
                  
                const SizedBox(height: 100), // Space for FAB
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSetQuitDatePrompt(BuildContext context, UserService userService) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Set Your Quit Date',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'To start tracking your progress, you need to set a quit date.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              
              if (date != null) {
                await userService.setQuitDate(date);
              }
            },
            child: const Text('Set Quit Date'),
          ),
        ],
      ),
    );
  }

  Widget _buildWebDemoBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent,
            AppColors.accent.withGreen(255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 77), // 0.3 * 255 ≈ 77
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 51), // 0.2 * 255 ≈ 51
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.web,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🚭 QuitVaping Web Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MCP-powered AI health companion - try all features!',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 230), // 0.9 * 255 ≈ 230
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Live Demo',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Recent Activity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Sample activities - in a real app, this would come from data
            _buildActivityItem(
              icon: Icons.check_circle,
              title: 'Daily check-in completed',
              subtitle: '2 hours ago',
              color: AppColors.success,
            ),
            const SizedBox(height: 8),
            _buildActivityItem(
              icon: Icons.self_improvement,
              title: 'Breathing exercise completed',
              subtitle: '4 hours ago',
              color: AppColors.secondary,
            ),
            const SizedBox(height: 8),
            _buildActivityItem(
              icon: Icons.medication,
              title: 'NRT usage logged',
              subtitle: '6 hours ago',
              color: AppColors.accent,
            ),
            const SizedBox(height: 8),
            _buildActivityItem(
              icon: Icons.chat,
              title: 'AI Coach conversation',
              subtitle: 'Yesterday',
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 26), // 0.1 * 255 ≈ 26
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMotivationalQuote(BuildContext context) {
    final quotes = [
      'Every moment you don\'t vape is a victory worth celebrating.',
      'Your lungs are thanking you with every breath.',
      'You\'re stronger than your cravings.',
      'Each day vape-free is an investment in your future.',
      'You\'ve got this! One day at a time.',
    ];
    
    final quote = quotes[DateTime.now().day % quotes.length];
    
    return Card(
      color: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.format_quote,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              quote,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppColors.primary,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}