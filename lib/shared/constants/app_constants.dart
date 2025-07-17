
class AppConstants {
  // App information
  static const String appName = 'QuitVaping';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your AI-powered journey to quit vaping';
  
  // Health milestones (in hours)
  static const Map<int, String> healthMilestones = {
    8: 'Carbon monoxide levels drop to normal',
    24: 'Nicotine is eliminated from your body',
    48: 'Your sense of taste and smell begin to improve',
    72: 'Breathing becomes easier as bronchial tubes relax',
    168: 'Circulation improves',
    336: 'Lung function increases',
    720: 'Coughing and shortness of breath decrease',
    2160: 'Risk of heart attack begins to drop',
    8760: 'Risk of lung cancer decreases by 30-50%',
  };
  
  // Trigger categories
  static const List<String> triggerCategories = [
    'emotional',
    'social',
    'environmental',
    'physical',
  ];
  
  // Common triggers by category
  static const Map<String, List<String>> commonTriggers = {
    'emotional': [
      'Stress',
      'Anxiety',
      'Boredom',
      'Sadness',
      'Anger',
      'Loneliness',
      'Celebration',
    ],
    'social': [
      'Friends vaping',
      'Party/social gathering',
      'Drinking alcohol',
      'After meals with others',
      'Work breaks',
      'Peer pressure',
    ],
    'environmental': [
      'Driving',
      'After waking up',
      'Before bed',
      'Specific location',
      'Seeing vaping devices',
      'Smelling vape scents',
    ],
    'physical': [
      'After eating',
      'With coffee/tea',
      'During work breaks',
      'While drinking alcohol',
      'When feeling tired',
      'After exercise',
    ],
  };
  
  // Coping strategies
  static const List<String> copingStrategies = [
    'Deep breathing',
    'Drinking water',
    'Physical activity',
    'Distraction (game, app, etc.)',
    'Calling someone',
    'Chewing gum',
    'Using nicotine replacement',
    'Meditation',
    'Delaying (waiting it out)',
    'Leaving the situation',
  ];
  
  // Motivation categories
  static const List<String> motivationCategories = [
    'Health',
    'Financial',
    'Social',
    'Personal freedom',
    'Setting example for others',
    'Appearance',
    'Sense of smell/taste',
    'Athletic performance',
    'Environmental concerns',
  ];
  
  // Breathing exercise types
  static const Map<String, Map<String, dynamic>> breathingExercises = {
    'box': {
      'name': 'Box Breathing',
      'description': 'Inhale, hold, exhale, and hold again for equal counts',
      'steps': [
        {'action': 'inhale', 'seconds': 4, 'instruction': 'Breathe in slowly through your nose'},
        {'action': 'hold', 'seconds': 4, 'instruction': 'Hold your breath'},
        {'action': 'exhale', 'seconds': 4, 'instruction': 'Exhale slowly through your mouth'},
        {'action': 'hold', 'seconds': 4, 'instruction': 'Hold your breath'},
      ],
      'benefits': 'Reduces stress and improves concentration',
      'isPremium': false,
    },
    '478': {
      'name': '4-7-8 Breathing',
      'description': 'Inhale for 4, hold for 7, exhale for 8',
      'steps': [
        {'action': 'inhale', 'seconds': 4, 'instruction': 'Breathe in quietly through your nose'},
        {'action': 'hold', 'seconds': 7, 'instruction': 'Hold your breath'},
        {'action': 'exhale', 'seconds': 8, 'instruction': 'Exhale completely through your mouth'},
      ],
      'benefits': 'Helps with anxiety, sleep, and managing cravings',
      'isPremium': true,
    },
    'diaphragmatic': {
      'name': 'Diaphragmatic Breathing',
      'description': 'Deep belly breathing that engages the diaphragm',
      'steps': [
        {'action': 'inhale', 'seconds': 4, 'instruction': 'Breathe in deeply through your nose, filling your belly'},
        {'action': 'hold', 'seconds': 1, 'instruction': 'Brief pause'},
        {'action': 'exhale', 'seconds': 6, 'instruction': 'Exhale slowly through pursed lips'},
      ],
      'benefits': 'Reduces stress and increases oxygen supply',
      'isPremium': true,
    },
    'pursed': {
      'name': 'Pursed Lip Breathing',
      'description': 'Inhale through nose, exhale slowly through pursed lips',
      'steps': [
        {'action': 'inhale', 'seconds': 2, 'instruction': 'Breathe in through your nose'},
        {'action': 'exhale', 'seconds': 4, 'instruction': 'Exhale slowly through pursed lips'},
      ],
      'benefits': 'Improves ventilation and releases trapped air in lungs',
      'isPremium': false,
    },
  };
  
  // Panic mode distraction techniques
  static const List<Map<String, dynamic>> panicModeDistractions = [
    {
      'title': '5-4-3-2-1 Grounding',
      'description': 'Focus on your senses to ground yourself in the present moment',
      'steps': [
        'Name 5 things you can see',
        'Name 4 things you can touch',
        'Name 3 things you can hear',
        'Name 2 things you can smell',
        'Name 1 thing you can taste',
      ],
      'duration': 60, // seconds
      'isPremium': false,
    },
    {
      'title': 'Quick Physical Activity',
      'description': 'Get your body moving to redirect your focus',
      'steps': [
        '10 jumping jacks',
        '10 arm circles',
        '10 high knees',
        '10 seconds of jogging in place',
      ],
      'duration': 45, // seconds
      'isPremium': false,
    },
    {
      'title': 'Cold Water Technique',
      'description': 'Use cold water to create a physical sensation that interrupts cravings',
      'steps': [
        'Fill a glass with cold water',
        'Take small sips and focus on the sensation',
        'Splash cold water on your face or wrists',
        'Notice how the cold feeling changes your focus',
      ],
      'duration': 30, // seconds
      'isPremium': false,
    },
    {
      'title': 'Urge Surfing',
      'description': 'Visualize your craving as a wave that rises and eventually falls',
      'steps': [
        'Close your eyes and notice the craving sensation',
        'Visualize it as a wave building in intensity',
        'Don\'t fight it - observe it rising',
        'Notice as it peaks and then gradually subsides',
        'Remind yourself that all cravings eventually pass',
      ],
      'duration': 90, // seconds
      'isPremium': false,
    },
    // Premium distraction techniques
    {
      'title': 'Progressive Muscle Relaxation',
      'description': 'Systematically tense and relax muscle groups to reduce physical tension',
      'steps': [
        'Find a comfortable position and close your eyes',
        'Tense the muscles in your feet for 5 seconds, then release',
        'Tense your calf muscles for 5 seconds, then release',
        'Continue up through your legs, abdomen, chest, arms, and face',
        'Notice the feeling of relaxation spreading through your body',
        'Take deep breaths and enjoy the sensation of relaxation',
      ],
      'duration': 120, // seconds
      'isPremium': true,
    },
    {
      'title': 'Guided Imagery',
      'description': 'Use your imagination to transport yourself to a peaceful place',
      'steps': [
        'Close your eyes and take several deep breaths',
        'Imagine a peaceful place (beach, forest, mountain, etc.)',
        'Visualize the details - colors, sounds, smells, textures',
        'Imagine yourself completely relaxed in this place',
        'Feel the calmness and serenity washing over you',
        'Stay in this peaceful place for a few minutes',
      ],
      'duration': 180, // seconds
      'isPremium': true,
    },
    {
      'title': 'Mindful Body Scan',
      'description': 'A meditation technique to bring awareness to each part of your body',
      'steps': [
        'Sit or lie down in a comfortable position',
        'Close your eyes and focus on your breathing',
        'Bring attention to your feet, noticing any sensations',
        'Slowly move your attention up through your body',
        'Notice any areas of tension and breathe into them',
        'Complete the scan at the top of your head',
        'Take a moment to feel your entire body as a whole',
      ],
      'duration': 240, // seconds
      'isPremium': true,
    },
    {
      'title': 'Personalized Craving Analysis',
      'description': 'Analyze your craving triggers and develop personalized coping strategies',
      'steps': [
        'Identify what triggered this specific craving',
        'Rate the intensity of your craving from 1-10',
        'Write down your thoughts and emotions',
        'Identify patterns from previous cravings',
        'Select a personalized coping strategy',
        'Implement the strategy and note its effectiveness',
        'Plan how to handle similar situations in the future',
      ],
      'duration': 180, // seconds
      'isPremium': true,
    },
  ];
  
  // Notification types
  static const Map<String, String> notificationTypes = {
    'milestone': 'Health Milestone Achieved',
    'daily_checkin': 'Time for Your Daily Check-in',
    'craving_risk': 'High-Risk Time Alert',
    'motivation': 'Daily Motivation',
    'streak': 'Streak Milestone',
    'tip': 'Quitting Tip',
  };
}