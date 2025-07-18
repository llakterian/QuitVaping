import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/ai_model.dart';
import '../models/craving_model.dart';
import '../models/user_model.dart';
import 'storage_service.dart';

class AIService extends ChangeNotifier {
  final StorageService _storageService;
  List<AIChatMessage> _chatHistory = [];
  List<AIRecommendation> _recommendations = [];
  AIPatternAnalysis? _patternAnalysis;
  bool _isLoading = false;
  
  final _uuid = Uuid();
  
  AIService(this._storageService) {
    _loadData();
  }
  
  // Getters
  List<AIChatMessage> get chatHistory => _chatHistory;
  List<AIRecommendation> get recommendations => _recommendations;
  AIPatternAnalysis? get patternAnalysis => _patternAnalysis;
  bool get isLoading => _isLoading;
  
  // Load AI data from storage
  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();
    
    _chatHistory = _storageService.getChatMessages();
    _recommendations = _storageService.getAIRecommendations();
    _patternAnalysis = _storageService.getPatternAnalysis();
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Send message to AI assistant
  Future<AIChatMessage> sendMessage(String message) async {
    _isLoading = true;
    notifyListeners();
    
    // Create user message
    final userMessage = AIChatMessage(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      content: message,
      sender: 'user',
    );
    
    // Add to chat history
    _chatHistory.add(userMessage);
    
    // TODO: In a real implementation, this would call an AI service API
    // For now, we'll simulate a response
    final aiResponse = await _simulateAIResponse(message);
    
    // Add AI response to chat history
    _chatHistory.add(aiResponse);
    
    // Save updated chat history
    await _storageService.saveChatMessages(_chatHistory);
    
    _isLoading = false;
    notifyListeners();
    
    return aiResponse;
  }
  
  // Simulate AI response (in a real app, this would call an API)
  Future<AIChatMessage> _simulateAIResponse(String userMessage) async {
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple intent detection
    String intent = 'general';
    String response = '';
    
    final lowerMessage = userMessage.toLowerCase();
    
    if (lowerMessage.contains('craving') || 
        lowerMessage.contains('urge') || 
        lowerMessage.contains('want to vape')) {
      intent = 'craving_support';
      response = 'I understand you\'re experiencing a craving right now. Remember that cravings typically last 3-5 minutes. Try taking deep breaths or drinking a glass of water. Would you like me to guide you through a quick breathing exercise?';
    } else if (lowerMessage.contains('relapse') || 
               lowerMessage.contains('slip up') || 
               lowerMessage.contains('failed')) {
      intent = 'relapse_support';
      response = 'A slip-up doesn\'t erase all your progress. It\'s a common part of the quitting journey. What matters most is how you respond now. Would you like to talk about what triggered this and how to prevent it next time?';
    } else if (lowerMessage.contains('benefit') || 
               lowerMessage.contains('health') || 
               lowerMessage.contains('better')) {
      intent = 'health_information';
      response = 'Your body is already healing! Within just 48 hours of quitting, your sense of taste and smell begin to improve. After 72 hours, breathing becomes easier as your bronchial tubes relax. Would you like to know more about the health benefits you\'re gaining?';
    } else if (lowerMessage.contains('motivat') || 
               lowerMessage.contains('inspire') || 
               lowerMessage.contains('encourage')) {
      intent = 'motivation';
      response = 'You\'ve already shown incredible strength by deciding to quit. Each day vape-free is a victory worth celebrating. Remember why you started this journey - for your health, your future, and the people who care about you. You\'ve got this!';
    } else {
      response = 'I\'m here to support your journey to quit vaping. How can I help you today? Whether you need distraction during a craving, information about health benefits, or just someone to talk to, I\'m here for you.';
    }
    
    return AIChatMessage(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      content: response,
      sender: 'ai',
      intent: intent,
      metadata: {
        'confidence': 0.85,
        'processed_at': DateTime.now().toIso8601String(),
      },
    );
  }
  
  // Generate personalized recommendations based on user data and cravings
  Future<List<AIRecommendation>> generateRecommendations(
    UserModel user, 
    List<CravingModel> cravings
  ) async {
    _isLoading = true;
    notifyListeners();
    
    // TODO: In a real implementation, this would use ML to analyze patterns
    // For now, we'll create some sample recommendations
    
    // Sample coping strategies based on most common triggers
    final Map<String, int> triggerCounts = {};
    for (final craving in cravings) {
      final trigger = craving.triggerCategory;
      triggerCounts[trigger] = (triggerCounts[trigger] ?? 0) + 1;
    }
    
    // Find most common trigger
    String? mostCommonTrigger;
    int maxCount = 0;
    triggerCounts.forEach((trigger, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommonTrigger = trigger;
      }
    });
    
    // Create recommendation based on most common trigger
    final recommendation = AIRecommendation(
      id: _uuid.v4(),
      generatedAt: DateTime.now(),
      type: 'coping_strategy',
      title: 'Managing Your Top Trigger: ${mostCommonTrigger ?? "Unknown"}',
      content: _getContentForTrigger(mostCommonTrigger ?? "Unknown"),
      relevanceScore: 0.92,
      triggerContext: mostCommonTrigger,
      actionableSteps: {
        'step1': 'Identify when this trigger is likely to occur',
        'step2': 'Prepare alternative activities in advance',
        'step3': 'Practice the recommended coping strategies',
        'step4': 'Track your success in the app',
      },
      userRated: false,
    );
    
    // Add to recommendations list
    _recommendations.add(recommendation);
    
    // Save to storage
    await _storageService.saveAIRecommendation(recommendation);
    
    _isLoading = false;
    notifyListeners();
    
    return _recommendations;
  }
  
  // Helper method to get content based on trigger type
  String _getContentForTrigger(String? triggerType) {
    switch (triggerType) {
      case 'emotional':
        return 'Emotional triggers like stress, anxiety, or boredom are common reasons for vaping. Try these strategies: practice deep breathing for 2 minutes, use the 5-4-3-2-1 grounding technique, or call a supportive friend. Remember that emotions are temporary, but the benefits of staying vape-free are long-lasting.';
      case 'social':
        return 'Social situations can be challenging when quitting. Consider letting friends know you\'ve quit, having a non-vaping buddy with you, practicing responses to offers, or temporarily avoiding high-risk social settings. Your true friends will support your health journey.';
      case 'environmental':
        return 'Environmental triggers are specific places or situations that make you want to vape. Try rearranging your space, creating new routines, avoiding specific trigger locations temporarily, or using a different route to work/school. Changing your environment can significantly reduce cravings.';
      case 'physical':
        return 'Physical triggers like after meals or with coffee are often deeply ingrained habits. Try substituting with a different activity like brushing teeth after meals, chewing sugar-free gum, using a straw for fidgeting, or taking a quick walk. Your brain will gradually form new associations.';
      default:
        return 'Based on your patterns, we\'ve identified some key triggers for your cravings. Try to be mindful of when and why you experience urges to vape. Having specific strategies ready for these moments can significantly increase your chances of successfully overcoming cravings.';
    }
  }
  
  // Analyze patterns in user's craving data
  Future<AIPatternAnalysis> analyzePatterns(
    String userId,
    List<CravingModel> cravings
  ) async {
    _isLoading = true;
    notifyListeners();
    
    // TODO: In a real implementation, this would use ML to analyze patterns
    // For now, we'll create a sample analysis
    
    // Count triggers by category
    final Map<String, List<String>> triggersByCategory = {
      'emotional': [],
      'social': [],
      'environmental': [],
      'physical': [],
    };
    
    // Count time of day distribution
    final Map<String, double> timeDistribution = {
      'Morning': 0,
      'Afternoon': 0,
      'Evening': 0,
      'Night': 0,
    };
    
    // Track coping strategies and their effectiveness
    final Map<String, int> strategySuccessCount = {};
    final Map<String, int> strategyTotalCount = {};
    
    // Process cravings
    for (final craving in cravings) {
      // Add specific triggers to categories
      if (craving.specificTrigger != null) {
        final category = triggersByCategory[craving.triggerCategory] ?? [];
        if (!category.contains(craving.specificTrigger)) {
          category.add(craving.specificTrigger!);
        }
        triggersByCategory[craving.triggerCategory] = category;
      }
      
      // Add to time distribution
      final timeOfDay = craving.timeOfDay;
      timeDistribution[timeOfDay] = (timeDistribution[timeOfDay] ?? 0) + 1;
      
      // Track coping strategies
      if (craving.copingStrategy != null) {
        strategyTotalCount[craving.copingStrategy!] = 
            (strategyTotalCount[craving.copingStrategy!] ?? 0) + 1;
            
        if (craving.resolved) {
          strategySuccessCount[craving.copingStrategy!] = 
              (strategySuccessCount[craving.copingStrategy!] ?? 0) + 1;
        }
      }
    }
    
    // Normalize time distribution to percentages
    final totalCravings = cravings.length;
    if (totalCravings > 0) {
      timeDistribution.forEach((key, value) {
        timeDistribution[key] = (value / totalCravings) * 100;
      });
    }
    
    // Calculate strategy effectiveness
    final Map<String, double> strategyEffectiveness = {};
    strategyTotalCount.forEach((strategy, count) {
      final successCount = strategySuccessCount[strategy] ?? 0;
      strategyEffectiveness[strategy] = count > 0 ? successCount / count : 0;
    });
    
    // Sort strategies by effectiveness
    final sortedStrategies = strategyEffectiveness.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Get most and least effective strategies
    final mostEffective = sortedStrategies.take(3).map((e) => e.key).toList();
    final leastEffective = sortedStrategies.reversed.take(3).map((e) => e.key).toList();
    
    // Create pattern analysis
    final analysis = AIPatternAnalysis(
      id: _uuid.v4(),
      generatedAt: DateTime.now(),
      userId: userId,
      identifiedPatterns: [
        {
          'type': 'time_of_day',
          'description': 'Your cravings are most common during ${_getHighestTimeOfDay(timeDistribution)}',
          'confidence': 0.85,
        },
        {
          'type': 'trigger_pattern',
          'description': 'Your most common trigger category is ${_getMostCommonTriggerCategory(triggersByCategory)}',
          'confidence': 0.78,
        },
      ],
      triggersByCategory: triggersByCategory,
      timeOfDayDistribution: timeDistribution,
      mostEffectiveStrategies: mostEffective,
      leastEffectiveStrategies: leastEffective,
      customInsights: {
        'average_intensity': _calculateAverageIntensity(cravings),
        'resolution_rate': _calculateResolutionRate(cravings),
        'trend': _calculateTrend(cravings),
      },
    );
    
    // Save to storage
    await _storageService.savePatternAnalysis(analysis);
    _patternAnalysis = analysis;
    
    _isLoading = false;
    notifyListeners();
    
    return analysis;
  }
  
  // Helper methods for pattern analysis
  String _getHighestTimeOfDay(Map<String, double> timeDistribution) {
    String highestTime = 'Morning';
    double maxValue = 0;
    
    timeDistribution.forEach((time, value) {
      if (value > maxValue) {
        maxValue = value;
        highestTime = time;
      }
    });
    
    return highestTime;
  }
  
  String _getMostCommonTriggerCategory(Map<String, List<String>> triggersByCategory) {
    String mostCommon = 'emotional';
    int maxTriggers = 0;
    
    triggersByCategory.forEach((category, triggers) {
      if (triggers.length > maxTriggers) {
        maxTriggers = triggers.length;
        mostCommon = category;
      }
    });
    
    return mostCommon;
  }
  
  double _calculateAverageIntensity(List<CravingModel> cravings) {
    if (cravings.isEmpty) return 0;
    
    final sum = cravings.fold(0, (sum, craving) => sum + (craving.intensity == null ? 0 : craving.intensity));
    return sum / cravings.length;
  }
  
  double _calculateResolutionRate(List<CravingModel> cravings) {
    if (cravings.isEmpty) return 0;
    
    final resolved = cravings.where((c) => c.resolved).length;
    return resolved / cravings.length;
  }
  
  String _calculateTrend(List<CravingModel> cravings) {
    if (cravings.length < 5) return 'insufficient_data';
    
    // Sort by date
    final sortedCravings = List<CravingModel>.from(cravings)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    // Split into two halves
    final midpoint = sortedCravings.length ~/ 2;
    final firstHalf = sortedCravings.sublist(0, midpoint);
    final secondHalf = sortedCravings.sublist(midpoint);
    
    // Calculate average intensity for each half
    final firstAvg = firstHalf.isEmpty ? 0 : firstHalf.fold(0, (sum, c) => sum + (c.intensity == null ? 0 : c.intensity)) / firstHalf.length;
    final secondAvg = secondHalf.isEmpty ? 0 : secondHalf.fold(0, (sum, c) => sum + (c.intensity == null ? 0 : c.intensity)) / secondHalf.length;
    
    // Calculate frequency (cravings per day)
    final firstDays = firstHalf.isNotEmpty && firstHalf.length > 1 ? 
        firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1 : 1;
    final secondDays = secondHalf.isNotEmpty && secondHalf.length > 1 ? 
        secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1 : 1;
    
    final firstFreq = firstHalf.length / (firstDays > 0 ? firstDays : 1);
    final secondFreq = secondHalf.length / (secondDays > 0 ? secondDays : 1);
    
    // Determine trend
    if (secondAvg < firstAvg && secondFreq < firstFreq) {
      return 'improving';
    } else if (secondAvg > firstAvg && secondFreq > firstFreq) {
      return 'worsening';
    } else if (secondAvg < firstAvg) {
      return 'less_intense';
    } else if (secondFreq < firstFreq) {
      return 'less_frequent';
    } else {
      return 'stable';
    }
  }
  
  // Clear AI data
  Future<void> clearData() async {
    _chatHistory = [];
    await _storageService.saveChatMessages(_chatHistory);
    notifyListeners();
  }
}