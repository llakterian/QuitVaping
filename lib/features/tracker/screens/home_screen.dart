import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/user_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../checkins/screens/checkin_screen.dart';
import '../../ai_chat/screens/ai_chat_screen.dart';
import '../../breathing/screens/breathing_screen.dart';
import '../../panic_mode/screens/panic_mode_screen.dart';
import '../../nrt_tracker/screens/nrt_tracker_screen.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/health_milestone_card.dart';
import '../widgets/savings_card.dart';
import '../widgets/quick_actions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            return Text('Hello, ${userService.currentUser?.name ?? 'User'}!');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
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

        if (!user.hasQuitDate) {
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
                // Progress Tracker
                ProgressTracker(user: user, progress: progress),
                const SizedBox(height: 16),
                
                // Quick Actions
                const QuickActions(),
                const SizedBox(height: 16),
                
                // Health Milestone Card
                HealthMilestoneCard(user: user, progress: progress),
                const SizedBox(height: 16),
                
                // Savings Card
                SavingsCard(user: user, progress: progress),
                const SizedBox(height: 16),
                
                // Recent Activity
                _buildRecentActivity(context),
                const SizedBox(height: 16),
                
                // Motivational Quote
                _buildMotivationalQuote(context),
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
            color: color.withOpacity(0.1),
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
      color: AppColors.primary.withOpacity(0.1),
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