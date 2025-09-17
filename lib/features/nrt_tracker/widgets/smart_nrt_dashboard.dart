import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/services/smart_nrt_service.dart';
import '../../../data/models/smart_nrt_models.dart';
import '../../../shared/theme/app_colors.dart';

/// Smart NRT Dashboard widget that displays AI-powered insights and recommendations
class SmartNRTDashboard extends StatefulWidget {
  final String userId;

  const SmartNRTDashboard({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<SmartNRTDashboard> createState() => _SmartNRTDashboardState();
}

class _SmartNRTDashboardState extends State<SmartNRTDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSmartNRT();
    });
  }

  Future<void> _initializeSmartNRT() async {
    final smartNRTService = Provider.of<SmartNRTService>(context, listen: false);
    await smartNRTService.initialize(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SmartNRTService>(
      builder: (context, smartNRTService, child) {
        if (smartNRTService.isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Initializing Smart NRT System...'),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Protocol Card
              if (smartNRTService.currentProtocol != null)
                _buildCurrentProtocolCard({
                  'recommendedNrtType': smartNRTService.currentProtocol?.recommendedNrtType ?? 'Unknown',
                  'durationWeeks': smartNRTService.currentProtocol?.durationWeeks ?? 0,
                  'dosageSchedule': smartNRTService.currentProtocol?.dosageSchedule ?? [],
                  'safetyWarnings': smartNRTService.currentProtocol?.safetyWarnings ?? [],
                }),
              
              const SizedBox(height: 16),
              
              // Active Reminders
              if (smartNRTService.activeReminders.isNotEmpty)
                _buildActiveRemindersCard(smartNRTService.activeReminders),
              
              const SizedBox(height: 16),
              
              // Withdrawal Symptoms Tracking
              _buildSymptomTrackingCard(smartNRTService),
              
              const SizedBox(height: 16),
              
              // Readiness Assessment
              _buildReadinessAssessmentCard(smartNRTService),
              
              const SizedBox(height: 16),
              
              // Safety Alerts
              if (smartNRTService.safetyAlerts.any((alert) => !alert.acknowledged))
                _buildSafetyAlertsCard(smartNRTService),
              
              const SizedBox(height: 16),
              
              // Recent Symptoms
              if (smartNRTService.withdrawalSymptoms.isNotEmpty)
                _buildRecentSymptomsCard(smartNRTService.withdrawalSymptoms),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentProtocolCard(Map<String, dynamic> protocol) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medical_services, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Current NRT Protocol',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildProtocolInfo('Recommended Type', (protocol['recommendedNrtType'] as String? ?? 'Unknown').toUpperCase()),
            _buildProtocolInfo('Duration', '${protocol['durationWeeks'] ?? 0} weeks'),
            
            const SizedBox(height: 16),
            
            Text(
              'Dosage Schedule',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            ...(protocol['dosageSchedule'] as List? ?? []).map((schedule) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      schedule['week'].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${schedule['strength']}mg - ${schedule['frequency']}x daily',
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            if ((protocol['safetyWarnings'] as List? ?? []).isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withValues(alpha: 77)), // 0.3 * 255 ≈ 77
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Safety Warnings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...(protocol['safetyWarnings'] as List? ?? []).map((warning) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text('• $warning'),
                    )).toList(),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActiveRemindersCard(List<NRTReminder> reminders) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications_active, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Active Reminders',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            ...reminders.take(3).map((reminder) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getReminderColor(reminder.type).withValues(alpha: 26), // 0.1 * 255 ≈ 26
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getReminderIcon(reminder.type),
                      color: _getReminderColor(reminder.type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder.message,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          DateFormat.jm().format(reminder.scheduledTime),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (reminder.type == NRTReminderType.urgent)
                    const Icon(Icons.priority_high, color: Colors.red),
                ],
              ),
            )).toList(),
            
            if (reminders.length > 3) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Navigate to full reminders list
                },
                child: Text('View all ${reminders.length} reminders'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomTrackingCard(SmartNRTService smartNRTService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Symptom Tracking',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WithdrawalSymptomType.values.take(6).map((symptomType) {
                return _buildSymptomChip(symptomType, smartNRTService);
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showSymptomTrackingDialog(smartNRTService);
                },
                icon: const Icon(Icons.add),
                label: const Text('Track Symptom'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessAssessmentCard(SmartNRTService smartNRTService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.assessment, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Reduction Readiness',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              'Ready to reduce your NRT dosage?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Our AI will assess your readiness based on your recent symptoms and usage patterns.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _performReadinessAssessment(smartNRTService);
                },
                icon: const Icon(Icons.psychology),
                label: const Text('Assess Readiness'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSymptomsCard(List<WithdrawalSymptom> symptoms) {
    final recentSymptoms = symptoms
        .where((s) => s.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Recent Symptoms',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (recentSymptoms.isEmpty) ...[
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.sentiment_satisfied, size: 48, color: AppColors.success),
                    SizedBox(height: 8),
                    Text('No recent symptoms reported!'),
                    Text('Keep up the great work!'),
                  ],
                ),
              ),
            ] else ...[
              ...recentSymptoms.take(5).map((symptom) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getSeverityColor(symptom.severity).withValues(alpha: 26), // 0.1 * 255 ≈ 26
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          symptom.severity.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getSeverityColor(symptom.severity),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getSymptomDisplayName(symptom.type),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            DateFormat.yMMMd().add_jm().format(symptom.timestamp),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          if (symptom.notes != null && symptom.notes!.isNotEmpty)
                            Text(
                              symptom.notes!,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSymptomChip(WithdrawalSymptomType symptomType, SmartNRTService smartNRTService) {
    return ActionChip(
      label: Text(_getSymptomDisplayName(symptomType)),
      onPressed: () {
        _quickTrackSymptom(symptomType, smartNRTService);
      },
      backgroundColor: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
    );
  }

  // Helper methods
  Color _getReminderColor(NRTReminderType type) {
    switch (type) {
      case NRTReminderType.urgent:
        return Colors.red;
      case NRTReminderType.dosage:
        return AppColors.primary;
      case NRTReminderType.celebration:
        return AppColors.success;
      default:
        return Colors.blue;
    }
  }

  IconData _getReminderIcon(NRTReminderType type) {
    switch (type) {
      case NRTReminderType.urgent:
        return Icons.warning;
      case NRTReminderType.dosage:
        return Icons.medication;
      case NRTReminderType.celebration:
        return Icons.celebration;
      case NRTReminderType.symptomCheck:
        return Icons.psychology;
      default:
        return Icons.notifications;
    }
  }

  Color _getSeverityColor(int severity) {
    if (severity <= 3) return AppColors.success;
    if (severity <= 6) return Colors.orange;
    return Colors.red;
  }

  String _getSymptomDisplayName(WithdrawalSymptomType type) {
    switch (type) {
      case WithdrawalSymptomType.craving:
        return 'Craving';
      case WithdrawalSymptomType.irritability:
        return 'Irritability';
      case WithdrawalSymptomType.anxiety:
        return 'Anxiety';
      case WithdrawalSymptomType.difficultyConcentrating:
        return 'Focus Issues';
      case WithdrawalSymptomType.restlessness:
        return 'Restlessness';
      case WithdrawalSymptomType.sleepDisturbance:
        return 'Sleep Issues';
      case WithdrawalSymptomType.increasedAppetite:
        return 'Increased Appetite';
      case WithdrawalSymptomType.moodChanges:
        return 'Mood Changes';
      case WithdrawalSymptomType.fatigue:
        return 'Fatigue';
      case WithdrawalSymptomType.headache:
        return 'Headache';
    }
  }

  void _showSymptomTrackingDialog(SmartNRTService smartNRTService) {
    showDialog(
      context: context,
      builder: (context) => _SymptomTrackingDialog(
        userId: widget.userId,
        smartNRTService: smartNRTService,
      ),
    );
  }

  void _quickTrackSymptom(WithdrawalSymptomType symptomType, SmartNRTService smartNRTService) {
    // Quick track with default severity of 5
    smartNRTService.trackWithdrawalSymptom(
      widget.userId,
      symptomType,
      5,
      null,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getSymptomDisplayName(symptomType)} tracked'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  Widget _buildSafetyAlertsCard(SmartNRTService smartNRTService) {
    final unacknowledgedAlerts = smartNRTService.safetyAlerts
        .where((alert) => !alert.acknowledged)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Safety Alerts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            ...unacknowledgedAlerts.map((alert) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getSafetyAlertColor(alert.severity).withValues(alpha: 26), // 0.1 * 255 ≈ 26
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getSafetyAlertColor(alert.severity).withValues(alpha: 77), // 0.3 * 255 ≈ 77
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getSafetyAlertIcon(alert.type),
                        color: _getSafetyAlertColor(alert.severity),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          alert.message,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMd().add_jm().format(alert.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          _acknowledgeAlert(alert, smartNRTService);
                        },
                        child: const Text('Acknowledge'),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Color _getSafetyAlertColor(NRTSafetyAlertSeverity severity) {
    switch (severity) {
      case NRTSafetyAlertSeverity.critical:
        return Colors.red;
      case NRTSafetyAlertSeverity.high:
        return Colors.deepOrange;
      case NRTSafetyAlertSeverity.medium:
        return Colors.orange;
      case NRTSafetyAlertSeverity.low:
        return Colors.amber;
    }
  }

  IconData _getSafetyAlertIcon(NRTSafetyAlertType type) {
    switch (type) {
      case NRTSafetyAlertType.overdoseRisk:
        return Icons.dangerous;
      case NRTSafetyAlertType.interactionWarning:
        return Icons.warning;
      case NRTSafetyAlertType.sideEffectConcern:
        return Icons.health_and_safety;
      case NRTSafetyAlertType.usagePatternConcern:
        return Icons.pattern;
      case NRTSafetyAlertType.medicalConsultationNeeded:
        return Icons.medical_services;
    }
  }

  void _acknowledgeAlert(NRTSafetyAlert alert, SmartNRTService smartNRTService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acknowledge Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(alert.message),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Your response (optional)',
                border: OutlineInputBorder(),
                hintText: 'How are you addressing this concern?',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              smartNRTService.acknowledgeSafetyAlert(alert.id, 'Acknowledged by user');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alert acknowledged'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Acknowledge'),
          ),
        ],
      ),
    );
  }

  Future<void> _performReadinessAssessment(SmartNRTService smartNRTService) async {
    try {
      final assessment = await smartNRTService.assessReductionReadiness(widget.userId);
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => _ReadinessAssessmentDialog(assessment: assessment),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error assessing readiness: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

class _SymptomTrackingDialog extends StatefulWidget {
  final String userId;
  final SmartNRTService smartNRTService;

  const _SymptomTrackingDialog({
    required this.userId,
    required this.smartNRTService,
  });

  @override
  State<_SymptomTrackingDialog> createState() => _SymptomTrackingDialogState();
}

class _SymptomTrackingDialogState extends State<_SymptomTrackingDialog> {
  WithdrawalSymptomType _selectedType = WithdrawalSymptomType.craving;
  double _severity = 5.0;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Track Withdrawal Symptom'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<WithdrawalSymptomType>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Symptom Type',
              border: OutlineInputBorder(),
            ),
            items: WithdrawalSymptomType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(_getSymptomDisplayName(type)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          
          Text('Severity: ${_severity.round()}/10'),
          Slider(
            value: _severity,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                _severity = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              border: OutlineInputBorder(),
              hintText: 'Any additional details...',
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.smartNRTService.trackWithdrawalSymptom(
              widget.userId,
              _selectedType,
              _severity.round(),
              _notesController.text.isEmpty ? null : _notesController.text,
            );
            Navigator.pop(context);
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Symptom tracked successfully'),
                backgroundColor: AppColors.success,
              ),
            );
          },
          child: const Text('Track'),
        ),
      ],
    );
  }

  String _getSymptomDisplayName(WithdrawalSymptomType type) {
    switch (type) {
      case WithdrawalSymptomType.craving:
        return 'Craving';
      case WithdrawalSymptomType.irritability:
        return 'Irritability';
      case WithdrawalSymptomType.anxiety:
        return 'Anxiety';
      case WithdrawalSymptomType.difficultyConcentrating:
        return 'Difficulty Concentrating';
      case WithdrawalSymptomType.restlessness:
        return 'Restlessness';
      case WithdrawalSymptomType.sleepDisturbance:
        return 'Sleep Disturbance';
      case WithdrawalSymptomType.increasedAppetite:
        return 'Increased Appetite';
      case WithdrawalSymptomType.moodChanges:
        return 'Mood Changes';
      case WithdrawalSymptomType.fatigue:
        return 'Fatigue';
      case WithdrawalSymptomType.headache:
        return 'Headache';
    }
  }
}

class _ReadinessAssessmentDialog extends StatelessWidget {
  final NRTReadinessAssessment assessment;

  const _ReadinessAssessmentDialog({required this.assessment});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reduction Readiness Assessment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                assessment.isReady ? Icons.check_circle : Icons.schedule,
                color: assessment.isReady ? AppColors.success : Colors.orange,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  assessment.isReady 
                      ? 'You\'re ready for reduction!'
                      : 'Not quite ready yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Text(
            'Readiness Score: ${(assessment.readinessScore * 100).round()}%',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          
          LinearProgressIndicator(
            value: assessment.readinessScore,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              assessment.isReady ? AppColors.success : Colors.orange,
            ),
          ),
          const SizedBox(height: 16),
          
          if (assessment.reasons.isNotEmpty) ...[
            Text(
              'Reasons:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...assessment.reasons.map((reason) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• $reason'),
            )).toList(),
          ],
          
          if (!assessment.isReady && assessment.recommendedWaitDays > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Recommended wait time: ${assessment.recommendedWaitDays} days',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        if (assessment.isReady)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to dosage reduction flow
            },
            child: const Text('Start Reduction'),
          ),
      ],
    );
  }
}