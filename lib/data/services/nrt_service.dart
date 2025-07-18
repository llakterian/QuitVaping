import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/nrt_model.dart';
import 'storage_service.dart';

class NRTService extends ChangeNotifier {
  static const String _nrtBoxName = 'nrt_box';
  
  final StorageService _storageService; // Used for persistence
  final _uuid = Uuid();
  
  List<NRTModel> _nrtUsage = [];
  NRTScheduleModel? _nrtSchedule;
  bool _isLoading = false;
  
  NRTService(this._storageService) {
    _loadData();
  }
  
  // Getters
  List<NRTModel> get nrtUsage => _nrtUsage;
  NRTScheduleModel? get nrtSchedule => _nrtSchedule;
  bool get isLoading => _isLoading;
  bool get hasSchedule => _nrtSchedule != null;
  
  // Initialize Hive box
  static Future<void> init() async {
    await Hive.openBox(_nrtBoxName);
  }
  
  // Load NRT data from storage
  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final box = Hive.box(_nrtBoxName);
      
      // Load NRT usage records
      final usageData = box.get('nrt_usage');
      if (usageData != null) {
        final List<dynamic> decodedData = jsonDecode(usageData);
        _nrtUsage = decodedData
            .map((data) => NRTModel.fromJson(Map<String, dynamic>.from(data)))
            .toList();
      }
      
      // Load NRT schedule
      final scheduleData = box.get('nrt_schedule');
      if (scheduleData != null) {
        _nrtSchedule = NRTScheduleModel.fromJson(
          Map<String, dynamic>.from(jsonDecode(scheduleData)),
        );
      }
    } catch (e) {
      debugPrint('Error loading NRT data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Record NRT usage
  Future<void> recordNRTUsage({
    required String userId,
    required NRTType type,
    required double nicotineStrength,
    String? notes,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final nrtRecord = NRTModel(
        id: _uuid.v4(),
        userId: userId,
        type: type,
        nicotineStrength: nicotineStrength,
        timestamp: DateTime.now(),
        notes: notes,
      );
      
      _nrtUsage.add(nrtRecord);
      
      // Save to storage
      final box = Hive.box(_nrtBoxName);
      await box.put('nrt_usage', jsonEncode(_nrtUsage.map((e) => e.toJson()).toList()));
    } catch (e) {
      debugPrint('Error recording NRT usage: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Create or update NRT reduction schedule
  Future<void> setNRTSchedule({
    required String userId,
    required NRTType type,
    required double initialStrength,
    required int frequencyPerDay,
    required DateTime startDate,
    required List<NRTStepModel> reductionSteps,
    String? notes,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final schedule = NRTScheduleModel(
        id: _nrtSchedule?.id ?? _uuid.v4(),
        userId: userId,
        type: type,
        initialStrength: initialStrength,
        currentStrength: initialStrength,
        frequencyPerDay: frequencyPerDay,
        startDate: startDate,
        reductionSteps: reductionSteps,
        notes: notes,
      );
      
      _nrtSchedule = schedule;
      
      // Save to storage
      final box = Hive.box(_nrtBoxName);
      await box.put('nrt_schedule', jsonEncode(schedule.toJson()));
    } catch (e) {
      debugPrint('Error setting NRT schedule: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Update current strength in schedule
  Future<void> updateCurrentStrength(double strength) async {
    if (_nrtSchedule == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final updatedSchedule = _nrtSchedule!.copyWith(
        currentStrength: strength,
      );
      
      _nrtSchedule = updatedSchedule;
      
      // Save to storage
      final box = Hive.box(_nrtBoxName);
      await box.put('nrt_schedule', jsonEncode(updatedSchedule.toJson()));
    } catch (e) {
      debugPrint('Error updating NRT strength: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Delete NRT usage record
  Future<void> deleteNRTUsage(String id) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _nrtUsage.removeWhere((record) => record.id == id);
      
      // Save to storage
      final box = Hive.box(_nrtBoxName);
      await box.put('nrt_usage', jsonEncode(_nrtUsage.map((e) => e.toJson()).toList()));
    } catch (e) {
      debugPrint('Error deleting NRT usage: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Delete NRT schedule
  Future<void> deleteNRTSchedule() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _nrtSchedule = null;
      
      // Remove from storage
      final box = Hive.box(_nrtBoxName);
      await box.delete('nrt_schedule');
    } catch (e) {
      debugPrint('Error deleting NRT schedule: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Get NRT usage for a specific day
  List<NRTModel> getNRTUsageForDay(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return _nrtUsage.where((record) {
      final recordDate = DateTime(
        record.timestamp.year,
        record.timestamp.month,
        record.timestamp.day,
      );
      return recordDate == day;
    }).toList();
  }
  
  // Get total nicotine consumed for a specific day
  double getTotalNicotineForDay(DateTime date) {
    final records = getNRTUsageForDay(date);
    return records.fold(0.0, (sum, record) => sum + record.nicotineStrength);
  }
  
  // Get usage trend (increasing, decreasing, stable)
  String getUsageTrend(int days) {
    if (_nrtUsage.length < days) return 'insufficient_data';
    
    // Sort by date
    final sortedUsage = List<NRTModel>.from(_nrtUsage)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    // Group by day
    final Map<String, List<NRTModel>> usageByDay = {};
    for (final record in sortedUsage) {
      final day = '${record.timestamp.year}-${record.timestamp.month}-${record.timestamp.day}';
      final existingRecords = usageByDay[day] ?? [];
      usageByDay[day] = [...existingRecords, record];
    }
    
    // Calculate daily totals
    final List<double> dailyTotals = [];
    usageByDay.forEach((day, records) {
      final total = records.fold(0.0, (sum, record) => sum + record.nicotineStrength);
      dailyTotals.add(total);
    });
    
    // Get only the last 'days' number of days
    final recentTotals = dailyTotals.length > days
        ? dailyTotals.sublist(dailyTotals.length - days)
        : dailyTotals;
    
    if (recentTotals.length < 3) return 'insufficient_data';
    
    // Calculate trend
    double sum = 0;
    for (int i = 1; i < recentTotals.length; i++) {
      sum += recentTotals[i] - recentTotals[i - 1];
    }
    
    final avgChange = sum / (recentTotals.length - 1);
    
    if (avgChange < -0.5) {
      return 'decreasing';
    } else if (avgChange > 0.5) {
      return 'increasing';
    } else {
      return 'stable';
    }
  }
  
  // Clear all NRT data
  Future<void> clearAllData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _nrtUsage = [];
      _nrtSchedule = null;
      
      // Clear storage
      final box = Hive.box(_nrtBoxName);
      await box.clear();
    } catch (e) {
      debugPrint('Error clearing NRT data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}