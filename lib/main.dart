import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/subscription_service.dart';
import 'screens/premium_upgrade_screen.dart';

void main() {
  runApp(const QuitVapingApp());
}

class QuitVapingApp extends StatefulWidget {
  const QuitVapingApp({Key? key}) : super(key: key);

  @override
  State<QuitVapingApp> createState() => _QuitVapingAppState();
}

class _QuitVapingAppState extends State<QuitVapingApp> {
  bool _isDarkMode = false;
  final SubscriptionService _subscriptionService = SubscriptionService();

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _initializeSubscriptionService();
  }

  Future<void> _initializeSubscriptionService() async {
    await _subscriptionService.initialize();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      theme: _isDarkMode ? _darkTheme : _lightTheme,
      home: HomeScreen(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }

  static final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF4A90E2),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    cardColor: Colors.white,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4A90E2),
      secondary: Color(0xFF7ED321),
      surface: Colors.white,
      background: Color(0xFFF8F9FA),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF4A90E2),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    cardColor: const Color(0xFF2D2D2D),
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4A90E2),
      secondary: Color(0xFF7ED321),
      surface: Color(0xFF2D2D2D),
      background: Color(0xFF1A1A1A),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardScreen(),
      const BreathingExercisesScreen(),
      const ProgressScreen(),
      const NRTTrackerScreen(),
      SettingsScreen(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Breathing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'NRT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _daysWithoutVaping = 0;
  int _breathingSessions = 0;
  String _motivationalQuote = "Every breath is a step towards freedom";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _daysWithoutVaping = prefs.getInt('daysWithoutVaping') ?? 0;
      _breathingSessions = prefs.getInt('breathingSessions') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuitVaping'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.favorite, color: Colors.white, size: 40),
                      const SizedBox(height: 10),
                      const Text(
                        'Welcome to QuitVaping',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _motivationalQuote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Days Clean',
                      _daysWithoutVaping.toString(),
                      Icons.calendar_today,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Sessions',
                      _breathingSessions.toString(),
                      Icons.air,
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              _buildActionCard(
                'Start Breathing Exercise',
                'Calm your mind and reduce cravings',
                Icons.air,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BreathingExercisesScreen()),
                ),
              ),
              const SizedBox(height: 12),
              
              _buildActionCard(
                'Track NRT Usage',
                'Log your nicotine replacement therapy',
                Icons.medical_services,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NRTTrackerScreen()),
                ),
              ),
              const SizedBox(height: 12),
              
              _buildActionCard(
                'View Progress',
                'See your journey and achievements',
                Icons.trending_up,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
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
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class BreathingExercisesScreen extends StatefulWidget {
  const BreathingExercisesScreen({Key? key}) : super(key: key);

  @override
  State<BreathingExercisesScreen> createState() => _BreathingExercisesScreenState();
}

class _BreathingExercisesScreenState extends State<BreathingExercisesScreen> {
  final List<BreathingTechnique> _techniques = [
    BreathingTechnique(
      name: '4-7-8 Technique',
      description: 'Inhale for 4, hold for 7, exhale for 8 seconds',
      inhaleTime: 4,
      holdTime: 7,
      exhaleTime: 8,
      isPremium: false,
    ),
    BreathingTechnique(
      name: 'Box Breathing',
      description: 'Equal timing for all phases (4-4-4-4)',
      inhaleTime: 4,
      holdTime: 4,
      exhaleTime: 4,
      holdAfterExhale: 4,
      isPremium: false,
    ),
    BreathingTechnique(
      name: 'Triangle Breathing',
      description: 'Simple 4-4-4 pattern for beginners',
      inhaleTime: 4,
      holdTime: 4,
      exhaleTime: 4,
      isPremium: false,
    ),
    BreathingTechnique(
      name: 'Deep Relaxation',
      description: 'Extended breathing for deep relaxation',
      inhaleTime: 6,
      holdTime: 6,
      exhaleTime: 8,
      isPremium: true,
    ),
    BreathingTechnique(
      name: 'Quick Calm',
      description: 'Fast technique for immediate relief',
      inhaleTime: 3,
      holdTime: 3,
      exhaleTime: 6,
      isPremium: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercises'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _techniques.length,
          itemBuilder: (context, index) {
            final technique = _techniques[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: technique.isPremium 
                        ? Colors.amber.withOpacity(0.2)
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.air,
                    color: technique.isPremium 
                        ? Colors.amber[700]
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Row(
                  children: [
                    Text(technique.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (technique.isPremium) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                subtitle: Text(technique.description),
                trailing: const Icon(Icons.play_arrow),
                onTap: () {
                  if (technique.isPremium && !_isPremiumUser()) {
                    _showPremiumDialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreathingExercisePlayer(technique: technique),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isPremiumUser() {
    return SubscriptionService().isPremiumUser;
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Feature'),
        content: const Text('This breathing technique is available for premium users. Upgrade to unlock all techniques and features.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PremiumUpgradeScreen(highlightFeature: 'breathing'),
                ),
              );
            },
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }
}

class BreathingTechnique {
  final String name;
  final String description;
  final int inhaleTime;
  final int holdTime;
  final int exhaleTime;
  final int holdAfterExhale;
  final bool isPremium;

  BreathingTechnique({
    required this.name,
    required this.description,
    required this.inhaleTime,
    required this.holdTime,
    required this.exhaleTime,
    this.holdAfterExhale = 0,
    this.isPremium = false,
  });
}

class BreathingExercisePlayer extends StatefulWidget {
  final BreathingTechnique technique;

  const BreathingExercisePlayer({Key? key, required this.technique}) : super(key: key);

  @override
  State<BreathingExercisePlayer> createState() => _BreathingExercisePlayerState();
}

class _BreathingExercisePlayerState extends State<BreathingExercisePlayer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isPlaying = false;
  int _currentPhase = 0; // 0: inhale, 1: hold, 2: exhale, 3: hold
  int _cycleCount = 0;
  Timer? _phaseTimer;
  String _currentInstruction = "Tap to start";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _currentInstruction = "Ready to start ${widget.technique.name}";
  }

  @override
  void dispose() {
    _phaseTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startExercise() {
    setState(() {
      _isPlaying = true;
      _cycleCount = 0;
      _currentPhase = 0;
      _currentInstruction = "Breathe In";
    });
    _nextPhase();
  }

  void _stopExercise() {
    setState(() {
      _isPlaying = false;
      _currentInstruction = "Tap to start";
    });
    _phaseTimer?.cancel();
    _animationController.stop();
    _animationController.reset();
  }

  void _nextPhase() {
    if (!_isPlaying) return;

    int duration;
    String instruction;

    switch (_currentPhase) {
      case 0: // Inhale
        duration = widget.technique.inhaleTime;
        instruction = "Breathe In";
        _animationController.forward(from: 0.5);
        break;
      case 1: // Hold after inhale
        duration = widget.technique.holdTime;
        instruction = "Hold";
        break;
      case 2: // Exhale
        duration = widget.technique.exhaleTime;
        instruction = "Breathe Out";
        _animationController.reverse(from: 1.0);
        break;
      case 3: // Hold after exhale
        duration = widget.technique.holdAfterExhale;
        instruction = "Hold";
        break;
      default:
        duration = 4;
        instruction = "Breathe";
    }

    setState(() {
      _currentInstruction = instruction;
    });

    _phaseTimer = Timer(Duration(seconds: duration), () {
      if (_isPlaying) {
        _currentPhase = (_currentPhase + 1) % 4;
        if (_currentPhase == 0) {
          _cycleCount++;
        }
        _nextPhase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.technique.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Current instruction
                  Text(
                    _currentInstruction,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Breathing animation circle
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: 150 + (100 * _animation.value),
                        height: 150 + (100 * _animation.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.air,
                          color: Theme.of(context).colorScheme.primary,
                          size: 40,
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Cycle counter
                  Text(
                    'Cycles: $_cycleCount',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _isPlaying ? null : _startExercise,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: _isPlaying ? _stopExercise : null,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Technique description
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About ${widget.technique.name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(widget.technique.description),
                          const SizedBox(height: 12),
                          Text(
                            'Pattern: ${widget.technique.inhaleTime}s inhale, ${widget.technique.holdTime}s hold, ${widget.technique.exhaleTime}s exhale' +
                            (widget.technique.holdAfterExhale > 0 ? ', ${widget.technique.holdAfterExhale}s hold' : ''),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _daysWithoutVaping = 0;
  int _breathingSessionsCompleted = 0;
  int _nrtUsages = 0;
  DateTime? _quitDate;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _daysWithoutVaping = prefs.getInt('daysWithoutVaping') ?? 0;
      _breathingSessionsCompleted = prefs.getInt('breathingSessions') ?? 0;
      _nrtUsages = prefs.getInt('nrtUsages') ?? 0;
      String? quitDateString = prefs.getString('quitDate');
      if (quitDateString != null) {
        _quitDate = DateTime.parse(quitDateString);
        _daysWithoutVaping = DateTime.now().difference(_quitDate!).inDays;
      }
    });
  }

  Future<void> _incrementDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _daysWithoutVaping++;
    });
    await prefs.setInt('daysWithoutVaping', _daysWithoutVaping);
  }

  Future<void> _setQuitDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _quitDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('quitDate', picked.toIso8601String());
      setState(() {
        _quitDate = picked;
        _daysWithoutVaping = DateTime.now().difference(picked).inDays;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Progress Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.white, size: 40),
                      const SizedBox(height: 10),
                      Text(
                        '$_daysWithoutVaping',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Days Without Vaping',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _incrementDays,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text('Add Day'),
                          ),
                          ElevatedButton(
                            onPressed: _setQuitDate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text('Set Quit Date'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Statistics Grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Breathing Sessions',
                      _breathingSessionsCompleted.toString(),
                      Icons.air,
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'NRT Uses',
                      _nrtUsages.toString(),
                      Icons.medical_services,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Milestones
              const Text(
                'Milestones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              _buildMilestoneCard('First Day', 'You took the first step!', 1, _daysWithoutVaping >= 1),
              _buildMilestoneCard('One Week', 'A full week smoke-free!', 7, _daysWithoutVaping >= 7),
              _buildMilestoneCard('One Month', 'Amazing progress!', 30, _daysWithoutVaping >= 30),
              _buildMilestoneCard('Three Months', 'You\'re doing great!', 90, _daysWithoutVaping >= 90),
              _buildMilestoneCard('One Year', 'Incredible achievement!', 365, _daysWithoutVaping >= 365),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
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
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneCard(String title, String description, int days, bool achieved) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: achieved 
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            achieved ? Icons.check_circle : Icons.radio_button_unchecked,
            color: achieved 
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: achieved ? null : Colors.grey,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: achieved ? null : Colors.grey,
          ),
        ),
        trailing: Text(
          '$days days',
          style: TextStyle(
            color: achieved 
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class NRTTrackerScreen extends StatefulWidget {
  const NRTTrackerScreen({Key? key}) : super(key: key);

  @override
  State<NRTTrackerScreen> createState() => _NRTTrackerScreenState();
}

class _NRTTrackerScreenState extends State<NRTTrackerScreen> {
  final List<NRTProduct> _nrtProducts = [
    NRTProduct(name: 'Nicotine Gum', icon: Icons.circle, color: Colors.green),
    NRTProduct(name: 'Nicotine Patch', icon: Icons.square, color: Colors.blue),
    NRTProduct(name: 'Nicotine Lozenge', icon: Icons.hexagon, color: Colors.orange),
    NRTProduct(name: 'Nicotine Inhaler', icon: Icons.air, color: Colors.purple),
  ];

  List<NRTUsage> _usageHistory = [];
  int _totalUsages = 0;

  @override
  void initState() {
    super.initState();
    _loadNRTData();
  }

  Future<void> _loadNRTData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalUsages = prefs.getInt('nrtUsages') ?? 0;
    });
  }

  Future<void> _addNRTUsage(NRTProduct product) async {
    final prefs = await SharedPreferences.getInstance();
    final usage = NRTUsage(
      product: product,
      timestamp: DateTime.now(),
    );
    
    setState(() {
      _usageHistory.insert(0, usage);
      _totalUsages++;
    });
    
    await prefs.setInt('nrtUsages', _totalUsages);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} usage logged'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildPremiumFeatureCard(String title, String description, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.amber[700]),
        ),
        title: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PRO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showNRTPremiumDialog(String feature) {
    String title = '';
    String description = '';
    
    switch (feature) {
      case 'analytics':
        title = 'Advanced Analytics';
        description = 'Get detailed insights into your NRT usage patterns, effectiveness tracking, and personalized recommendations for reducing dosage.';
        break;
      case 'reminders':
        title = 'Smart Reminders';
        description = 'Receive intelligent reminders based on your usage patterns, with customizable schedules and gradual reduction suggestions.';
        break;
      case 'dosage':
        title = 'Dosage Tracking';
        description = 'Track exact dosages, monitor your reduction progress, and get professional recommendations for tapering off NRT safely.';
        break;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PremiumUpgradeScreen(highlightFeature: 'nrt'),
                ),
              );
            },
            child: const Text('Try NRT Premium'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NRT Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          children: [
            // Stats Card
            Container(
              margin: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$_totalUsages',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Text('Total Uses'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${_usageHistory.where((u) => u.timestamp.day == DateTime.now().day).length}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const Text('Today'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // NRT Products Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log NRT Usage',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _nrtProducts.length,
                    itemBuilder: (context, index) {
                      final product = _nrtProducts[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _addNRTUsage(product),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  product.icon,
                                  size: 40,
                                  color: product.color,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Premium Features Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Premium NRT Features',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Premium Feature Cards
                  _buildPremiumFeatureCard(
                    'Advanced Analytics',
                    'Detailed usage patterns and effectiveness tracking',
                    Icons.analytics,
                    () => _showNRTPremiumDialog('analytics'),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildPremiumFeatureCard(
                    'Smart Reminders',
                    'Personalized NRT reminders based on your usage patterns',
                    Icons.notifications_active,
                    () => _showNRTPremiumDialog('reminders'),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildPremiumFeatureCard(
                    'Dosage Tracking',
                    'Track exact dosages and get reduction recommendations',
                    Icons.medication,
                    () => _showNRTPremiumDialog('dosage'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Usage History
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Usage',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _usageHistory.isEmpty
                          ? const Center(
                              child: Text(
                                'No NRT usage logged yet.\nTap on a product above to log usage.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _usageHistory.length,
                              itemBuilder: (context, index) {
                                final usage = _usageHistory[index];
                                return Card(
                                  elevation: 1,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    leading: Icon(
                                      usage.product.icon,
                                      color: usage.product.color,
                                    ),
                                    title: Text(usage.product.name),
                                    subtitle: Text(
                                      '${usage.timestamp.hour.toString().padLeft(2, '0')}:${usage.timestamp.minute.toString().padLeft(2, '0')}',
                                    ),
                                    trailing: Text(
                                      usage.timestamp.day == DateTime.now().day
                                          ? 'Today'
                                          : '${usage.timestamp.day}/${usage.timestamp.month}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NRTProduct {
  final String name;
  final IconData icon;
  final Color color;

  NRTProduct({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class NRTUsage {
  final NRTProduct product;
  final DateTime timestamp;

  NRTUsage({
    required this.product,
    required this.timestamp,
  });
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const SettingsScreen({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSettingsCard(
              context,
              'Profile',
              'Manage your personal information',
              Icons.person,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              ),
            ),
            _buildSettingsCard(
              context,
              'Notifications',
              'Configure reminders and alerts',
              Icons.notifications,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              ),
            ),
            _buildSettingsCard(
              context,
              'Theme',
              'Customize app appearance',
              Icons.color_lens,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeScreen(
                    toggleTheme: toggleTheme,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ),
            ),
            _buildSettingsCard(
              context,
              'Premium',
              'Unlock all features',
              Icons.star,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PremiumScreen()),
              ),
              isPremium: true,
            ),
            _buildSettingsCard(
              context,
              'About',
              'App information and credits',
              Icons.info,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isPremium = false,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPremium 
                ? Colors.amber.withOpacity(0.2)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isPremium 
                ? Colors.amber[700]
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            if (isPremium) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  DateTime? _quitDate;
  String _motivation = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('userName') ?? '';
      _ageController.text = prefs.getString('userAge') ?? '';
      _motivation = prefs.getString('userMotivation') ?? '';
      String? quitDateString = prefs.getString('quitDate');
      if (quitDateString != null) {
        _quitDate = DateTime.parse(quitDateString);
      }
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userAge', _ageController.text);
    await prefs.setString('userMotivation', _motivation);
    if (_quitDate != null) {
      await prefs.setString('quitDate', _quitDate!.toIso8601String());
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Quit Date'),
                        subtitle: Text(_quitDate?.toString().split(' ')[0] ?? 'Not set'),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _quitDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _quitDate = picked;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onChanged: (value) => _motivation = value,
                        decoration: InputDecoration(
                          labelText: 'Your Motivation',
                          hintText: 'Why do you want to quit vaping?',
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        controller: TextEditingController(text: _motivation),
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
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _breathingReminders = true;
  bool _motivationalMessages = true;
  bool _milestoneAlerts = true;
  bool _nrtReminders = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _breathingReminders = prefs.getBool('breathingReminders') ?? true;
      _motivationalMessages = prefs.getBool('motivationalMessages') ?? true;
      _milestoneAlerts = prefs.getBool('milestoneAlerts') ?? true;
      _nrtReminders = prefs.getBool('nrtReminders') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Breathing Reminders'),
                    subtitle: const Text('Get reminded to do breathing exercises'),
                    value: _breathingReminders,
                    onChanged: (value) {
                      setState(() {
                        _breathingReminders = value;
                      });
                      _saveSetting('breathingReminders', value);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Motivational Messages'),
                    subtitle: const Text('Receive daily motivation'),
                    value: _motivationalMessages,
                    onChanged: (value) {
                      setState(() {
                        _motivationalMessages = value;
                      });
                      _saveSetting('motivationalMessages', value);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Milestone Alerts'),
                    subtitle: const Text('Get notified when you reach milestones'),
                    value: _milestoneAlerts,
                    onChanged: (value) {
                      setState(() {
                        _milestoneAlerts = value;
                      });
                      _saveSetting('milestoneAlerts', value);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('NRT Reminders'),
                    subtitle: const Text('Reminders for NRT usage'),
                    value: _nrtReminders,
                    onChanged: (value) {
                      setState(() {
                        _nrtReminders = value;
                      });
                      _saveSetting('nrtReminders', value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ThemeScreen({Key? key, required this.toggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Use dark theme for better night viewing'),
                    value: isDarkMode,
                    onChanged: (value) => toggleTheme(),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Color Scheme'),
                    subtitle: const Text('Calming blue and green theme'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Theme Preview',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Primary Color',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Secondary Color',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.orange],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 40),
                      const SizedBox(height: 10),
                      const Text(
                        'QuitVaping Premium',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Unlock all features and get the most out of your quit journey',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              _buildFeatureCard(
                'Advanced Breathing Techniques',
                'Access to 10+ specialized breathing exercises',
                Icons.air,
              ),
              _buildFeatureCard(
                'Detailed Analytics',
                'In-depth insights and progress tracking',
                Icons.analytics,
              ),
              _buildFeatureCard(
                'Custom Themes',
                'Personalize your app with premium themes',
                Icons.palette,
              ),
              _buildFeatureCard(
                'Advanced NRT Tracking',
                'Detailed NRT analytics and scheduling',
                Icons.medical_services,
              ),
              _buildFeatureCard(
                'Export Data',
                'Export your progress data and reports',
                Icons.download,
              ),
              _buildFeatureCard(
                'Ad-Free Experience',
                'Enjoy the app without any advertisements',
                Icons.block,
              ),
              
              const SizedBox(height: 20),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Premium Pricing',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '\$4.99',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Monthly'),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '\$29.99',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Yearly'),
                              const Text(
                                'Save 50%',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Premium upgrade coming soon!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Upgrade to Premium',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  }

  Widget _buildFeatureCard(String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.amber[700]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: const Icon(Icons.star, color: Colors.amber),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'QuitVaping',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'QuitVaping helps you break free from vaping addiction through scientifically-backed breathing exercises, progress tracking, and NRT support.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        'Features',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.air),
                      title: Text('Breathing Exercises'),
                      subtitle: Text('Multiple techniques for craving management'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.trending_up),
                      title: Text('Progress Tracking'),
                      subtitle: Text('Monitor your quit journey'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.medical_services),
                      title: Text('NRT Tracker'),
                      subtitle: Text('Track nicotine replacement therapy'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events),
                      title: Text('Milestones'),
                      subtitle: Text('Celebrate your achievements'),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        'Credits',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      title: Text('Images'),
                      subtitle: Text('Photos provided by Pexels contributors'),
                    ),
                    ListTile(
                      title: const Text('View Image Credits'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImageCreditsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              const Text(
                '© 2025 QuitVaping. All rights reserved.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCreditsScreen extends StatelessWidget {
  const ImageCreditsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Credits'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Image Sources',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'All images used in this app are provided by Pexels under the Pexels License, which allows free use for personal and commercial purposes.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    _buildCreditItem('Meditation Image', 'Photo by Mikhail Nilov'),
                    _buildCreditItem('Health Concept', 'Photo by Polina Zimmerman'),
                    _buildCreditItem('Exercise Image', 'Photo by RDNE Stock project'),
                    _buildCreditItem('Nature Image', 'Photo by Nataliya Vaitkevich'),
                    _buildCreditItem('Wellness Image', 'Photo by Any Lane'),
                    const SizedBox(height: 16),
                    const Text(
                      'Visit pexels.com for more information about the Pexels License.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditItem(String title, String credit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(credit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}