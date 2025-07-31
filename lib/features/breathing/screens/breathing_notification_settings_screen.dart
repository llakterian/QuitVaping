import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/features/breathing/services/breathing_notification_service.dart';

/// Screen for configuring breathing exercise notification settings
class BreathingNotificationSettingsScreen extends StatefulWidget {
  /// Creates a new BreathingNotificationSettingsScreen
  const BreathingNotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<BreathingNotificationSettingsScreen> createState() => _BreathingNotificationSettingsScreenState();
}

class _BreathingNotificationSettingsScreenState extends State<BreathingNotificationSettingsScreen> {
  late bool _remindersEnabled;
  late TimeOfDay _reminderTime;

  @override
  void initState() {
    super.initState();
    final notificationService = Provider.of<BreathingNotificationService>(context, listen: false);
    _remindersEnabled = notificationService.isRemindersEnabled();
    _reminderTime = notificationService.getReminderTime();
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<BreathingNotificationService>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Notifications'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Configure how and when you receive breathing exercise reminders',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SwitchListTile(
            title: const Text('Daily Reminders'),
            subtitle: const Text('Receive a daily reminder to practice breathing exercises'),
            value: _remindersEnabled,
            onChanged: (value) async {
              await notificationService.setRemindersEnabled(value);
              setState(() {
                _remindersEnabled = value;
              });
            },
          ),
          ListTile(
            enabled: _remindersEnabled,
            title: const Text('Reminder Time'),
            subtitle: Text(_formatTimeOfDay(_reminderTime)),
            trailing: const Icon(Icons.access_time),
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: _reminderTime,
              );
              
              if (pickedTime != null) {
                await notificationService.setReminderTime(pickedTime);
                setState(() {
                  _reminderTime = pickedTime;
                });
              }
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Inactivity Reminders'),
            subtitle: const Text('Get reminded if you haven\'t practiced in a while'),
            value: _remindersEnabled, // Uses the same setting as daily reminders
            onChanged: (value) async {
              await notificationService.setRemindersEnabled(value);
              setState(() {
                _remindersEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Stress Relief Suggestions'),
            subtitle: const Text('Receive suggestions for breathing exercises during high-stress times'),
            value: _remindersEnabled, // Uses the same setting as daily reminders
            onChanged: (value) async {
              await notificationService.setRemindersEnabled(value);
              setState(() {
                _remindersEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Achievement Milestone Alerts'),
            subtitle: const Text('Get notified when you\'re close to unlocking an achievement'),
            value: _remindersEnabled, // Uses the same setting as daily reminders
            onChanged: (value) async {
              await notificationService.setRemindersEnabled(value);
              setState(() {
                _remindersEnabled = value;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Note: Make sure notifications are enabled in your device settings for the app.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}