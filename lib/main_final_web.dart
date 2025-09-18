import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

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
      create: (_) {
        final service = QuitVapingService();
        service.initializeApiData(); // Initialize Postman API data
        return service;
      },
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

// Postman API Service - Powers the app with real API data
class PostmanApiService {
  static const String baseUrl = 'https://api.quotable.io'; // Free quotes API
  static const String healthApiUrl = 'https://api.adviceslip.com'; // Free advice API
  static const String factsApiUrl = 'https://uselessfacts.jsph.pl'; // Free facts API
  
  // Fetch motivational quotes via Postman-tested endpoints
  static Future<String> fetchMotivationalQuote() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/random?tags=motivational|inspirational&maxLength=100'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'QuitVaping-PostmanPowered/1.0',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return '${data['content']} - ${data['author']} 💪';
      }
    } catch (e) {
      print('Postman API Error: $e');
    }
    
    // Fallback motivational messages
    final fallbackMessages = [
      'Every moment you don\'t vape is a victory! 🎉',
      'Your lungs are thanking you right now! 🫁',
      'You\'re stronger than your cravings! 💪',
      'Each day vape-free is an investment in your future! 📈',
      'You\'ve got this! One breath at a time! 🌬️',
    ];
    return fallbackMessages[Random().nextInt(fallbackMessages.length)];
  }
  
  // Fetch health tips via Postman-tested endpoints
  static Future<String> fetchHealthTip() async {
    try {
      final response = await http.get(
        Uri.parse('$healthApiUrl/advice'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'QuitVaping-PostmanPowered/1.0',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return '💡 ${data['slip']['advice']}';
      }
    } catch (e) {
      print('Postman Health API Error: $e');
    }
    
    return '💡 Stay hydrated and take deep breaths when you feel cravings.';
  }
  
  // Fetch interesting health facts via Postman-tested endpoints
  static Future<String> fetchHealthFact() async {
    try {
      final response = await http.get(
        Uri.parse('$factsApiUrl/api/today?language=en'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'QuitVaping-PostmanPowered/1.0',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return '🧠 Did you know? ${data['text']}';
      }
    } catch (e) {
      print('Postman Facts API Error: $e');
    }
    
    return '🧠 Did you know? Your sense of taste and smell improve within 48 hours of quitting vaping.';
  }
  
  // Fetch community support messages (simulated via multiple API calls)
  static Future<List<String>> fetchCommunityMessages() async {
    final List<String> messages = [];
    
    try {
      // Fetch multiple quotes to simulate community messages
      for (int i = 0; i < 3; i++) {
        final response = await http.get(
          Uri.parse('$baseUrl/random?tags=success|wisdom&maxLength=80'),
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'QuitVaping-PostmanPowered/1.0',
          },
        );
        
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          messages.add('👥 Community: "${data['content']}" - ${data['author']}');
        }
        
        // Small delay between requests
        await Future.delayed(const Duration(milliseconds: 100));
      }
    } catch (e) {
      print('Postman Community API Error: $e');
    }
    
    if (messages.isEmpty) {
      messages.addAll([
        '👥 Community: "You are stronger than you think!" - Sarah M.',
        '👥 Community: "Day 30 and feeling amazing!" - Mike R.',
        '👥 Community: "The cravings do get easier!" - Emma L.',
      ]);
    }
    
    return messages;
  }
}

class QuitVapingService extends ChangeNotifier {
  final Box _box = Hive.box('quitvaping_data');
  String _currentMotivationalMessage = 'Loading inspiration...';
  String _currentHealthTip = 'Loading health tip...';
  String _currentHealthFact = 'Loading interesting fact...';
  List<String> _communityMessages = ['Loading community messages...'];
  bool _isLoadingApiData = false;
  
  String get userName => _box.get('userName', defaultValue: 'User');
  DateTime? get quitDate => _box.get('quitDate') != null 
    ? DateTime.parse(_box.get('quitDate')) 
    : null;
  
  int get dailyCheckIns => _box.get('dailyCheckIns', defaultValue: 0);
  String get motivationalMessage => _currentMotivationalMessage;
  String get healthTip => _currentHealthTip;
  String get healthFact => _currentHealthFact;
  List<String> get communityMessages => _communityMessages;
  bool get isLoadingApiData => _isLoadingApiData;
  
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
    // Refresh API data on check-in
    refreshApiData();
    notifyListeners();
  }
  
  Duration get timeSinceQuit {
    if (quitDate == null) return Duration.zero;
    return DateTime.now().difference(quitDate!);
  }
  
  // Refresh all API data using Postman-tested endpoints
  Future<void> refreshApiData() async {
    _isLoadingApiData = true;
    notifyListeners();
    
    try {
      // Fetch all data concurrently using Postman APIs
      final results = await Future.wait([
        PostmanApiService.fetchMotivationalQuote(),
        PostmanApiService.fetchHealthTip(),
        PostmanApiService.fetchHealthFact(),
        PostmanApiService.fetchCommunityMessages(),
      ]);
      
      _currentMotivationalMessage = results[0] as String;
      _currentHealthTip = results[1] as String;
      _currentHealthFact = results[2] as String;
      _communityMessages = results[3] as List<String>;
      
    } catch (e) {
      print('Error refreshing API data: $e');
    } finally {
      _isLoadingApiData = false;
      notifyListeners();
    }
  }
  
  // Initialize API data when service starts
  void initializeApiData() {
    refreshApiData();
  }
}

class QuitVapingHomeScreen extends StatefulWidget {
  const QuitVapingHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuitVapingHomeScreen> createState() => _QuitVapingHomeScreenState();
}

class _QuitVapingHomeScreenState extends State<QuitVapingHomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProgressScreen(),
    const PostmanIntegrationScreen(),
    const SupportScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<QuitVapingService>(
      builder: (context, service, child) {
        if (service.quitDate == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Welcome to QuitVaping'),
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
            ),
            body: _buildSetupScreen(service),
          );
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Hello, ${service.userName}! 🚭',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
          ),
          body: _screens[_currentIndex],
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Desktop/tablet navigation rail
                return Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, Icons.dashboard, 'Dashboard'),
                      _buildNavItem(1, Icons.trending_up, 'Progress'),
                      _buildNavItem(2, Icons.api, 'Postman'),
                      _buildNavItem(3, Icons.support, 'Support'),
                      _buildNavItem(4, Icons.settings, 'Settings'),
                    ],
                  ),
                );
              } else {
                // Mobile bottom navigation
                return BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.textSecondary,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.trending_up),
                      label: 'Progress',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.api),
                      label: 'Postman',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.support),
                      label: 'Support',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                );
              }
            },
          ),
          floatingActionButton: _currentIndex == 0 ? _buildFloatingActionButton(service) : null,
        );
      },
    );
  }
  
  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFloatingActionButton(QuitVapingService service) {
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
                  color: AppColors.primary.withOpacity(0.3),
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
                    color: Colors.white.withOpacity(0.9),
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
            color: AppColors.primary.withOpacity(0.1),
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
            color: AppColors.accent.withOpacity(0.1),
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
            color: AppColors.secondary.withOpacity(0.1),
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

// Dashboard Screen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuitVapingService>(
      builder: (context, service, child) {
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
                      // Quick Stats Row
                      _buildQuickStats(timeSinceQuit, service),
                      const SizedBox(height: 16),
                      
                      // Motivational Card
                      _buildMotivationalCard(service),
                      const SizedBox(height: 16),
                      
                      // Health Benefits
                      _buildHealthBenefits(timeSinceQuit),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildQuickStats(Duration timeSinceQuit, QuitVapingService service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 400) {
                  return Column(
                    children: [
                      _buildStatItem('Days', '${timeSinceQuit.inDays}', Icons.calendar_today, AppColors.primary),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildStatItem('Hours', '${timeSinceQuit.inHours % 24}', Icons.access_time, AppColors.accent)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildStatItem('Check-ins', '${service.dailyCheckIns}', Icons.check_circle, AppColors.success)),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(child: _buildStatItem('Days', '${timeSinceQuit.inDays}', Icons.calendar_today, AppColors.primary)),
                      Expanded(child: _buildStatItem('Hours', '${timeSinceQuit.inHours % 24}', Icons.access_time, AppColors.accent)),
                      Expanded(child: _buildStatItem('Check-ins', '${service.dailyCheckIns}', Icons.check_circle, AppColors.success)),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMotivationalCard(QuitVapingService service) {
    return Card(
      color: AppColors.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.psychology, color: AppColors.primary, size: 32),
                Row(
                  children: [
                    const Icon(Icons.api, color: AppColors.primary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Powered by Postman',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Daily Motivation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            service.isLoadingApiData
                ? const CircularProgressIndicator()
                : Text(
                    service.motivationalMessage,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: service.isLoadingApiData ? null : () => service.refreshApiData(),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHealthBenefits(Duration timeSinceQuit) {
    return Card(
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
                  'Health Recovery',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHealthBenefit('20 minutes', 'Heart rate normalizes', timeSinceQuit.inMinutes >= 20),
            _buildHealthBenefit('12 hours', 'Carbon monoxide clears', timeSinceQuit.inHours >= 12),
            _buildHealthBenefit('2 weeks', 'Circulation improves', timeSinceQuit.inDays >= 14),
            _buildHealthBenefit('1 month', 'Lung function improves', timeSinceQuit.inDays >= 30),
          ],
        ),
      ),
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
}

// Progress Screen
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuitVapingService>(
      builder: (context, service, child) {
        final timeSinceQuit = service.timeSinceQuit;
        
        return LayoutBuilder(
          builder: (context, constraints) {
            final padding = constraints.maxWidth > 600 ? 32.0 : 16.0;
            
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth > 800 ? 800 : double.infinity),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detailed Progress Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detailed Progress',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildProgressItem('Days Vape-Free', '${timeSinceQuit.inDays}', AppColors.primary),
                              _buildProgressItem('Hours', '${timeSinceQuit.inHours}', AppColors.accent),
                              _buildProgressItem('Minutes', '${timeSinceQuit.inMinutes}', AppColors.success),
                              _buildProgressItem('Total Check-ins', '${service.dailyCheckIns}', AppColors.secondary),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Milestones Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Milestones',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildMilestone('First Day', 'Complete your first day vape-free', timeSinceQuit.inDays >= 1),
                              _buildMilestone('One Week', 'Seven days of freedom', timeSinceQuit.inDays >= 7),
                              _buildMilestone('Two Weeks', 'Circulation improvement begins', timeSinceQuit.inDays >= 14),
                              _buildMilestone('One Month', 'Major health improvements', timeSinceQuit.inDays >= 30),
                              _buildMilestone('Three Months', 'Significant lung recovery', timeSinceQuit.inDays >= 90),
                              _buildMilestone('One Year', 'Heart disease risk halved', timeSinceQuit.inDays >= 365),
                            ],
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
      },
    );
  }
  
  Widget _buildProgressItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMilestone(String title, String description, bool achieved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            achieved ? Icons.check_circle : Icons.radio_button_unchecked,
            color: achieved ? AppColors.success : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: achieved ? AppColors.success : AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: achieved ? AppColors.textPrimary : AppColors.textSecondary,
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
}

// Support Screen
class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth > 600 ? 32.0 : 16.0;
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth > 800 ? 800 : double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emergency Support Card
                  Card(
                    color: AppColors.error.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(Icons.emergency, color: AppColors.error, size: 32),
                          const SizedBox(height: 12),
                          Text(
                            'Need Immediate Help?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.error,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'If you\'re experiencing a strong craving, try these techniques:',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => _showCravingHelp(context),
                            icon: const Icon(Icons.psychology),
                            label: const Text('Craving Support'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Support Resources
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Support Resources',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSupportItem(
                            Icons.people,
                            'Community Support',
                            'Connect with others on the same journey',
                            () => _showCommunitySupport(context),
                          ),
                          _buildSupportItem(
                            Icons.book,
                            'Educational Resources',
                            'Learn about vaping cessation and health',
                            () => _showEducationalContent(context),
                          ),
                          _buildSupportItem(
                            Icons.phone,
                            'Professional Help',
                            'Find healthcare providers and counselors',
                            () => _showProfessionalHelp(context),
                          ),
                          _buildSupportItem(
                            Icons.tips_and_updates,
                            'Daily Tips',
                            'Get personalized advice and strategies',
                            () => _showDailyTips(context),
                          ),
                        ],
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
  
  Widget _buildSupportItem(IconData icon, String title, String description, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
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
    );
  }
  
  void _showCravingHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Craving Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Try these techniques when you feel a craving:'),
            SizedBox(height: 16),
            Text('• Take 10 deep breaths'),
            Text('• Drink a glass of water'),
            Text('• Go for a short walk'),
            Text('• Call a friend or family member'),
            Text('• Remember why you quit'),
            Text('• Use a stress ball or fidget toy'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
  
  void _showCommunitySupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Community Support'),
        content: const Text('Connect with others who are also quitting vaping. Share your experiences, get encouragement, and support others on their journey.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showEducationalContent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Educational Resources'),
        content: const Text('Learn about the health benefits of quitting vaping, understand withdrawal symptoms, and discover effective strategies for staying vape-free.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showProfessionalHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Professional Help'),
        content: const Text('Consider speaking with healthcare providers, counselors, or calling a quitline for professional support in your journey to quit vaping.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showDailyTips(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daily Tips'),
        content: const Text('Get personalized daily tips and strategies based on your progress and preferences to help you stay motivated and vape-free.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuitVapingService>(
      builder: (context, service, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final padding = constraints.maxWidth > 600 ? 32.0 : 16.0;
            
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth > 800 ? 800 : double.infinity),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                Icons.person,
                                'Name',
                                service.userName,
                                () => _editName(context, service),
                              ),
                              _buildSettingItem(
                                Icons.calendar_today,
                                'Quit Date',
                                service.quitDate != null 
                                  ? DateFormat('MMM dd, yyyy').format(service.quitDate!)
                                  : 'Not set',
                                () => _editQuitDate(context, service),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // App Settings
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'App Settings',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                Icons.notifications,
                                'Notifications',
                                'Manage your notification preferences',
                                () => _showNotificationSettings(context),
                              ),
                              _buildSettingItem(
                                Icons.backup,
                                'Data & Backup',
                                'Manage your data and backups',
                                () => _showDataSettings(context),
                              ),
                              _buildSettingItem(
                                Icons.info,
                                'About',
                                'App version and information',
                                () => _showAbout(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Reset Data
                      Card(
                        color: AppColors.error.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reset Data',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.error,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('This will reset all your progress and data.'),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () => _resetData(context, service),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reset All Data'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
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
      },
    );
  }
  
  Widget _buildSettingItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
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
    );
  }
  
  void _editName(BuildContext context, QuitVapingService service) {
    final controller = TextEditingController(text: service.userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Your Name',
            hintText: 'Enter your name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                service.setUserName(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
  
  void _editQuitDate(BuildContext context, QuitVapingService service) async {
    final date = await showDatePicker(
      context: context,
      initialDate: service.quitDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      helpText: 'When did you quit vaping?',
    );
    
    if (date != null) {
      service.setQuitDate(date);
    }
  }
  
  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Settings'),
        content: const Text('Notification preferences will be available in future updates.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showDataSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data & Backup'),
        content: const Text('Data backup and sync features will be available in future updates.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About QuitVaping'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('QuitVaping - Your Personal Health Companion'),
            SizedBox(height: 8),
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('A comprehensive app to help you quit vaping and track your health recovery journey.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _resetData(BuildContext context, QuitVapingService service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data'),
        content: const Text('Are you sure you want to reset all your progress and data? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final box = Hive.box('quitvaping_data');
              box.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data has been reset'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            child: const Text('Reset', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

// Postman Integration Screen - Shows how Postman APIs power the app
class PostmanIntegrationScreen extends StatelessWidget {
  const PostmanIntegrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuitVapingService>(
      builder: (context, service, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final padding = constraints.maxWidth > 600 ? 32.0 : 16.0;
            
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth > 800 ? 800 : double.infinity),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Postman Header Card
                      Card(
                        color: Colors.orange.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.api, color: Colors.white, size: 24),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Powered by Postman APIs',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                        const Text(
                                          'Real-time data integration for QuitVaping',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: service.isLoadingApiData ? null : () => service.refreshApiData(),
                                icon: service.isLoadingApiData 
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.refresh),
                                label: Text(service.isLoadingApiData ? 'Refreshing...' : 'Refresh All APIs'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Live API Data Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Live Postman API Data',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildApiDataItem('💪 Motivation API', service.motivationalMessage, service.isLoadingApiData),
                              _buildApiDataItem('💡 Health Tip API', service.healthTip, service.isLoadingApiData),
                              _buildApiDataItem('🧠 Facts API', service.healthFact, service.isLoadingApiData),
                              const SizedBox(height: 8),
                              Text(
                                '👥 Community API Messages:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...service.communityMessages.map((message) => 
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // API Endpoints Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Postman-Tested API Endpoints',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildApiEndpoint(
                                'Quotes API',
                                'api.quotable.io/random',
                                'Motivational quotes for daily inspiration',
                                Icons.psychology,
                                Colors.blue,
                              ),
                              _buildApiEndpoint(
                                'Advice API',
                                'api.adviceslip.com/advice',
                                'Health tips and wellness guidance',
                                Icons.health_and_safety,
                                Colors.green,
                              ),
                              _buildApiEndpoint(
                                'Facts API',
                                'uselessfacts.jsph.pl/api/today',
                                'Interesting daily facts and trivia',
                                Icons.lightbulb,
                                Colors.amber,
                              ),
                            ],
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
      },
    );
  }
  
  Widget _buildApiEndpoint(String name, String endpoint, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  endpoint,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildApiDataItem(String label, String data, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          isLoading
              ? const LinearProgressIndicator()
              : Text(
                  data,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
        ],
      ),
    );
  }
}