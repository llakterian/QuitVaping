/// Application constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();
  
  // App information
  static const String appName = 'QuitVaping';
  static const String appVersion = '1.0.0';
  
  // Shared preferences keys
  static const String prefOnboardingCompleted = 'onboarding_completed';
  static const String prefUserData = 'user_data';
  static const String prefThemeMode = 'theme_mode';
  static const String prefSubscriptionStatus = 'subscription_status';
  
  // Default values
  static const int defaultBreathingDuration = 5; // minutes
  static const double defaultCigaretteCost = 0.50; // dollars per cigarette
  static const int defaultCigarettesPerDay = 20;
  
  // Trigger categories for cravings
  static const List<String> triggerCategories = [
    'Stress',
    'Social situation',
    'After a meal',
    'Boredom',
    'Habit/Routine',
    'Alcohol',
    'Coffee',
    'Emotional',
    'Other'
  ];
  
  // Common triggers by category
  static const Map<String, List<String>> commonTriggers = {
    'Stress': [
      'Work pressure',
      'Financial concerns',
      'Family issues',
      'Deadlines',
      'Traffic',
      'Arguments'
    ],
    'Social situation': [
      'Friends vaping',
      'Parties',
      'Bars/clubs',
      'Social gatherings',
      'Work breaks'
    ],
    'After a meal': [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Coffee break',
      'Dessert'
    ],
    'Boredom': [
      'Waiting',
      'Free time',
      'Nothing to do',
      'Procrastination'
    ],
    'Habit/Routine': [
      'Morning routine',
      'After work',
      'While driving',
      'With coffee',
      'Before bed'
    ],
    'Alcohol': [
      'Beer',
      'Wine',
      'Spirits',
      'Social drinking',
      'At home'
    ],
    'Coffee': [
      'Morning coffee',
      'Coffee break',
      'After meals'
    ],
    'Emotional': [
      'Anxiety',
      'Sadness',
      'Anger',
      'Excitement',
      'Boredom',
      'Loneliness'
    ],
    'Other': [
      'Seeing vaping devices',
      'Smelling vapor',
      'After exercise',
      'While on phone'
    ]
  };
  
  // Coping strategies
  static const List<String> copingStrategies = [
    'Deep breathing',
    'Distraction',
    'Exercise',
    'Drinking water',
    'Chewing gum',
    'Calling a friend',
    'Using NRT',
    'Meditation',
    'Other'
  ];
  
  // Health milestones (days => description)
  static const Map<int, String> healthMilestones = {
    1: 'Blood pressure and heart rate start to normalize',
    2: 'Carbon monoxide levels in blood return to normal',
    3: 'Sense of taste and smell begin to improve',
    7: 'Nicotine is eliminated from the body',
    14: 'Circulation improves, lung function begins to improve',
    30: 'Lung function significantly improves, coughing and shortness of breath decrease',
    90: 'Lung function continues to improve, risk of heart attack begins to drop',
    180: 'Risk of heart disease drops to half that of a smoker',
    365: 'Risk of coronary heart disease is half that of a smoker'
  };
  
  // Subscription product IDs
  static const String monthlySubscriptionId = 'quit_vaping_monthly';
  static const String yearlySubscriptionId = 'quit_vaping_yearly';
  static const String removeAdsId = 'quit_vaping_remove_ads';
  
  // API endpoints
  static const String baseApiUrl = 'https://api.quitvaping.app';
  static const String aiEndpoint = '/api/ai/chat';
  
  // Notification channels
  static const String reminderChannelId = 'reminders';
  static const String reminderChannelName = 'Reminders';
  static const String reminderChannelDescription = 'Notifications for reminders';
  
  static const String achievementChannelId = 'achievements';
  static const String achievementChannelName = 'Achievements';
  static const String achievementChannelDescription = 'Notifications for achievements';
  
  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Motivation categories
  static const List<String> motivationCategories = [
    'Health',
    'Financial',
    'Family',
    'Appearance',
    'Freedom',
    'Social',
    'Self-improvement',
    'Other'
  ];
  
  // Panic mode distractions
  static const List<Map<String, dynamic>> panicModeDistractions = [
    {
      'title': 'Deep Breathing',
      'description': 'Take slow, deep breaths to calm your mind and reduce cravings',
      'icon': 'assets/images/panic_mode/breathing.png',
      'steps': [
        'Find a comfortable position',
        'Breathe in slowly through your nose for 4 seconds',
        'Hold your breath for 4 seconds',
        'Exhale slowly through your mouth for 6 seconds',
        'Repeat for at least 2 minutes'
      ]
    },
    {
      'title': '5-4-3-2-1 Technique',
      'description': 'Ground yourself by engaging your senses',
      'icon': 'assets/images/panic_mode/grounding.png',
      'steps': [
        'Acknowledge 5 things you can see',
        'Acknowledge 4 things you can touch',
        'Acknowledge 3 things you can hear',
        'Acknowledge 2 things you can smell',
        'Acknowledge 1 thing you can taste'
      ]
    },
    {
      'title': 'Physical Activity',
      'description': 'Move your body to distract from cravings',
      'icon': 'assets/images/panic_mode/exercise.png',
      'steps': [
        'Do 10 jumping jacks',
        'Do 10 push-ups or wall push-ups',
        'March in place for 30 seconds',
        'Stretch your arms and legs',
        'Take a short walk if possible'
      ]
    },
    {
      'title': 'Drink Water',
      'description': 'Hydrate to reduce cravings',
      'icon': 'assets/images/panic_mode/water.png',
      'steps': [
        'Get a glass of cold water',
        'Take small sips slowly',
        'Focus on the sensation of the water',
        'Notice how it feels as you swallow',
        'Finish the entire glass'
      ]
    },
    {
      'title': 'Distraction Activity',
      'description': 'Engage your mind in something else',
      'icon': 'assets/images/panic_mode/distraction.png',
      'steps': [
        'Play a quick game on your phone',
        'Call or text a friend',
        'Read an article or book',
        'Listen to your favorite song',
        'Watch a short video'
      ]
    }
  ];
}