import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/user_service.dart';
import '../../../data/models/user_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // Form controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'Male';
  int _dailyFrequency = 10;
  int _nicotineStrength = 20;
  double _yearsVaping = 2.0;
  String _deviceType = 'Pod System';
  List<String> _selectedTriggers = [];
  List<String> _selectedMotivations = [];
  DateTime? _quitDate;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentPage + 1) / 6,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(),
                  _buildPersonalInfoPage(),
                  _buildVapingHistoryPage(),
                  _buildTriggersPage(),
                  _buildMotivationPage(),
                  _buildQuitDatePage(),
                ],
              ),
            ),
            
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Back'),
                    )
                  else
                    const SizedBox(),
                  
                  ElevatedButton(
                    onPressed: _currentPage == 5 ? _completeOnboarding : () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(_currentPage == 5 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: 32),
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
            'Your AI-powered journey to quit vaping starts here. Let\'s create a personalized plan just for you.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.track_changes, color: AppColors.primary),
                      SizedBox(width: 12),
                      Expanded(child: Text('Track your progress in real-time')),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.psychology, color: AppColors.primary),
                      SizedBox(width: 12),
                      Expanded(child: Text('AI-powered personalized support')),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.self_improvement, color: AppColors.primary),
                      SizedBox(width: 12),
                      Expanded(child: Text('Guided breathing exercises')),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.emergency, color: AppColors.primary),
                      SizedBox(width: 12),
                      Expanded(child: Text('Panic mode for intense cravings')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about yourself',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'This helps us personalize your experience',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              hintText: 'Enter your first name',
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              hintText: 'Enter your age',
            ),
          ),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender',
            ),
            items: ['Male', 'Female', 'Other', 'Prefer not to say']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVapingHistoryPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your vaping history',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Help us understand your current habits',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          Text('How many times do you vape per day?'),
          Slider(
            value: _dailyFrequency.toDouble(),
            min: 1,
            max: 50,
            divisions: 49,
            label: '$_dailyFrequency times',
            onChanged: (value) {
              setState(() {
                _dailyFrequency = value.round();
              });
            },
          ),
          const SizedBox(height: 16),
          
          Text('Nicotine strength (mg)'),
          Slider(
            value: _nicotineStrength.toDouble(),
            min: 0,
            max: 50,
            divisions: 50,
            label: '${_nicotineStrength}mg',
            onChanged: (value) {
              setState(() {
                _nicotineStrength = value.round();
              });
            },
          ),
          const SizedBox(height: 16),
          
          Text('How long have you been vaping?'),
          Slider(
            value: _yearsVaping,
            min: 0.1,
            max: 20,
            divisions: 199,
            label: '${_yearsVaping.toStringAsFixed(1)} years',
            onChanged: (value) {
              setState(() {
                _yearsVaping = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            value: _deviceType,
            decoration: const InputDecoration(
              labelText: 'Device Type',
            ),
            items: ['Pod System', 'Mod', 'Disposable', 'Pen Style', 'Other']
                .map((device) => DropdownMenuItem(
                      value: device,
                      child: Text(device),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _deviceType = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTriggersPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What triggers your vaping?',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Select all that apply',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView(
              children: AppConstants.commonTriggers.entries.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.key.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: category.value.map((trigger) {
                        final isSelected = _selectedTriggers.contains(trigger);
                        return FilterChip(
                          label: Text(trigger),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedTriggers.add(trigger);
                              } else {
                                _selectedTriggers.remove(trigger);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why do you want to quit?',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Your motivations will help keep you on track',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView(
              children: AppConstants.motivationCategories.map((motivation) {
                final isSelected = _selectedMotivations.contains(motivation);
                return CheckboxListTile(
                  title: Text(motivation),
                  value: isSelected,
                  onChanged: (selected) {
                    setState(() {
                      if (selected == true) {
                        _selectedMotivations.add(motivation);
                      } else {
                        _selectedMotivations.remove(motivation);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuitDatePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When do you want to quit?',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'You can always change this later',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.today, color: AppColors.primary),
                    title: const Text('I\'ve already quit'),
                    subtitle: const Text('Track from when you last vaped'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 1)),
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _quitDate = date;
                        });
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.schedule, color: AppColors.primary),
                    title: const Text('Set a quit date'),
                    subtitle: const Text('Choose a future date to quit'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 7)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          _quitDate = date;
                        });
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.flash_on, color: AppColors.primary),
                    title: const Text('Quit right now'),
                    subtitle: const Text('Start your journey immediately'),
                    onTap: () {
                      setState(() {
                        _quitDate = DateTime.now();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          
          if (_quitDate != null) ...[
            const SizedBox(height: 16),
            Card(
              color: AppColors.primaryLight.withValues(alpha: 26),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Quit date set: ${_quitDate!.day}/${_quitDate!.month}/${_quitDate!.year}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final userService = Provider.of<UserService>(context, listen: false);
    
    final vapingHistory = VapingHistoryModel(
      dailyFrequency: _dailyFrequency,
      nicotineStrength: _nicotineStrength,
      yearsVaping: _yearsVaping,
      deviceType: _deviceType,
      commonTriggers: _selectedTriggers,
      previousQuitAttempts: [],
    );

    await userService.createUser(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _selectedGender,
      vapingHistory: vapingHistory,
      motivationFactors: _selectedMotivations,
      quitDate: _quitDate,
    );
  }
}