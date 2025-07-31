import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../utils/breathing_performance_monitor.dart';
import '../widgets/adaptive_breathing_animation.dart';
import '../widgets/device_performance_info_widget.dart';
import '../widgets/optimized_breathing_animation_widget.dart';

/// A screen for demonstrating adaptive animations with different complexity levels
class AdaptiveAnimationDemoScreen extends StatefulWidget {
  /// Creates a new AdaptiveAnimationDemoScreen
  const AdaptiveAnimationDemoScreen({Key? key}) : super(key: key);

  @override
  State<AdaptiveAnimationDemoScreen> createState() => _AdaptiveAnimationDemoScreenState();
}

class _AdaptiveAnimationDemoScreenState extends State<AdaptiveAnimationDemoScreen> {
  // Performance monitor
  final BreathingPerformanceMonitor _performanceMonitor = BreathingPerformanceMonitor.instance;
  
  // Animation state
  bool _isPlaying = true;
  AnimationComplexity _selectedComplexity = AnimationComplexity.standard;
  bool _useAutoAdapt = true;
  
  // Sample breathing pattern
  final BreathingPattern _pattern = const BreathingPattern(
    inhaleSeconds: 4,
    inhaleHoldSeconds: 2,
    exhaleSeconds: 6,
    exhaleHoldSeconds: 2,
  );
  
  // Performance metrics
  PerformanceMetrics? _currentMetrics;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize performance monitoring
    _performanceMonitor.initialize();
    
    // Start monitoring performance
    _startMonitoring();
  }
  
  @override
  void dispose() {
    _stopMonitoring();
    super.dispose();
  }
  
  /// Start performance monitoring
  void _startMonitoring() {
    _performanceMonitor.startMonitoring();
    _performanceMonitor.addListener(_onPerformanceUpdate);
  }
  
  /// Stop performance monitoring
  void _stopMonitoring() {
    _performanceMonitor.stopMonitoring();
    _performanceMonitor.removeListener(_onPerformanceUpdate);
  }
  
  /// Handle performance updates
  void _onPerformanceUpdate(PerformanceMetrics metrics) {
    if (!mounted) return;
    
    setState(() {
      _currentMetrics = metrics;
    });
  }
  
  /// Toggle auto-adapt mode
  void _toggleAutoAdapt() {
    setState(() {
      _useAutoAdapt = !_useAutoAdapt;
      
      if (_useAutoAdapt) {
        // Reset to recommended complexity
        final settings = _performanceMonitor.getRecommendedSettings();
        _selectedComplexity = settings.animationComplexity;
      }
    });
  }
  
  /// Change animation complexity
  void _changeComplexity(AnimationComplexity complexity) {
    setState(() {
      _selectedComplexity = complexity;
      _useAutoAdapt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Animation Demo'),
        actions: [
          // Auto-adapt toggle
          IconButton(
            icon: Icon(
              _useAutoAdapt ? Icons.auto_awesome : Icons.auto_awesome_outlined,
              color: _useAutoAdapt ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: _toggleAutoAdapt,
            tooltip: 'Toggle Auto-Adapt',
          ),
          
          // Play/pause toggle
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            tooltip: _isPlaying ? 'Pause' : 'Play',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Performance info widget
              DevicePerformanceInfoWidget(
                showDetailedMetrics: true,
                onComplexityChanged: _changeComplexity,
              ),
              
              const SizedBox(height: 24),
              
              // Current complexity indicator
              Text(
                'Current Animation: ${_selectedComplexity.toString().split('.').last}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              const SizedBox(height: 8),
              
              // Auto-adapt indicator
              if (_useAutoAdapt)
                Text(
                  'Auto-adapting based on performance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              
              const SizedBox(height: 24),
              
              // Adaptive breathing animation
              Center(
                child: AdaptiveBreathingAnimation(
                  pattern: _pattern,
                  isPlaying: _isPlaying,
                  size: 250,
                  autoAdapt: _useAutoAdapt,
                  complexityOverride: _useAutoAdapt ? null : _selectedComplexity,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Performance metrics
              if (_currentMetrics != null) ...[
                Text(
                  'Live Performance Metrics',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: 8),
                
                // Frame rate
                _buildMetricRow(
                  context,
                  'Frame Rate',
                  '${_currentMetrics!.frameRate.toStringAsFixed(1)} fps',
                  _getFrameRateColor(_currentMetrics!.frameRate),
                ),
                
                // Frame time
                _buildMetricRow(
                  context,
                  'Frame Time',
                  '${_currentMetrics!.frameTime.toStringAsFixed(1)} ms',
                  _getFrameTimeColor(_currentMetrics!.frameTime),
                ),
                
                // Dropped frames
                _buildMetricRow(
                  context,
                  'Dropped Frames',
                  '${(_currentMetrics!.droppedFrameRate * 100).toStringAsFixed(1)}%',
                  _getDropRateColor(_currentMetrics!.droppedFrameRate),
                ),
                
                // Memory usage
                _buildMetricRow(
                  context,
                  'Memory Usage',
                  '${_currentMetrics!.memoryUsage.toStringAsFixed(1)} MB',
                  _getMemoryColor(_currentMetrics!.memoryUsage),
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Complexity comparison
              Text(
                'Complexity Comparison',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              const SizedBox(height: 16),
              
              // Complexity comparison table
              Table(
                border: TableBorder.all(
                  color: Theme.of(context).dividerColor,
                ),
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    children: [
                      _buildTableHeader(context, 'Feature'),
                      _buildTableHeader(context, 'Simple'),
                      _buildTableHeader(context, 'Standard'),
                      _buildTableHeader(context, 'Advanced'),
                    ],
                  ),
                  
                  // Features rows
                  _buildFeatureRow(
                    context, 
                    'Basic Animation', 
                    true, 
                    true, 
                    true
                  ),
                  _buildFeatureRow(
                    context, 
                    'Direction Indicators', 
                    false, 
                    true, 
                    true
                  ),
                  _buildFeatureRow(
                    context, 
                    'Phase Effects', 
                    false, 
                    true, 
                    true
                  ),
                  _buildFeatureRow(
                    context, 
                    'Particle Effects', 
                    false, 
                    false, 
                    true
                  ),
                  _buildFeatureRow(
                    context, 
                    'Frame Rate', 
                    '30 fps', 
                    '45 fps', 
                    '60 fps'
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Build a metric row with color-coded value
  Widget _buildMetricRow(BuildContext context, String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
  
  /// Build a table header cell
  Widget _buildTableHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
  
  /// Build a feature comparison row
  TableRow _buildFeatureRow(BuildContext context, String feature, dynamic simple, dynamic standard, dynamic advanced) {
    return TableRow(
      children: [
        // Feature name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feature),
        ),
        
        // Simple tier
        _buildFeatureCell(context, simple),
        
        // Standard tier
        _buildFeatureCell(context, standard),
        
        // Advanced tier
        _buildFeatureCell(context, advanced),
      ],
    );
  }
  
  /// Build a feature cell
  Widget _buildFeatureCell(BuildContext context, dynamic value) {
    if (value is bool) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Icon(
            value ? Icons.check_circle : Icons.cancel,
            color: value ? Colors.green : Colors.red.withOpacity(0.6),
            size: 20,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value.toString(),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  
  /// Get color for frame rate value
  Color _getFrameRateColor(double frameRate) {
    if (frameRate >= 55) {
      return Colors.green;
    } else if (frameRate >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  /// Get color for frame time value
  Color _getFrameTimeColor(double frameTime) {
    if (frameTime <= 16) {
      return Colors.green;
    } else if (frameTime <= 33) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  /// Get color for drop rate value
  Color _getDropRateColor(double dropRate) {
    if (dropRate <= 0.05) {
      return Colors.green;
    } else if (dropRate <= 0.15) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  /// Get color for memory usage value
  Color _getMemoryColor(double memoryUsage) {
    if (memoryUsage <= 50) {
      return Colors.green;
    } else if (memoryUsage <= 100) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}