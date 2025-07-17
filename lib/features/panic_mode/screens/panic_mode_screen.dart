import 'package:flutter/material.dart';
import 'dart:async';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/constants/app_constants.dart';
import '../../breathing/screens/breathing_screen.dart';

class PanicModeScreen extends StatefulWidget {
  const PanicModeScreen({Key? key}) : super(key: key);

  @override
  State<PanicModeScreen> createState() => _PanicModeScreenState();
}

class _PanicModeScreenState extends State<PanicModeScreen> {
  int _selectedTechniqueIndex = 0;
  bool _isActive = false;
  int _remainingSeconds = 0;
  Timer? _timer;
  int _currentStepIndex = 0;

  List<String> get _currentSteps => 
      AppConstants.panicModeDistractions[_selectedTechniqueIndex]['steps'] as List<String>;
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panic Mode'),
        backgroundColor: AppColors.error,
      ),
      body: _isActive
          ? _buildActiveTechnique()
          : _buildTechniqueSelection(),
    );
  }

  Widget _buildTechniqueSelection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFFFF3F3), // Light red background
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(
                  Icons.emergency,
                  color: AppColors.error,
                  size: 48,
                ),
                SizedBox(height: 16),
                Text(
                  'Hang in there! Cravings typically last 3-5 minutes.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Choose a distraction technique below to help you get through this moment.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Text(
          'Distraction Techniques',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        
        ...AppConstants.panicModeDistractions.asMap().entries.map((entry) {
          final index = entry.key;
          final technique = entry.value;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedTechniqueIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _selectedTechniqueIndex,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              _selectedTechniqueIndex = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            technique['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${technique['duration']}s',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48),
                      child: Text(
                        technique['description'] as String,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        
        const SizedBox(height: 16),
        
        ElevatedButton(
          onPressed: _startTechnique,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Start Technique'),
        ),
        
        const SizedBox(height: 16),
        
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BreathingScreen()),
            );
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Try Breathing Exercise Instead'),
        ),
      ],
    );
  }

  Widget _buildActiveTechnique() {
    final technique = AppConstants.panicModeDistractions[_selectedTechniqueIndex];
    final steps = technique['steps'] as List<String>;
    final currentStep = steps[_currentStepIndex];
    
    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: 1 - (_remainingSeconds / (technique['duration'] as int)),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  technique['title'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Step ${_currentStepIndex + 1} of ${steps.length}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentStep,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Text(
                  'Time remaining: $_remainingSeconds seconds',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _stopTechnique,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Stop'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(_currentStepIndex < steps.length - 1 ? 'Next Step' : 'Finish'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startTechnique() {
    final technique = AppConstants.panicModeDistractions[_selectedTechniqueIndex];
    final duration = technique['duration'] as int;
    
    setState(() {
      _isActive = true;
      _remainingSeconds = duration;
      _currentStepIndex = 0;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _completeTechnique();
        }
      });
    });
  }

  void _nextStep() {
    final steps = AppConstants.panicModeDistractions[_selectedTechniqueIndex]['steps'] as List<String>;
    
    if (_currentStepIndex < steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      _completeTechnique();
    }
  }

  void _stopTechnique() {
    _timer?.cancel();
    
    setState(() {
      _isActive = false;
    });
  }

  void _completeTechnique() {
    _timer?.cancel();
    
    // Show completion dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Great Job!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'You\'ve successfully completed the distraction technique.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'How are you feeling now?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeelingButton(context, '😌', 'Better'),
                _buildFeelingButton(context, '😐', 'Same'),
                _buildFeelingButton(context, '😣', 'Worse'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isActive = false;
              });
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingButton(BuildContext context, String emoji, String label) {
    return InkWell(
      onTap: () {
        // TODO: Record the feeling response
        Navigator.pop(context);
        setState(() {
          _isActive = false;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}