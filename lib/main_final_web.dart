import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'shared/theme/app_theme.dart';
import 'shared/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  await Hive.initFlutter();
  await Hive.openBox('quitvaping_data');
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuitVapingService(),
      child: const QuitVapingApp(),
    ),
  );
}

class QuitVapingApp extends StatelessWidget {
  const QuitVapingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const QuitVapingHomeScreen(),
    );
  }
}

class QuitVapingService extends ChangeNotifier {
  final Box _box = Hive.box('quitvaping_data');
  
  String get userName => _box.get('userName', defaultValue: 'User');
  DateTime? get quitDate => _box.get('quitDate') != null 
    ? DateTime.parse(_box.get('quitDate')) 
    : null;
  
  int get dailyCheckIns => _box.get('dailyCheckIns', defaultValue: 0);
  
  void setUserName(String name) {
    _box.put('userName', name);
    notifyListeners();
  }
  
  void setQuitDate(DateTime date) {
    _box.put('quitDate', date.toIso8601String());
    notifyListeners();
  }
  
  void addCheckIn() {
    _box.put('dailyCheckIns', dailyCheckIns + 1);
    notifyListeners();
  }
  
  Duration get timeSinceQuit {
    if (quitDate == null) return Duration.zero;
    return DateTime.now().difference(quitDate!);
  }
  
  String get motivationalMessage {
    final messages = [
      'Every moment you don\'t vape is a victory! 🎉',
      'Your lungs are thanking you right now! 🫁',
      'You\'re stronger than your cravings! 💪',
      'Each day vape-free is an investment in your future! 📈',
      'You\'ve got this! One breath at a time! 🌬️',
    ];
    return messages[DateTime.now().day % messages.length];
  }
}

class QuitVapingHomeScreen extends StatefulWidget {
  const QuitVapingHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuitVapingHomeScreen> createState() => _QuitVapingHomeScreenState();
}

class _QuitVapingHomeScreenState extends State<QuitVapingHomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<QuitVapingService>(
          builder: (context, service, child) {
            return Text(
              'Hello, ${service.userName}! 🚭',
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
      ),
      body: Consumer<QuitVapingService>(
        builder: (context, service, child) {
          if (service.quitDate == null) {
            return _buildSetupScreen(service);
          }
          return _buildMainScreen(service);
        },
      ),
      floatingActionButton: Consumer<QuitVapingService>(
        builder: (context, service, child) {
          if (service.quitDate == null) return const SizedBox.shrink();
          
          return LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = MediaQuery.of(context).size.width < 400;
              
              if (isSmall) {
                return FloatingActionButton(
                  onPressed: () {
                    service.addCheckIn();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Great job! Check-in recorded! 🎉'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.check_circle),
                );
              } else {
                return FloatingActionButton.extended(
                  onPressed: () {
                    service.addCheckIn();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Great job! Check-in recorded! 🎉'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Daily Check-in'),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildSetupScreen(QuitVapingService service) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final padding = isWide ? 48.0 : 24.0;
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          // Welcome Banner
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withBlue(255)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 77),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.favorite, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                const Text(
                  '🚭 QuitVaping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your Personal Health Companion',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 230),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const Icon(
            Icons.favorite,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to QuitVaping',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Your AI-powered journey to quit vaping starts here. Let\'s set up your personal profile.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter your first name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (_nameController.text.isNotEmpty) {
                    service.setUserName(_nameController.text);
                    
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      helpText: 'When did you quit vaping?',
                    );
                    
                    if (date != null) {
                      service.setQuitDate(date);
                    }
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Set Quit Date'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainScreen(QuitVapingService service) {
    final timeSinceQuit = service.timeSinceQuit;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 800;
        final padding = isWide ? 32.0 : (isTablet ? 24.0 : 16.0);
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 800 : double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          // Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.trending_up,
                          color: AppColors.success,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vape-Free Progress',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Since ${DateFormat('MMM dd, yyyy').format(service.quitDate!)}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 400) {
                        // Stack vertically on very small screens
                        return Column(
                          children: [
                            _buildStatItem(
                              'Days',
                              '${timeSinceQuit.inDays}',
                              Icons.calendar_today,
                              AppColors.primary,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatItem(
                                    'Hours',
                                    '${timeSinceQuit.inHours % 24}',
                                    Icons.access_time,
                                    AppColors.accent,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatItem(
                                    'Check-ins',
                                    '${service.dailyCheckIns}',
                                    Icons.check_circle,
                                    AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Row layout for larger screens
                        return Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                'Days',
                                '${timeSinceQuit.inDays}',
                                Icons.calendar_today,
                                AppColors.primary,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Hours',
                                '${timeSinceQuit.inHours % 24}',
                                Icons.access_time,
                                AppColors.accent,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Check-ins',
                                '${service.dailyCheckIns}',
                                Icons.check_circle,
                                AppColors.success,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Motivational Card
          Card(
            color: AppColors.primary.withValues(alpha: 26),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.psychology,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Daily Motivation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.motivationalMessage,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Health Benefits Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: AppColors.error),
                      const SizedBox(width: 8),
                      Text(
                        'Health Recovery Timeline',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildHealthBenefit(
                    '20 minutes',
                    'Heart rate and blood pressure drop',
                    timeSinceQuit.inMinutes >= 20,
                  ),
                  _buildHealthBenefit(
                    '12 hours',
                    'Carbon monoxide levels normalize',
                    timeSinceQuit.inHours >= 12,
                  ),
                  _buildHealthBenefit(
                    '2 weeks',
                    'Circulation improves significantly',
                    timeSinceQuit.inDays >= 14,
                  ),
                  _buildHealthBenefit(
                    '1 month',
                    'Lung function begins to improve',
                    timeSinceQuit.inDays >= 30,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Smart Features Card
          Card(
            color: AppColors.accent.withValues(alpha: 26),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.psychology, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(
                        'Smart Features',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildFeatureItem('🤖 AI-Powered Insights', 'Personalized motivation and tips'),
                  _buildFeatureItem('📊 Progress Analytics', 'Track your health improvements'),
                  _buildFeatureItem('🎯 Goal Setting', 'Set and achieve milestones'),
                  _buildFeatureItem('💪 Craving Support', 'Tools to overcome urges'),
                  _buildFeatureItem('🏆 Achievement System', 'Celebrate your victories'),
                  _buildFeatureItem('📱 Cross-Platform', 'Works on all devices'),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Community & Support Card
          Card(
            color: AppColors.secondary.withValues(alpha: 26),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'Support & Community',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildFeatureItem('👥 Community Support', 'Connect with others on the same journey'),
                  _buildFeatureItem('📚 Educational Content', 'Learn about vaping cessation'),
                  _buildFeatureItem('🩺 Health Tracking', 'Monitor your recovery progress'),
                  _buildFeatureItem('📞 Crisis Support', 'Emergency help when you need it'),
                  _buildFeatureItem('🎉 Success Stories', 'Get inspired by others'),
                ],
              ),
            ),
          ),
          
                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthBenefit(String time, String benefit, bool achieved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            achieved ? Icons.check_circle : Icons.radio_button_unchecked,
            color: achieved ? AppColors.success : AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: achieved ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
                Text(
                  benefit,
                  style: TextStyle(
                    color: achieved ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.split(' ')[0], // Get the emoji
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.substring(title.indexOf(' ') + 1), // Get text after emoji
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}