import 'package:flutter/material.dart';
import 'dart:async';

import '../../../data/models/user_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../shared/theme/app_colors.dart';

class ProgressTracker extends StatefulWidget {
  final UserModel user;
  final ProgressModel? progress;

  const ProgressTracker({
    Key? key,
    required this.user,
    this.progress,
  }) : super(key: key);

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  late Timer _timer;
  late DateTime _quitDate;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _quitDate = widget.user.quitDate ?? DateTime.now();
    _updateTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer() {
    final now = DateTime.now();
    final difference = now.difference(_quitDate);
    
    setState(() {
      _days = difference.inDays;
      _hours = difference.inHours % 24;
      _minutes = difference.inMinutes % 60;
      _seconds = difference.inSeconds % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timer, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Vape-Free For',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeUnit(_days.toString(), 'DAYS'),
                _buildTimeUnit(_hours.toString().padLeft(2, '0'), 'HOURS'),
                _buildTimeUnit(_minutes.toString().padLeft(2, '0'), 'MINUTES'),
                _buildTimeUnit(_seconds.toString().padLeft(2, '0'), 'SECONDS'),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.progress != null) ...[
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(
                    context,
                    'Current Streak',
                    '${widget.progress!.currentStreak} days',
                    Icons.local_fire_department,
                    AppColors.accent,
                  ),
                  _buildStat(
                    context,
                    'Longest Streak',
                    '${widget.progress!.longestStreak} days',
                    Icons.emoji_events,
                    AppColors.secondary,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}