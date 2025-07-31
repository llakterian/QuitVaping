import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/breathing_exercise_model.dart';
import '../models/breathing_preset_model.dart';

/// Service for managing breathing presets
class BreathingPresetService extends ChangeNotifier {
  /// Shared preferences instance
  final SharedPreferences _prefs;
  
  /// Key for storing presets in shared preferences
  static const String _presetsKey = 'breathing_presets';
  
  /// List of presets
  List<BreathingPresetModel> _presets = [];
  
  /// Creates a new breathing preset service
  BreathingPresetService(this._prefs) {
    _loadPresets();
  }
  
  /// Gets all presets
  List<BreathingPresetModel> get presets => _presets;
  
  /// Gets presets for a specific exercise
  List<BreathingPresetModel> getPresetsForExercise(String exerciseId) {
    return _presets
        .where((preset) => preset.exerciseId == exerciseId)
        .toList();
  }
  
  /// Gets a preset by ID
  BreathingPresetModel? getPresetById(String id) {
    try {
      return _presets.firstWhere((preset) => preset.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Adds a new preset
  Future<BreathingPresetModel> addPreset({
    required String name,
    required String exerciseId,
    required String exerciseName,
    required BreathingPattern pattern,
    String? notes,
    int durationSeconds = 0,
  }) async {
    final preset = BreathingPresetModel.create(
      name: name,
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      pattern: pattern,
      notes: notes,
      durationSeconds: durationSeconds,
    );
    
    _presets.add(preset);
    await _savePresets();
    notifyListeners();
    
    return preset;
  }
  
  /// Updates an existing preset
  Future<BreathingPresetModel?> updatePreset({
    required String id,
    String? name,
    BreathingPattern? pattern,
    String? notes,
    int? durationSeconds,
  }) async {
    final index = _presets.indexWhere((preset) => preset.id == id);
    if (index == -1) return null;
    
    final updatedPreset = _presets[index].copyWith(
      name: name,
      pattern: pattern,
      notes: notes,
      durationSeconds: durationSeconds,
    );
    
    _presets[index] = updatedPreset;
    await _savePresets();
    notifyListeners();
    
    return updatedPreset;
  }
  
  /// Deletes a preset
  Future<bool> deletePreset(String id) async {
    final initialLength = _presets.length;
    _presets.removeWhere((preset) => preset.id == id);
    
    if (_presets.length != initialLength) {
      await _savePresets();
      notifyListeners();
      return true;
    }
    
    return false;
  }
  
  /// Records usage of a preset
  Future<BreathingPresetModel?> recordPresetUsage(String id) async {
    final index = _presets.indexWhere((preset) => preset.id == id);
    if (index == -1) return null;
    
    final updatedPreset = _presets[index].incrementUseCount();
    _presets[index] = updatedPreset;
    await _savePresets();
    notifyListeners();
    
    return updatedPreset;
  }
  
  /// Loads presets from shared preferences
  Future<void> _loadPresets() async {
    final presetsJson = _prefs.getStringList(_presetsKey);
    if (presetsJson == null) return;
    
    try {
      _presets = presetsJson
          .map((json) => BreathingPresetModel.fromJsonString(json))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading presets: $e');
    }
  }
  
  /// Saves presets to shared preferences
  Future<void> _savePresets() async {
    final presetsJson = _presets
        .map((preset) => preset.toJsonString())
        .toList();
    
    await _prefs.setStringList(_presetsKey, presetsJson);
  }
  
  /// Gets a stream of presets for a specific exercise
  Stream<List<BreathingPresetModel>> getPresetsStream(String exerciseId) {
    final controller = StreamController<List<BreathingPresetModel>>();
    
    // Add initial data
    controller.add(getPresetsForExercise(exerciseId));
    
    // Add listener for future updates
    final listener = () {
      controller.add(getPresetsForExercise(exerciseId));
    };
    
    addListener(listener);
    
    // Clean up when done
    controller.onCancel = () {
      removeListener(listener);
      controller.close();
    };
    
    return controller.stream;
  }
}
