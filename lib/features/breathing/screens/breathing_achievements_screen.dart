import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../models/breathing_achievement_model.dart';
import '../services/breathing_achievement_service.dart';
import '../widgets/breathing_achievement_card.dart';

/// Screen that displays breathing exercise achievements
class BreathingAchievementsScreen extends StatefulWidget {
  const BreathingAchievementsScreen({Key? key}) : super(key: key);

  @override
  State<BreathingAchievementsScreen> createState() => _BreathingAchievementsScreenState();
}

class _BreathingAchievementsScreenState extends State<BreathingAchievementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BreathingAchievementService _achievementService;
  bool _isLoading = true;
  
  // Achievement lists
  List<BreathingAchievementModel> _unlockedAchievements = [];
  List<BreathingAchievementModel> _inProgressAchievements = [];
  List<BreathingAchievementModel> _lockedAchievements = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initAchievementService();
  }
  
  /// Initializes the achievement service and loads achievements
  Future<void> _initAchievementService() async {
    final prefs = await SharedPreferences.getInstance();
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    
    _achievementService = BreathingAchievementService(prefs, breathingService);
    
    // Update achievements based on latest data
    await _achievementService.updateAchievements();
    
    // Load achievements
    await _loadAchievements();
  }
  
  /// Loads achievements from the service
  Future<void> _loadAchievements() async {
    setState(() {
      _isLoading = true;
    });
    
    // Get achievements by category
    final unlocked = await _achievementService.getUnlockedAchievements();
    final inProgress = await _achievementService.getInProgressAchievements();
    final locked = await _achievementService.getLockedAchievements();
    
    setState(() {
      _unlockedAchievements = unlocked;
      _inProgressAchievements = inProgress;
      _lockedAchievements = locked;
      _isLoading = false;
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Achievements'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Unlocked'),
            Tab(text: 'In Progress'),
            Tab(text: 'Locked'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildUnlockedTab(),
                _buildInProgressTab(),
                _buildLockedTab(),
              ],
            ),
    );
  }
  
  /// Builds the unlocked achievements tab
  Widget _buildUnlockedTab() {
    if (_unlockedAchievements.isEmpty) {
      return _buildEmptyState(
        'No achievements unlocked yet',
        'Complete breathing exercises to earn achievements',
        Icons.emoji_events_outlined,
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Achievement stats
          _buildAchievementStats(),
          
          const SizedBox(height: 16),
          
          // Achievement cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _unlockedAchievements.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BreathingAchievementCard(
                  achievement: _unlockedAchievements[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  /// Builds the in-progress achievements tab
  Widget _buildInProgressTab() {
    if (_inProgressAchievements.isEmpty) {
      return _buildEmptyState(
        'No achievements in progress',
        'Start working towards new achievements',
        Icons.pending_outlined,
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _inProgressAchievements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BreathingAchievementCard(
            achievement: _inProgressAchievements[index],
          ),
        );
      },
    );
  }
  
  /// Builds the locked achievements tab
  Widget _buildLockedTab() {
    if (_lockedAchievements.isEmpty) {
      return _buildEmptyState(
        'No locked achievements',
        'You\'ve discovered all achievements!',
        Icons.check_circle_outline,
      );
    }
    
    // Group achievements by type
    final achievementsByType = <BreathingAchievementType, List<BreathingAchievementModel>>{};
    
    for (final achievement in _lockedAchievements) {
      if (!achievementsByType.containsKey(achievement.type)) {
        achievementsByType[achievement.type] = [];
      }
      achievementsByType[achievement.type]!.add(achievement);
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Session count achievements
          if (achievementsByType.containsKey(BreathingAchievementType.sessionCount))
            BreathingAchievementsGrid(
              title: 'Session Milestones',
              achievements: achievementsByType[BreathingAchievementType.sessionCount]!,
            ),
          
          const SizedBox(height: 16),
          
          // Total minutes achievements
          if (achievementsByType.containsKey(BreathingAchievementType.totalMinutes))
            BreathingAchievementsGrid(
              title: 'Practice Duration',
              achievements: achievementsByType[BreathingAchievementType.totalMinutes]!,
            ),
          
          const SizedBox(height: 16),
          
          // Streak achievements
          if (achievementsByType.containsKey(BreathingAchievementType.streak))
            BreathingAchievementsGrid(
              title: 'Consistency Streaks',
              achievements: achievementsByType[BreathingAchievementType.streak]!,
            ),
          
          const SizedBox(height: 16),
          
          // Exercise variety achievements
          if (achievementsByType.containsKey(BreathingAchievementType.exerciseVariety))
            BreathingAchievementsGrid(
              title: 'Exercise Variety',
              achievements: achievementsByType[BreathingAchievementType.exerciseVariety]!,
            ),
          
          const SizedBox(height: 16),
          
          // Mood improvement achievements
          if (achievementsByType.containsKey(BreathingAchievementType.moodImprovement))
            BreathingAchievementsGrid(
              title: 'Mood Improvements',
              achievements: achievementsByType[BreathingAchievementType.moodImprovement]!,
            ),
        ],
      ),
    );
  }
  
  /// Builds the achievement stats section
  Widget _buildAchievementStats() {
    final totalAchievements = _unlockedAchievements.length + 
                             _inProgressAchievements.length + 
                             _lockedAchievements.length;
    
    final completionPercentage = totalAchievements > 0
        ? (_unlockedAchievements.length / totalAchievements * 100).round()
        : 0;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.progressGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats title
          const Text(
            'Achievement Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: completionPercentage / 100,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('Unlocked', _unlockedAchievements.length.toString()),
              _buildStatItem('In Progress', _inProgressAchievements.length.toString()),
              _buildStatItem('Locked', _lockedAchievements.length.toString()),
              _buildStatItem('Completion', '$completionPercentage%'),
            ],
          ),
        ],
      ),
    );
  }
  
  /// Builds a single stat item
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
  
  /// Builds an empty state widget
  Widget _buildEmptyState(String title, String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}