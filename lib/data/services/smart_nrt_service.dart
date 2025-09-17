import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/health_models.dart';
import '../models/nrt_model.dart';
import '../models/mcp_model.dart';
import '../models/smart_nrt_models.dart';
import 'mcp_manager_service.dart';
import 'nrt_service.dart';

/// Smart NRT Management Service that provides intelligent, evidence-based
/// nicotine replacement therapy guidance using MCP servers and medical databases
class SmartNRTService extends ChangeNotifier {
  final MCPManagerService _mcpManager;
  final NRTService _nrtService;
  final Uuid _uuid = const Uuid();

  // Current state
  NRTProtocol? _currentProtocol;
  List<NRTReminder> _activeReminders = [];
  List<WithdrawalSymptom> _withdrawalSymptoms = [];
  NRTIntelligentSchedule? _intelligentSchedule;
  List<NRTSafetyAlert> _safetyAlerts = [];
  bool _isLoading = false;

  // Stream controllers for real-time updates
  final StreamController<NRTProtocol> _protocolController = 
      StreamController<NRTProtocol>.broadcast();
  final StreamController<NRTReminder> _reminderController = 
      StreamController<NRTReminder>.broadcast();
  final StreamController<WithdrawalSymptom> _symptomController = 
      StreamController<WithdrawalSymptom>.broadcast();
  final StreamController<NRTSafetyAlert> _safetyAlertController = 
      StreamController<NRTSafetyAlert>.broadcast();

  SmartNRTService(this._mcpManager, this._nrtService);

  // Getters
  NRTProtocol? get currentProtocol => _currentProtocol;
  List<NRTReminder> get activeReminders => _activeReminders;
  List<WithdrawalSymptom> get withdrawalSymptoms => _withdrawalSymptoms;
  NRTIntelligentSchedule? get intelligentSchedule => _intelligentSchedule;
  List<NRTSafetyAlert> get safetyAlerts => _safetyAlerts;
  bool get isLoading => _isLoading;

  // Streams
  Stream<NRTProtocol> get protocolStream => _protocolController.stream;
  Stream<NRTReminder> get reminderStream => _reminderController.stream;
  Stream<WithdrawalSymptom> get symptomStream => _symptomController.stream;
  Stream<NRTSafetyAlert> get safetyAlertStream => _safetyAlertController.stream;

  /// Initialize the smart NRT service
  Future<void> initialize(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load existing data
      await _loadExistingData(userId);
      
      // If no protocol exists, generate one
      if (_currentProtocol == null) {
        await generatePersonalizedProtocol(userId);
      }
      
      // Set up intelligent reminders
      await _setupIntelligentReminders(userId);
      
    } catch (e) {
      debugPrint('Error initializing Smart NRT Service: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Generate personalized NRT protocol using medical database APIs
  Future<void> generatePersonalizedProtocol(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get user health profile
      final userProfile = await _getUserHealthProfile(userId);
      
      // Request protocol from medical database via MCP
      final response = await _mcpManager.getNRTProtocols(userId, {
        'age': userProfile.age,
        'vapingDurationMonths': userProfile.vapingDurationMonths,
        'dailyUsageLevel': userProfile.dailyUsageLevel,
        'healthConditions': userProfile.healthConditions,
        'fitnessLevel': userProfile.fitnessLevel,
        'quitDate': userProfile.quitDate.toIso8601String(),
      });

      if (response.error == null && response.data.isNotEmpty) {
        _currentProtocol = NRTProtocol.fromJson(response.data);
        _protocolController.add(_currentProtocol!);
        
        // Generate intelligent schedule based on protocol
        await _generateIntelligentSchedule(userId, _currentProtocol!);
      }
      
    } catch (e) {
      debugPrint('Error generating personalized protocol: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculate personalized dosage based on current progress and symptoms
  Future<NRTDosageRecommendation> calculatePersonalizedDosage(
    String userId,
    List<WithdrawalSymptom> recentSymptoms,
  ) async {
    if (_currentProtocol == null) {
      throw Exception('No NRT protocol available');
    }

    // Analyze recent usage patterns
    final recentUsage = _nrtService.nrtUsage
        .where((usage) => usage.timestamp.isAfter(
            DateTime.now().subtract(const Duration(days: 7))))
        .toList();

    // Calculate symptom severity score
    final symptomSeverity = _calculateSymptomSeverity(recentSymptoms);
    
    // Get current protocol step
    final currentStep = _getCurrentProtocolStep();
    
    // Request AI-powered dosage calculation
    final response = await _mcpManager.sendRequest(MCPRequest(
      id: _uuid.v4(),
      method: 'calculate_personalized_dosage',
      params: {
        'userId': userId,
        'currentProtocol': _currentProtocol!.toJson(),
        'recentUsage': recentUsage.map((u) => u.toJson()).toList(),
        'symptomSeverity': symptomSeverity,
        'currentStep': currentStep?.toJson(),
        'withdrawalSymptoms': recentSymptoms.map((s) => s.toJson()).toList(),
      },
      serverId: 'health-data-server',
    ));

    if (response.error == null && response.data.isNotEmpty) {
      return NRTDosageRecommendation.fromJson(response.data);
    }

    // Fallback calculation if MCP fails
    return _fallbackDosageCalculation(currentStep, symptomSeverity);
  }

  /// Set up intelligent reminder system based on user patterns and readiness
  Future<void> _setupIntelligentReminders(String userId) async {
    if (_currentProtocol == null) return;

    // Analyze user's historical usage patterns
    final usagePatterns = await _analyzeUsagePatterns(userId);
    
    // Generate intelligent reminders
    final reminders = await _generateIntelligentReminders(
      userId, 
      _currentProtocol!, 
      usagePatterns,
    );

    _activeReminders = reminders;
    
    // Schedule notifications for each reminder
    for (final reminder in reminders) {
      _reminderController.add(reminder);
    }

    notifyListeners();
  }

  /// Track withdrawal symptoms and provide intelligent responses
  Future<void> trackWithdrawalSymptom(
    String userId,
    WithdrawalSymptomType type,
    int severity, // 1-10 scale
    String? notes,
  ) async {
    final symptom = WithdrawalSymptom(
      id: _uuid.v4(),
      userId: userId,
      type: type,
      severity: severity,
      timestamp: DateTime.now(),
      notes: notes,
    );

    _withdrawalSymptoms.add(symptom);
    _symptomController.add(symptom);

    // Get intelligent response for the symptom
    await _generateSymptomResponse(userId, symptom);

    notifyListeners();
  }

  /// Generate intelligent response to withdrawal symptoms
  Future<void> _generateSymptomResponse(
    String userId,
    WithdrawalSymptom symptom,
  ) async {
    try {
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'generate_symptom_response',
        params: {
          'userId': userId,
          'symptom': symptom.toJson(),
          'currentProtocol': _currentProtocol?.toJson(),
          'recentSymptoms': _withdrawalSymptoms
              .where((s) => s.timestamp.isAfter(
                  DateTime.now().subtract(const Duration(days: 3))))
              .map((s) => s.toJson())
              .toList(),
        },
        serverId: 'health-data-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        final recommendation = SymptomResponse.fromJson(response.data);
        
        // Create reminder or alert based on recommendation
        if (recommendation.requiresImmediateAction) {
          await _createUrgentReminder(userId, recommendation);
        }
      }
    } catch (e) {
      debugPrint('Error generating symptom response: $e');
    }
  }

  /// Adjust protocol based on user progress and feedback
  Future<void> adjustProtocolBasedOnProgress(
    String userId,
    double progressScore, // 0.0 to 1.0
    Map<String, dynamic> userFeedback,
  ) async {
    if (_currentProtocol == null) return;

    try {
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'adjust_nrt_protocol',
        params: {
          'userId': userId,
          'currentProtocol': _currentProtocol!.toJson(),
          'progressScore': progressScore,
          'userFeedback': userFeedback,
          'recentUsage': _nrtService.nrtUsage
              .where((usage) => usage.timestamp.isAfter(
                  DateTime.now().subtract(const Duration(days: 14))))
              .map((u) => u.toJson())
              .toList(),
          'withdrawalSymptoms': _withdrawalSymptoms
              .where((s) => s.timestamp.isAfter(
                  DateTime.now().subtract(const Duration(days: 7))))
              .map((s) => s.toJson())
              .toList(),
        },
        serverId: 'health-data-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        final adjustedProtocol = NRTProtocol.fromJson(response.data);
        _currentProtocol = adjustedProtocol;
        _protocolController.add(adjustedProtocol);
        
        // Update intelligent schedule
        await _generateIntelligentSchedule(userId, adjustedProtocol);
        
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error adjusting protocol: $e');
    }
  }

  /// Get readiness indicators for dosage reduction
  Future<NRTReadinessAssessment> assessReductionReadiness(String userId) async {
    try {
      final recentSymptoms = _withdrawalSymptoms
          .where((s) => s.timestamp.isAfter(
              DateTime.now().subtract(const Duration(days: 7))))
          .toList();

      final recentUsage = _nrtService.nrtUsage
          .where((usage) => usage.timestamp.isAfter(
              DateTime.now().subtract(const Duration(days: 7))))
          .toList();

      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'assess_reduction_readiness',
        params: {
          'userId': userId,
          'currentProtocol': _currentProtocol?.toJson(),
          'recentSymptoms': recentSymptoms.map((s) => s.toJson()).toList(),
          'recentUsage': recentUsage.map((u) => u.toJson()).toList(),
          'usageTrend': _nrtService.getUsageTrend(7),
        },
        serverId: 'health-data-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        return NRTReadinessAssessment.fromJson(response.data);
      }

      // Fallback assessment
      return _fallbackReadinessAssessment(recentSymptoms, recentUsage);
    } catch (e) {
      debugPrint('Error assessing reduction readiness: $e');
      return NRTReadinessAssessment(
        isReady: false,
        readinessScore: 0.0,
        reasons: ['Error assessing readiness'],
        recommendedWaitDays: 7,
      );
    }
  }

  // Helper methods

  Future<UserHealthProfile> _getUserHealthProfile(String userId) async {
    // This would typically come from user data or health service
    // For now, return a default profile
    return UserHealthProfile(
      userId: userId,
      quitDate: DateTime.now().subtract(const Duration(days: 30)),
      age: 30,
      vapingDurationMonths: 24,
      dailyUsageLevel: 'medium',
      healthConditions: [],
      fitnessLevel: 'fair',
    );
  }

  Future<void> _loadExistingData(String userId) async {
    // Load existing protocol, reminders, and symptoms from storage
    // Implementation would depend on storage mechanism
  }

  Future<void> _generateIntelligentSchedule(
    String userId,
    NRTProtocol protocol,
  ) async {
    // Generate intelligent schedule based on protocol and user patterns
    _intelligentSchedule = NRTIntelligentSchedule(
      id: _uuid.v4(),
      userId: userId,
      protocol: protocol,
      generatedAt: DateTime.now(),
      adaptiveReminders: [],
      progressMilestones: [],
    );
  }

  double _calculateSymptomSeverity(List<WithdrawalSymptom> symptoms) {
    if (symptoms.isEmpty) return 0.0;
    
    final totalSeverity = symptoms.fold<int>(0, (sum, symptom) => sum + symptom.severity);
    return totalSeverity / symptoms.length / 10.0; // Normalize to 0-1
  }

  NRTDosageSchedule? _getCurrentProtocolStep() {
    if (_currentProtocol == null) return null;
    
    final now = DateTime.now();
    // Find current step based on timeline
    // This is a simplified implementation
    return _currentProtocol!.dosageSchedule.first;
  }

  NRTDosageRecommendation _fallbackDosageCalculation(
    NRTDosageSchedule? currentStep,
    double symptomSeverity,
  ) {
    // Simple fallback calculation
    final baseDosage = currentStep?.dosage ?? '14mg';
    final adjustment = symptomSeverity > 0.7 ? 'increase' : 'maintain';
    
    return NRTDosageRecommendation(
      recommendedDosage: baseDosage,
      adjustment: adjustment,
      confidence: 0.6,
      reasoning: 'Fallback calculation based on symptom severity',
      nextReviewDate: DateTime.now().add(const Duration(days: 3)),
    );
  }

  Future<UsagePatterns> _analyzeUsagePatterns(String userId) async {
    final usage = _nrtService.nrtUsage;
    
    // Analyze patterns (simplified)
    final hourlyUsage = <int, int>{};
    for (final record in usage) {
      final hour = record.timestamp.hour;
      hourlyUsage[hour] = (hourlyUsage[hour] ?? 0) + 1;
    }

    return UsagePatterns(
      preferredTimes: hourlyUsage.entries
          .where((e) => e.value > 2)
          .map((e) => e.key)
          .toList(),
      averageDaily: usage.length / 30.0, // Simplified
      consistency: 0.8, // Simplified
    );
  }

  Future<List<NRTReminder>> _generateIntelligentReminders(
    String userId,
    NRTProtocol protocol,
    UsagePatterns patterns,
  ) async {
    final reminders = <NRTReminder>[];
    
    // Generate reminders based on preferred times and protocol
    for (final hour in patterns.preferredTimes) {
      reminders.add(NRTReminder(
        id: _uuid.v4(),
        userId: userId,
        type: NRTReminderType.dosage,
        scheduledTime: DateTime.now().copyWith(hour: hour, minute: 0),
        message: 'Time for your NRT dose',
        isActive: true,
      ));
    }

    return reminders;
  }

  Future<void> _createUrgentReminder(
    String userId,
    SymptomResponse recommendation,
  ) async {
    final reminder = NRTReminder(
      id: _uuid.v4(),
      userId: userId,
      type: NRTReminderType.urgent,
      scheduledTime: DateTime.now(),
      message: recommendation.message,
      isActive: true,
    );

    _activeReminders.add(reminder);
    _reminderController.add(reminder);
    notifyListeners();
  }

  NRTReadinessAssessment _fallbackReadinessAssessment(
    List<WithdrawalSymptom> symptoms,
    List<NRTModel> usage,
  ) {
    final avgSeverity = symptoms.isEmpty 
        ? 0.0 
        : symptoms.fold<int>(0, (sum, s) => sum + s.severity) / symptoms.length;
    
    final isReady = avgSeverity < 5.0 && usage.length >= 7;
    
    return NRTReadinessAssessment(
      isReady: isReady,
      readinessScore: isReady ? 0.8 : 0.3,
      reasons: isReady 
          ? ['Low withdrawal symptoms', 'Consistent usage pattern']
          : ['High withdrawal symptoms', 'Inconsistent usage'],
      recommendedWaitDays: isReady ? 0 : 7,
    );
  }

  /// Monitor for safety concerns and generate alerts
  Future<void> monitorSafety(String userId) async {
    try {
      final recentUsage = _nrtService.nrtUsage
          .where((usage) => usage.timestamp.isAfter(
              DateTime.now().subtract(const Duration(days: 1))))
          .toList();

      final recentSymptoms = _withdrawalSymptoms
          .where((s) => s.timestamp.isAfter(
              DateTime.now().subtract(const Duration(days: 1))))
          .toList();

      // Check for overdose risk
      if (recentUsage.length > 10) {
        await _createSafetyAlert(
          userId,
          NRTSafetyAlertType.overdoseRisk,
          'Excessive NRT usage detected in the last 24 hours',
          NRTSafetyAlertSeverity.high,
        );
      }

      // Check for severe withdrawal symptoms
      final severeSymptoms = recentSymptoms.where((s) => s.severity >= 8).toList();
      if (severeSymptoms.length >= 3) {
        await _createSafetyAlert(
          userId,
          NRTSafetyAlertType.sideEffectConcern,
          'Multiple severe withdrawal symptoms reported',
          NRTSafetyAlertSeverity.medium,
        );
      }

      // Check for concerning usage patterns
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'monitor_safety_patterns',
        params: {
          'userId': userId,
          'recentUsage': recentUsage.map((u) => u.toJson()).toList(),
          'recentSymptoms': recentSymptoms.map((s) => s.toJson()).toList(),
          'currentProtocol': _currentProtocol?.toJson(),
        },
        serverId: 'smart-nrt-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        final alerts = (response.data['alerts'] as List?)
            ?.map((alert) => NRTSafetyAlert.fromJson(alert))
            .toList() ?? [];
        
        for (final alert in alerts) {
          _safetyAlerts.add(alert);
          _safetyAlertController.add(alert);
        }
      }
    } catch (e) {
      debugPrint('Error monitoring safety: $e');
    }
  }

  /// Generate comprehensive progress report
  Future<NRTProgressReport> generateProgressReport(String userId) async {
    try {
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'generate_progress_report',
        params: {
          'userId': userId,
          'currentProtocol': _currentProtocol?.toJson(),
          'allUsage': _nrtService.nrtUsage.map((u) => u.toJson()).toList(),
          'allSymptoms': _withdrawalSymptoms.map((s) => s.toJson()).toList(),
          'activeReminders': _activeReminders.map((r) => r.toJson()).toList(),
          'safetyAlerts': _safetyAlerts.map((a) => a.toJson()).toList(),
        },
        serverId: 'smart-nrt-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        return NRTProgressReport.fromJson(response.data);
      }

      // Fallback report generation
      return _generateFallbackProgressReport(userId);
    } catch (e) {
      debugPrint('Error generating progress report: $e');
      return _generateFallbackProgressReport(userId);
    }
  }

  /// Predict success probability using AI models
  Future<NRTSuccessPrediction> predictSuccessProbability(String userId) async {
    try {
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'predict_success_probability',
        params: {
          'userId': userId,
          'currentProtocol': _currentProtocol?.toJson(),
          'usageHistory': _nrtService.nrtUsage.map((u) => u.toJson()).toList(),
          'symptomHistory': _withdrawalSymptoms.map((s) => s.toJson()).toList(),
          'adherenceScore': _calculateAdherenceScore(),
          'timeOnProtocol': _getTimeOnProtocol(),
        },
        serverId: 'smart-nrt-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        return NRTSuccessPrediction.fromJson(response.data);
      }

      // Fallback prediction
      return _generateFallbackSuccessPrediction(userId);
    } catch (e) {
      debugPrint('Error predicting success: $e');
      return _generateFallbackSuccessPrediction(userId);
    }
  }

  /// Get medical evidence for current recommendations
  Future<List<MedicalEvidence>> getMedicalEvidence(String query) async {
    try {
      final response = await _mcpManager.sendRequest(MCPRequest(
        id: _uuid.v4(),
        method: 'get_medical_evidence',
        params: {'query': query},
        serverId: 'smart-nrt-server',
      ));

      if (response.error == null && response.data.isNotEmpty) {
        return (response.data['evidence'] as List?)
            ?.map((e) => MedicalEvidence.fromJson(e))
            .toList() ?? [];
      }

      return [];
    } catch (e) {
      debugPrint('Error getting medical evidence: $e');
      return [];
    }
  }

  /// Acknowledge safety alert
  Future<void> acknowledgeSafetyAlert(String alertId, String userResponse) async {
    final alertIndex = _safetyAlerts.indexWhere((alert) => alert.id == alertId);
    if (alertIndex != -1) {
      final updatedAlert = _safetyAlerts[alertIndex].copyWith(
        acknowledged: true,
        acknowledgedAt: DateTime.now(),
        userResponse: userResponse,
      );
      _safetyAlerts[alertIndex] = updatedAlert;
      notifyListeners();
    }
  }

  // Helper methods for new functionality

  Future<void> _createSafetyAlert(
    String userId,
    NRTSafetyAlertType type,
    String message,
    NRTSafetyAlertSeverity severity,
  ) async {
    final alert = NRTSafetyAlert(
      id: _uuid.v4(),
      userId: userId,
      type: type,
      message: message,
      severity: severity,
      createdAt: DateTime.now(),
    );

    _safetyAlerts.add(alert);
    _safetyAlertController.add(alert);
    notifyListeners();
  }

  NRTProgressReport _generateFallbackProgressReport(String userId) {
    final now = DateTime.now();
    final quitDate = _currentProtocol != null 
        ? now.subtract(const Duration(days: 30)) 
        : now;
    
    final daysOnNRT = now.difference(quitDate).inDays;
    final avgSymptomSeverity = _withdrawalSymptoms.isEmpty 
        ? 0.0 
        : _withdrawalSymptoms.fold<int>(0, (sum, s) => sum + s.severity) / _withdrawalSymptoms.length;

    return NRTProgressReport(
      userId: userId,
      generatedAt: now,
      summary: NRTProgressSummary(
        daysOnNRT: daysOnNRT,
        initialDosage: 21.0,
        currentDosage: 14.0,
        reductionPercentage: 33.3,
        symptomsReported: _withdrawalSymptoms.length,
        averageSymptomSeverity: avgSymptomSeverity,
        milestonesAchieved: 2,
      ),
      metrics: [
        NRTProgressMetric(
          name: 'Adherence Rate',
          value: _calculateAdherenceScore(),
          unit: '%',
          trend: 'improving',
          description: 'Consistency in following NRT protocol',
        ),
        NRTProgressMetric(
          name: 'Symptom Severity',
          value: avgSymptomSeverity,
          unit: '/10',
          trend: avgSymptomSeverity < 5 ? 'improving' : 'stable',
          description: 'Average severity of withdrawal symptoms',
        ),
      ],
      achievements: [
        'Started NRT protocol',
        'Consistent usage for 1 week',
      ],
      recommendations: [
        'Continue current dosage',
        'Monitor withdrawal symptoms',
        'Consider reduction in 1 week',
      ],
      overallScore: 0.75,
      nextReviewDate: now.add(const Duration(days: 7)),
    );
  }

  NRTSuccessPrediction _generateFallbackSuccessPrediction(String userId) {
    final adherenceScore = _calculateAdherenceScore();
    final avgSymptomSeverity = _withdrawalSymptoms.isEmpty 
        ? 0.0 
        : _withdrawalSymptoms.fold<int>(0, (sum, s) => sum + s.severity) / _withdrawalSymptoms.length;

    double successProbability = 0.5; // Base probability
    
    // Adjust based on adherence
    if (adherenceScore > 80) successProbability += 0.2;
    else if (adherenceScore < 50) successProbability -= 0.2;
    
    // Adjust based on symptoms
    if (avgSymptomSeverity < 4) successProbability += 0.15;
    else if (avgSymptomSeverity > 7) successProbability -= 0.15;

    successProbability = successProbability.clamp(0.0, 1.0);

    return NRTSuccessPrediction(
      userId: userId,
      successProbability: successProbability,
      positiveFactors: [
        if (adherenceScore > 80) 'High adherence to protocol',
        if (avgSymptomSeverity < 4) 'Low withdrawal symptoms',
        if (_withdrawalSymptoms.length < 5) 'Few reported symptoms',
      ],
      riskFactors: [
        if (adherenceScore < 50) 'Low adherence to protocol',
        if (avgSymptomSeverity > 7) 'High withdrawal symptoms',
        if (_safetyAlerts.isNotEmpty) 'Safety concerns reported',
      ],
      recommendations: [
        'Continue following your personalized protocol',
        'Track symptoms regularly',
        'Consult healthcare provider if concerns arise',
      ],
      predictionDate: DateTime.now(),
      predictionHorizonDays: 30,
    );
  }

  double _calculateAdherenceScore() {
    // Simple adherence calculation based on expected vs actual usage
    // In a real implementation, this would be more sophisticated
    final expectedUsagePerDay = 1; // Simplified
    final actualUsagePerDay = _nrtService.nrtUsage.length / 30.0; // Last 30 days
    
    return (actualUsagePerDay / expectedUsagePerDay * 100).clamp(0.0, 100.0);
  }

  int _getTimeOnProtocol() {
    if (_currentProtocol == null) return 0;
    // This would typically be stored when protocol is created
    return DateTime.now().difference(DateTime.now().subtract(const Duration(days: 30))).inDays;
  }

  /// Get intelligent reminders for today
  List<NRTReminder> getTodaysReminders() {
    final today = DateTime.now();
    return _activeReminders.where((reminder) {
      return reminder.isActive &&
             reminder.scheduledTime.year == today.year &&
             reminder.scheduledTime.month == today.month &&
             reminder.scheduledTime.day == today.day;
    }).toList()..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
  }

  /// Get recent withdrawal symptoms (last 7 days)
  List<WithdrawalSymptom> getRecentSymptoms() {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return _withdrawalSymptoms
        .where((symptom) => symptom.timestamp.isAfter(sevenDaysAgo))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Get unacknowledged safety alerts
  List<NRTSafetyAlert> getUnacknowledgedAlerts() {
    return _safetyAlerts.where((alert) => !alert.acknowledged).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Complete a reminder
  Future<void> completeReminder(String reminderId, String? userResponse) async {
    final reminderIndex = _activeReminders.indexWhere((r) => r.id == reminderId);
    if (reminderIndex != -1) {
      final updatedReminder = _activeReminders[reminderIndex].copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
        userResponse: userResponse,
      );
      _activeReminders[reminderIndex] = updatedReminder;
      notifyListeners();
    }
  }

  /// Get adherence statistics
  Map<String, dynamic> getAdherenceStats() {
    final last30Days = DateTime.now().subtract(const Duration(days: 30));
    final recentUsage = _nrtService.nrtUsage
        .where((usage) => usage.timestamp.isAfter(last30Days))
        .toList();

    final expectedUsagePerDay = 1; // Simplified
    final actualDays = recentUsage.length;
    final expectedDays = 30;
    
    final adherenceRate = (actualDays / expectedDays * 100).clamp(0.0, 100.0);
    
    return {
      'adherenceRate': adherenceRate,
      'actualDays': actualDays,
      'expectedDays': expectedDays,
      'streak': _calculateCurrentStreak(),
      'longestStreak': _calculateLongestStreak(),
    };
  }

  int _calculateCurrentStreak() {
    final sortedUsage = _nrtService.nrtUsage
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    int streak = 0;
    DateTime? lastDate;
    
    for (final usage in sortedUsage) {
      final usageDate = DateTime(
        usage.timestamp.year,
        usage.timestamp.month,
        usage.timestamp.day,
      );
      
      if (lastDate == null) {
        lastDate = usageDate;
        streak = 1;
      } else {
        final daysDiff = lastDate.difference(usageDate).inDays;
        if (daysDiff == 1) {
          streak++;
          lastDate = usageDate;
        } else {
          break;
        }
      }
    }
    
    return streak;
  }

  int _calculateLongestStreak() {
    final sortedUsage = _nrtService.nrtUsage
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    int longestStreak = 0;
    int currentStreak = 0;
    DateTime? lastDate;
    
    for (final usage in sortedUsage) {
      final usageDate = DateTime(
        usage.timestamp.year,
        usage.timestamp.month,
        usage.timestamp.day,
      );
      
      if (lastDate == null) {
        currentStreak = 1;
        lastDate = usageDate;
      } else {
        final daysDiff = usageDate.difference(lastDate).inDays;
        if (daysDiff == 1) {
          currentStreak++;
        } else {
          longestStreak = max(longestStreak, currentStreak);
          currentStreak = 1;
        }
        lastDate = usageDate;
      }
    }
    
    return max(longestStreak, currentStreak);
  }

  /// Get symptom trends over time
  Map<String, dynamic> getSymptomTrends() {
    final last30Days = DateTime.now().subtract(const Duration(days: 30));
    final recentSymptoms = _withdrawalSymptoms
        .where((symptom) => symptom.timestamp.isAfter(last30Days))
        .toList();

    if (recentSymptoms.isEmpty) {
      return {
        'averageSeverity': 0.0,
        'trend': 'stable',
        'mostCommonSymptom': null,
        'improvementRate': 0.0,
      };
    }

    // Calculate average severity
    final totalSeverity = recentSymptoms.fold<int>(0, (sum, s) => sum + s.severity);
    final averageSeverity = totalSeverity / recentSymptoms.length;

    // Calculate trend (comparing first half vs second half of period)
    final midPoint = last30Days.add(const Duration(days: 15));
    final firstHalf = recentSymptoms
        .where((s) => s.timestamp.isBefore(midPoint))
        .toList();
    final secondHalf = recentSymptoms
        .where((s) => s.timestamp.isAfter(midPoint))
        .toList();

    String trend = 'stable';
    if (firstHalf.isNotEmpty && secondHalf.isNotEmpty) {
      final firstHalfAvg = firstHalf.fold<int>(0, (sum, s) => sum + s.severity) / firstHalf.length;
      final secondHalfAvg = secondHalf.fold<int>(0, (sum, s) => sum + s.severity) / secondHalf.length;
      
      if (secondHalfAvg < firstHalfAvg - 0.5) {
        trend = 'improving';
      } else if (secondHalfAvg > firstHalfAvg + 0.5) {
        trend = 'worsening';
      }
    }

    // Find most common symptom
    final symptomCounts = <WithdrawalSymptomType, int>{};
    for (final symptom in recentSymptoms) {
      symptomCounts[symptom.type] = (symptomCounts[symptom.type] ?? 0) + 1;
    }
    
    WithdrawalSymptomType? mostCommonSymptom;
    int maxCount = 0;
    symptomCounts.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommonSymptom = type;
      }
    });

    return {
      'averageSeverity': averageSeverity,
      'trend': trend,
      'mostCommonSymptom': mostCommonSymptom,
      'totalSymptoms': recentSymptoms.length,
    };
  }

  /// Schedule next reminder based on intelligent algorithms
  Future<void> scheduleNextReminder(String userId) async {
    try {
      final usagePatterns = await _analyzeUsagePatterns(userId);
      final nextOptimalTime = _calculateNextOptimalReminderTime(usagePatterns);
      
      final reminder = NRTReminder(
        id: _uuid.v4(),
        userId: userId,
        type: NRTReminderType.dosage,
        scheduledTime: nextOptimalTime,
        message: 'Time for your NRT dose - you\'re doing great!',
        isActive: true,
      );

      _activeReminders.add(reminder);
      _reminderController.add(reminder);
      notifyListeners();
    } catch (e) {
      debugPrint('Error scheduling next reminder: $e');
    }
  }

  DateTime _calculateNextOptimalReminderTime(UsagePatterns patterns) {
    final now = DateTime.now();
    final preferredHours = patterns.preferredTimes;
    
    if (preferredHours.isEmpty) {
      // Default to next hour if no patterns
      return now.add(const Duration(hours: 1));
    }

    // Find next preferred time
    final currentHour = now.hour;
    final nextHour = preferredHours.firstWhere(
      (hour) => hour > currentHour,
      orElse: () => preferredHours.first, // Next day
    );

    if (nextHour > currentHour) {
      return DateTime(now.year, now.month, now.day, nextHour, 0);
    } else {
      // Next day
      final tomorrow = now.add(const Duration(days: 1));
      return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, nextHour, 0);
    }
  }

  /// Export user data for sharing with healthcare providers
  Future<Map<String, dynamic>> exportHealthcareData(String userId) async {
    try {
      final progressReport = await generateProgressReport(userId);
      final adherenceStats = getAdherenceStats();
      final symptomTrends = getSymptomTrends();
      
      return {
        'userId': userId,
        'exportDate': DateTime.now().toIso8601String(),
        'currentProtocol': _currentProtocol?.toJson(),
        'progressReport': progressReport.toJson(),
        'adherenceStats': adherenceStats,
        'symptomTrends': symptomTrends,
        'recentSymptoms': _withdrawalSymptoms
            .where((s) => s.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 30))))
            .map((s) => s.toJson())
            .toList(),
        'safetyAlerts': _safetyAlerts
            .where((a) => a.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30))))
            .map((a) => a.toJson())
            .toList(),
      };
    } catch (e) {
      debugPrint('Error exporting healthcare data: $e');
      rethrow;
    }
  }

  /// Cleanup resources
  Future<void> dispose() async {
    await _protocolController.close();
    await _reminderController.close();
    await _symptomController.close();
    await _safetyAlertController.close();
    super.dispose();
  }
}