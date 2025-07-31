import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/common_widgets.dart';

/// Screen that displays the user's breathing exercise history
class BreathingHistoryScreen extends StatefulWidget {
  const BreathingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BreathingHistoryScreen> createState() => _BreathingHistoryScreenState();
}

class _BreathingHistoryScreenState extends State<BreathingHistoryScreen> {
  // Calendar format
  CalendarFormat _calendarFormat = CalendarFormat.month;
  
  // Selected day
  DateTime _selectedDay = DateTime.now();
  
  // Focused day (month being displayed)
  DateTime _focusedDay = DateTime.now();
  
  // Filter options
  String? _selectedExerciseFilter;
  String _dateRangeFilter = 'All Time';
  
  // Date range options
  final List<String> _dateRangeOptions = [
    'Today',
    'This Week',
    'This Month',
    'This Year',
    'All Time',
  ];
  
  // Map of sessions by date
  Map<DateTime, List<BreathingSessionModel>> _sessionsByDate = {};
  
  // Statistics
  Map<String, dynamic> _statistics = {};
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  /// Loads session data and statistics
  Future<void> _loadData() async {
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    
    // Get date range based on filter
    final dateRange = _getDateRange();
    
    // Get sessions
    final sessions = await breathingService.getSessionHistory(
      dateRange['start'] as DateTime?,
      dateRange['end'] as DateTime?,
    );
    
    // Group sessions by date
    final sessionsByDate = <DateTime, List<BreathingSessionModel>>{};
    for (final session in sessions) {
      final date = DateTime(
        session.timestamp.year,
        session.timestamp.month,
        session.timestamp.day,
      );
      
      if (!sessionsByDate.containsKey(date)) {
        sessionsByDate[date] = [];
      }
      
      sessionsByDate[date]!.add(session);
    }
    
    // Get statistics
    final statistics = await breathingService.getStatistics();
    
    setState(() {
      _sessionsByDate = sessionsByDate;
      _statistics = statistics;
    });
  }
  
  /// Gets the date range based on the selected filter
  Map<String, DateTime?> _getDateRange() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    switch (_dateRangeFilter) {
      case 'Today':
        return {
          'start': today,
          'end': today,
        };
      case 'This Week':
        // Start of week (Monday)
        final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
        return {
          'start': startOfWeek,
          'end': today,
        };
      case 'This Month':
        // Start of month
        final startOfMonth = DateTime(today.year, today.month, 1);
        return {
          'start': startOfMonth,
          'end': today,
        };
      case 'This Year':
        // Start of year
        final startOfYear = DateTime(today.year, 1, 1);
        return {
          'start': startOfYear,
          'end': today,
        };
      default: // All Time
        return {
          'start': null,
          'end': null,
        };
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing History'),
        actions: [
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics summary
          _buildStatisticsSummary(),
          
          // Calendar
          _buildCalendar(),
          
          // Session list for selected day
          Expanded(
            child: _buildSessionList(),
          ),
        ],
      ),
    );
  }
  
  /// Builds the statistics summary section
  Widget _buildStatisticsSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard(
            'Total Sessions',
            _statistics['totalSessions']?.toString() ?? '0',
            Icons.repeat,
          ),
          _buildStatCard(
            'Total Minutes',
            _statistics['totalMinutes']?.toString() ?? '0',
            Icons.timer,
          ),
          _buildStatCard(
            'Current Streak',
            _statistics['currentStreak']?.toString() ?? '0',
            Icons.local_fire_department,
          ),
        ],
      ),
    );
  }
  
  /// Builds a single statistic card
  Widget _buildStatCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
  
  /// Builds the calendar widget
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.now(),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      eventLoader: (day) {
        // Find the normalized date (without time)
        final normalizedDay = DateTime(day.year, day.month, day.day);
        
        // Return sessions for this day
        return _sessionsByDate[normalizedDay] ?? [];
      },
      calendarStyle: CalendarStyle(
        markersMaxCount: 3,
        markerDecoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        formatButtonTextStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  /// Builds the session list for the selected day
  Widget _buildSessionList() {
    // Find the normalized date (without time)
    final normalizedDay = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    
    // Get sessions for the selected day
    final sessions = _sessionsByDate[normalizedDay] ?? [];
    
    // Apply exercise filter if selected
    final filteredSessions = _selectedExerciseFilter == null
        ? sessions
        : sessions.where((s) => s.exerciseId == _selectedExerciseFilter).toList();
    
    // Sort by timestamp (newest first)
    filteredSessions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    if (filteredSessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.air,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No breathing sessions on this day',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredSessions.length,
      itemBuilder: (context, index) {
        final session = filteredSessions[index];
        return _buildSessionCard(session);
      },
    );
  }
  
  /// Builds a card for a single session
  Widget _buildSessionCard(BreathingSessionModel session) {
    final timeFormat = DateFormat('h:mm a');
    final formattedTime = timeFormat.format(session.timestamp);
    
    return RoundedCard(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise name and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                session.exerciseName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formattedTime,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Duration and completion status
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                session.formattedDuration,
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                session.completed ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: session.completed ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 4),
              Text(
                session.completed ? 'Completed' : 'Ended early',
                style: TextStyle(
                  color: session.completed ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          
          // Show mood improvement if available
          if (session.moodBefore != null && session.moodAfter != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.mood,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Mood: ${session.moodBefore} → ${session.moodAfter}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    session.hadPositiveMoodImpact ? Icons.trending_up : Icons.trending_down,
                    size: 16,
                    color: session.hadPositiveMoodImpact ? AppColors.success : AppColors.error,
                  ),
                ],
              ),
            ),
          
          // Show notes if available
          if (session.notes != null && session.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Note: ${session.notes}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          
          // Pattern details
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Pattern: ${session.pattern.inhaleSeconds}-${session.pattern.inhaleHoldSeconds}-${session.pattern.exhaleSeconds}-${session.pattern.exhaleHoldSeconds}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Shows the filter dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filter Sessions'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date range filter
                  const Text(
                    'Date Range',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _dateRangeOptions.map((option) {
                      return ChoiceChip(
                        label: Text(option),
                        selected: _dateRangeFilter == option,
                        onSelected: (selected) {
                          setState(() {
                            _dateRangeFilter = option;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Exercise filter
                  const Text(
                    'Exercise Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<BreathingExerciseModel>>(
                    future: Provider.of<BreathingExerciseService>(context, listen: false).getExercises(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      
                      final exercises = snapshot.data!;
                      
                      return Wrap(
                        spacing: 8,
                        children: [
                          // Add "All" option
                          ChoiceChip(
                            label: const Text('All'),
                            selected: _selectedExerciseFilter == null,
                            onSelected: (selected) {
                              setState(() {
                                _selectedExerciseFilter = null;
                              });
                            },
                          ),
                          
                          // Add exercise options
                          ...exercises.map((exercise) {
                            return ChoiceChip(
                              label: Text(exercise.name),
                              selected: _selectedExerciseFilter == exercise.id,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedExerciseFilter = selected ? exercise.id : null;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _loadData(); // Reload data with new filters
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Extension to add helper methods to RoundedCard
extension RoundedCardExtension on RoundedCard {
  /// Creates a RoundedCard with margin
  RoundedCard margin(EdgeInsetsGeometry margin) {
    return RoundedCard(
      child: child,
      onTap: onTap,
      elevation: elevation,
      padding: padding,
      borderRadius: borderRadius,
      color: color,
      padding: margin,
    );
  }
}