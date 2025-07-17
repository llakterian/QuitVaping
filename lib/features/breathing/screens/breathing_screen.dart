import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/constants/app_constants.dart';
import '../widgets/breathing_animation.dart';
import '../../../data/services/subscription_service.dart';
import '../../subscription/widgets/premium_feature_overlay.dart';
import '../../subscription/screens/subscription_screen.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({Key? key}) : super(key: key);

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  String _selectedExercise = 'box';
  int _duration = 2; // minutes
  bool _isExercising = false;
  int _remainingSeconds = 0;
  int _currentStepIndex = 0;
  Timer? _exerciseTimer;
  Timer? _stepTimer;
  
  List<Map<String, dynamic>> get _currentSteps => 
      AppConstants.breathingExercises[_selectedExercise]?['steps'] as List<Map<String, dynamic>>;
  
  Map<String, dynamic> get _currentStep => _currentSteps[_currentStepIndex];
  
  @override
  void dispose() {
    _exerciseTimer?.cancel();
    _stepTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercises'),
      ),
      body: _isExercising ? _buildExerciseView() : _buildSelectionView(),
    );
  }

  Widget _buildSelectionView() {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final isPremium = subscriptionService.isPremium;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose an Exercise',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                ...AppConstants.breathingExercises.entries.map((entry) {
                  final key = entry.key;
                  final exercise = entry.value;
                  final isSelected = _selectedExercise == key;
                  final isPremiumExercise = exercise['isPremium'] as bool;
                  
                  return Stack(
                    children: [
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Text(exercise['name'] as String),
                            if (isPremiumExercise)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'PREMIUM',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Text(exercise['description'] as String),
                        value: key,
                        groupValue: _selectedExercise,
                        activeColor: AppColors.primary,
                        onChanged: (isPremiumExercise && !isPremium) 
                            ? null  // Disable selection for premium exercises if user is not premium
                            : (value) {
                                setState(() {
                                  _selectedExercise = value!;
                                });
                              },
                      ),
                      if (isPremiumExercise && !isPremium)
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SubscriptionScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Duration',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                Wrap(
                  spacing: 8,
                  children: [1, 2, 3, 5, 10].map((minutes) {
                    final isSelected = _duration == minutes;
                    
                    return ChoiceChip(
                      label: Text('$minutes min'),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _duration = minutes;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Benefits',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                
                Text(
                  AppConstants.breathingExercises[_selectedExercise]?['benefits'] as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: 16),
                
                const Text(
                  'Regular breathing exercises can help reduce stress, anxiety, and cravings. They also improve focus and promote relaxation.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: _startExercise,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Start Exercise'),
        ),
      ],
    );
  }

  Widget _buildExerciseView() {
    final action = _currentStep['action'] as String;
    final seconds = _currentStep['seconds'] as int;
    final instruction = _currentStep['instruction'] as String;
    
    Color actionColor;
    switch (action) {
      case 'inhale':
        actionColor = AppColors.breatheIn;
        break;
      case 'hold':
        actionColor = AppColors.breatheHold;
        break;
      case 'exhale':
        actionColor = AppColors.breatheOut;
        break;
      default:
        actionColor = AppColors.primary;
    }
    
    return Column(
      children: [
        // Timer bar
        LinearProgressIndicator(
          value: _remainingSeconds / (_duration * 60),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatTime(_remainingSeconds),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              
              // Breathing animation
              BreathingAnimation(
                action: action,
                duration: seconds,
              ),
              
              const SizedBox(height: 32),
              
              Text(
                action.toUpperCase(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: actionColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                instruction,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _stopExercise,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Stop Exercise'),
          ),
        ),
      ],
    );
  }

  void _startExercise() {
    final subscriptionService = Provider.of<SubscriptionService>(context, listen: false);
    final isPremium = subscriptionService.isPremium;
    final isPremiumExercise = AppConstants.breathingExercises[_selectedExercise]?['isPremium'] as bool;
    
    // Check if user is trying to use a premium exercise without subscription
    if (isPremiumExercise && !isPremium) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
      );
      return;
    }
    
    setState(() {
      _isExercising = true;
      _remainingSeconds = _duration * 60;
      _currentStepIndex = 0;
    });
    
    // Start the overall exercise timer
    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopExercise();
        }
      });
    });
    
    // Start the step timer
    _startStepTimer();
  }

  void _startStepTimer() {
    final seconds = _currentStep['seconds'] as int;
    
    _stepTimer = Timer(Duration(seconds: seconds), () {
      if (mounted) {
        setState(() {
          _currentStepIndex = (_currentStepIndex + 1) % _currentSteps.length;
        });
        
        // Start the next step timer if still exercising
        if (_isExercising) {
          _startStepTimer();
        }
      }
    });
  }

  void _stopExercise() {
    _exerciseTimer?.cancel();
    _stepTimer?.cancel();
    
    setState(() {
      _isExercising = false;
    });
    
    // Show completion dialog if exercise wasn't manually stopped
    if (_remainingSeconds <= 0 && mounted) {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exercise Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Great job! You completed a $_duration-minute ${AppConstants.breathingExercises[_selectedExercise]?['name']} exercise.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'How do you feel now?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}