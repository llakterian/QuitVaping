import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/breathing_exercise_card.dart';

/// Screen that displays a list of available breathing exercises
class BreathingExerciseListScreen extends StatefulWidget {
  const BreathingExerciseListScreen({Key? key}) : super(key: key);

  @override
  State<BreathingExerciseListScreen> createState() => _BreathingExerciseListScreenState();
}

class _BreathingExerciseListScreenState extends State<BreathingExerciseListScreen> {
  // Selected filter tag
  String? _selectedTag;
  
  // Sort option
  String _sortOption = 'Default';
  
  // List of available sort options
  final List<String> _sortOptions = ['Default', 'Name', 'Duration', 'Recently Used'];
  
  // Set of favorite exercise IDs
  final Set<String> _favorites = {};
  
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }
  
  /// Loads the user's favorite exercises
  Future<void> _loadFavorites() async {
    // In a real app, this would load from preferences or a database
    // For now, we'll just use a placeholder
    setState(() {
      _favorites.add('box-breathing');
    });
  }
  
  /// Toggles an exercise as favorite
  void _toggleFavorite(String exerciseId) {
    setState(() {
      if (_favorites.contains(exerciseId)) {
        _favorites.remove(exerciseId);
      } else {
        _favorites.add(exerciseId);
      }
    });
    
    // In a real app, save this to preferences or a database
  }
  
  @override
  Widget build(BuildContext context) {
    final breathingService = Provider.of<BreathingExerciseService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercises'),
        actions: [
          // Sort button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortOption = value;
              });
            },
            itemBuilder: (context) {
              return _sortOptions.map((option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Row(
                    children: [
                      Icon(
                        _getSortIcon(option),
                        color: _sortOption == option ? AppColors.primary : null,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        option,
                        style: TextStyle(
                          color: _sortOption == option ? AppColors.primary : null,
                          fontWeight: _sortOption == option ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          _buildFilterChips(),
          
          // Exercise list
          Expanded(
            child: FutureBuilder<List<BreathingExerciseModel>>(
              future: breathingService.getExercises(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading exercises: ${snapshot.error}',
                      style: TextStyle(color: AppColors.error),
                    ),
                  );
                }
                
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No breathing exercises available'),
                  );
                }
                
                // Filter and sort exercises
                final exercises = _filterAndSortExercises(snapshot.data!);
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return BreathingExerciseCard(
                      exercise: exercise,
                      isFavorite: _favorites.contains(exercise.id),
                      onTap: () => _navigateToExerciseDetail(exercise),
                      onStartPressed: () => _navigateToExerciseScreen(exercise),
                      onFavoriteToggled: (isFavorite) => _toggleFavorite(exercise.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the filter chips for tags
  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List<BreathingExerciseModel>>(
        future: Provider.of<BreathingExerciseService>(context).getExercises(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          
          // Extract all unique tags
          final allTags = <String>{};
          for (final exercise in snapshot.data!) {
            allTags.addAll(exercise.tags);
          }
          
          // Sort tags alphabetically
          final sortedTags = allTags.toList()..sort();
          
          // Add "All" option at the beginning
          final displayTags = ['All', ...sortedTags];
          
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayTags.length,
            itemBuilder: (context, index) {
              final tag = displayTags[index];
              final isSelected = (tag == 'All' && _selectedTag == null) || tag == _selectedTag;
              
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedTag = selected ? (tag == 'All' ? null : tag) : null;
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  checkmarkColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  
  /// Filters and sorts the exercises based on selected options
  List<BreathingExerciseModel> _filterAndSortExercises(List<BreathingExerciseModel> exercises) {
    // Apply tag filter
    var filtered = _selectedTag == null
        ? exercises
        : exercises.where((e) => e.tags.contains(_selectedTag)).toList();
    
    // Apply sorting
    switch (_sortOption) {
      case 'Name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Duration':
        filtered.sort((a, b) => a.recommendedDuration.compareTo(b.recommendedDuration));
        break;
      case 'Recently Used':
        // In a real app, this would sort by last used timestamp
        // For now, we'll just keep the default order
        break;
      default:
        // Default sorting - put favorites first
        filtered.sort((a, b) {
          final aIsFavorite = _favorites.contains(a.id);
          final bIsFavorite = _favorites.contains(b.id);
          
          if (aIsFavorite && !bIsFavorite) return -1;
          if (!aIsFavorite && bIsFavorite) return 1;
          return 0;
        });
    }
    
    return filtered;
  }
  
  /// Returns the appropriate icon for the sort option
  IconData _getSortIcon(String option) {
    switch (option) {
      case 'Name':
        return Icons.sort_by_alpha;
      case 'Duration':
        return Icons.timer;
      case 'Recently Used':
        return Icons.history;
      default:
        return Icons.favorite;
    }
  }
  
  /// Navigates to the exercise detail screen
  void _navigateToExerciseDetail(BreathingExerciseModel exercise) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Placeholder(
          child: Center(
            child: Text('Detail screen for ${exercise.name}'),
          ),
        ),
      ),
    );
  }
  
  /// Navigates to the exercise execution screen
  void _navigateToExerciseScreen(BreathingExerciseModel exercise) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Placeholder(
          child: Center(
            child: Text('Exercise screen for ${exercise.name}'),
          ),
        ),
      ),
    );
  }
}