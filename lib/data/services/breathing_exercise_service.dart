import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/breathing_exercise_model.dart';

/// Storage adapter for breathing exercises
class BreathingStorageAdapter {
  /// Loads exercises from storage
  Future<List<BreathingExerciseModel>> loadExercises() async {
    return _defaultExercises;
  }
  
  /// Saves exercises to storage
  Future<void> saveExercises(List<BreathingExerciseModel> exercises) async {
    // Not implemented
  }
}

/// Service for managing breathing exercises
class BreathingExerciseService {
  /// Shared preferences instance
  final SharedPreferences _prefs;
  
  /// Storage adapter
  final BreathingStorageAdapter _storageAdapter;
  
  /// List of exercises
  List<BreathingExerciseModel> _exercises = [];
  
  /// Creates a new breathing exercise service
  BreathingExerciseService(this._prefs) : _storageAdapter = BreathingStorageAdapter() {
    _loadExercises();
  }
  
  /// Gets all exercises
  List<BreathingExerciseModel> get exercises => _exercises;
  
  /// Gets an exercise by ID
  BreathingExerciseModel? getExerciseById(String id) {
    try {
      return _exercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Loads exercises from storage
  Future<void> _loadExercises() async {
    try {
      _exercises = await _storageAdapter.loadExercises();
    } catch (e) {
      debugPrint('Error loading exercises: $e');
      _exercises = _defaultExercises;
    }
  }
}

/// Default breathing exercises
final List<BreathingExerciseModel> _defaultExercises = [
  BreathingExerciseModel(
    id: '1',
    name: 'Box Breathing',
    description: 'Box breathing is a technique that helps to regulate the breath and calm the nervous system.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 4,
      exhaleSeconds: 4,
      exhaleHoldSeconds: 4,
    ),
    recommendedDurationMinutes: 5,
    benefits: [
      'Reduces stress',
      'Improves focus',
      'Calms the nervous system',
    ],
    imagePath: 'assets/images/breathing/box_breathing_icon.png',
    isPremium: false,
    tags: ['stress', 'focus', 'calm'],
    benefitsDescription: 'Box breathing helps to regulate the breath and calm the nervous system. It is particularly effective for reducing stress and improving focus.',
  ),
  BreathingExerciseModel(
    id: '2',
    name: '4-7-8 Breathing',
    description: 'The 4-7-8 breathing technique is a breathing pattern developed by Dr. Andrew Weil. It\'s based on pranayama, an ancient yogic practice that helps people relax as it replenishes oxygen in the body.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 7,
      exhaleSeconds: 8,
      exhaleHoldSeconds: 0,
    ),
    recommendedDurationMinutes: 5,
    benefits: [
      'Reduces anxiety',
      'Helps with sleep',
      'Manages cravings',
    ],
    imagePath: 'assets/images/breathing/478_breathing_icon.png',
    isPremium: false,
    tags: ['anxiety', 'sleep', 'cravings'],
    benefitsDescription: 'The 4-7-8 breathing technique is particularly effective for reducing anxiety, helping with sleep, and managing cravings.',
  ),
  BreathingExerciseModel(
    id: '3',
    name: 'Diaphragmatic Breathing',
    description: 'Diaphragmatic breathing, or deep breathing, is a breathing exercise that helps to strengthen the diaphragm, a muscle that plays a crucial role in breathing.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 0,
      exhaleSeconds: 6,
      exhaleHoldSeconds: 0,
    ),
    recommendedDurationMinutes: 10,
    benefits: [
      'Reduces stress',
      'Lowers blood pressure',
      'Improves core muscle stability',
    ],
    imagePath: 'assets/images/breathing/diaphragmatic_breathing_icon.png',
    isPremium: false,
    tags: ['stress', 'relaxation', 'core'],
    benefitsDescription: 'Diaphragmatic breathing helps to reduce stress, lower blood pressure, and improve core muscle stability.',
  ),
  BreathingExerciseModel(
    id: '4',
    name: 'Alternate Nostril Breathing',
    description: 'Alternate nostril breathing is a yogic breath control practice that involves breathing through one nostril at a time while holding the other one closed.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 5,
      inhaleHoldSeconds: 0,
      exhaleSeconds: 5,
      exhaleHoldSeconds: 0,
    ),
    recommendedDurationMinutes: 5,
    benefits: [
      'Balances the nervous system',
      'Improves focus',
      'Reduces stress',
    ],
    imagePath: 'assets/images/breathing/alternate_nostril_icon.png',
    isPremium: true,
    tags: ['balance', 'focus', 'stress'],
    benefitsDescription: 'Alternate nostril breathing helps to balance the nervous system, improve focus, and reduce stress.',
  ),
  BreathingExerciseModel(
    id: '5',
    name: 'Pursed Lip Breathing',
    description: 'Pursed lip breathing is a breathing technique that consists of inhaling through the nose and exhaling through pursed lips.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 2,
      inhaleHoldSeconds: 0,
      exhaleSeconds: 4,
      exhaleHoldSeconds: 0,
    ),
    recommendedDurationMinutes: 5,
    benefits: [
      'Relieves shortness of breath',
      'Improves ventilation',
      'Releases trapped air in the lungs',
    ],
    imagePath: 'assets/images/breathing/pursed_lip_icon.png',
    isPremium: true,
    tags: ['breath', 'lungs', 'ventilation'],
    benefitsDescription: 'Pursed lip breathing helps to relieve shortness of breath, improve ventilation, and release trapped air in the lungs.',
  ),
  BreathingExerciseModel(
    id: '6',
    name: 'Coherent Breathing',
    description: 'Coherent breathing involves breathing at a rate of about five breaths per minute, which has been shown to balance the sympathetic and parasympathetic branches of the nervous system.',
    defaultPattern: const BreathingPattern(
      inhaleSeconds: 6,
      inhaleHoldSeconds: 0,
      exhaleSeconds: 6,
      exhaleHoldSeconds: 0,
    ),
    recommendedDurationMinutes: 10,
    benefits: [
      'Balances the nervous system',
      'Reduces stress',
      'Improves heart rate variability',
    ],
    imagePath: 'assets/images/breathing/coherent_breathing_icon.png',
    isPremium: true,
    tags: ['balance', 'stress', 'heart'],
    benefitsDescription: 'Coherent breathing helps to balance the nervous system, reduce stress, and improve heart rate variability.',
  ),
];
