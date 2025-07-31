import 'package:flutter/material.dart';
import '../utils/breathing_performance_monitor.dart';
import 'optimized_breathing_animation_widget.dart';

/// A widget that displays device performance information and allows manual selection
/// of animation complexity for testing purposes
class DevicePerformanceInfoWidget extends StatefulWidget {
  /// Whether to show detailed performance metrics
  final bool showDetailedMetrics;
  
  /// Callback when animation complexity is changed
  final Function(AnimationComplexity)? onComplexityChanged;

  /// Creates a new DevicePerformanceInfoWidget
  const DevicePerformanceInfoWidget({
    Key? key,
    this.showDetailedMetrics = false,
    this.onComplexityChanged,
  }) : super(key: key);

  @override
  State<DevicePerformanceInfoWidget> createState() => _DevicePerformanceInfoWidgetState();
}

class _DevicePerformanceInfoWidgetState extends State<DevicePerformanceInfoWidget> {
  // Performance monitor
  final BreathingPerformanceMonitor _performanceMonitor = BreathingPerformanceMonitor.instance;
  
  // Current performance profile
  DevicePerformanceProfile? _performanceProfile;
  
  // Current performance metrics
  PerformanceMetrics? _currentMetrics;
  
  // Selected animation complexity
  AnimationComplexity _selectedComplexity = AnimationComplexity.standard;
  
  // Whether performance monitoring is active
  bool _isMonitoring = false;

  @override
  void initState() {
    super.initState();
    
    // Get initial performance profile
    _loadPerformanceProfile();
    
    // Start monitoring if detailed metrics are requested
    if (widget.showDetailedMetrics) {
      _startMonitoring();
    }
  }
  
  @override
  void didUpdateWidget(DevicePerformanceInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update monitoring if detailed metrics changed
    if (widget.showDetailedMetrics != oldWidget.showDetailedMetrics) {
      if (widget.showDetailedMetrics) {
        _startMonitoring();
      } else {
        _stopMonitoring();
      }
    }
  }
  
  @override
  void dispose() {
    _stopMonitoring();
    super.dispose();
  }
  
  /// Load the performance profile
  Future<void> _loadPerformanceProfile() async {
    final profile = await _performanceMonitor.runPerformanceTest();
    
    if (mounted) {
      setState(() {
        _performanceProfile = profile;
        
        // Set initial complexity based on profile
        _selectedComplexity = _performanceMonitor.getRecommendedSettings().animationComplexity;
      });
    }
  }
  
  /// Start performance monitoring
  void _startMonitoring() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _performanceMonitor.startMonitoring();
    _performanceMonitor.addListener(_onPerformanceUpdate);
  }
  
  /// Stop performance monitoring
  void _stopMonitoring() {
    if (!_isMonitoring) return;
    
    _isMonitoring = false;
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
  
  /// Run a new performance test
  Future<void> _runPerformanceTest() async {
    final profile = await _performanceMonitor.runPerformanceTest();
    
    if (mounted) {
      setState(() {
        _performanceProfile = profile;
      });
    }
  }
  
  /// Change animation complexity
  void _changeComplexity(AnimationComplexity complexity) {
    setState(() {
      _selectedComplexity = complexity;
    });
    
    if (widget.onComplexityChanged != null) {
      widget.onComplexityChanged!(complexity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Performance tier
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Device Performance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_performanceProfile != null)
                  _buildPerformanceBadge(context, _performanceProfile!.tier),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Device info
            if (_performanceProfile != null) ...[
              Text(
                _performanceProfile!.getDescription(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              
              const SizedBox(height: 16),
            ],
            
            // Animation complexity selector
            Text(
              'Animation Complexity',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildComplexityButton(
                  context, 
                  AnimationComplexity.simple, 
                  'Simple',
                ),
                _buildComplexityButton(
                  context, 
                  AnimationComplexity.standard, 
                  'Standard',
                ),
                _buildComplexityButton(
                  context, 
                  AnimationComplexity.advanced, 
                  'Advanced',
                ),
              ],
            ),
            
            // Detailed metrics
            if (widget.showDetailedMetrics && _currentMetrics != null) ...[
              const SizedBox(height: 16),
              
              Text(
                'Live Metrics',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              
              const SizedBox(height: 8),
              
              _buildMetricsTable(context, _currentMetrics!),
            ],
            
            const SizedBox(height: 16),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _runPerformanceTest,
                  child: const Text('Run Test'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    final recommended = _performanceMonitor.getRecommendedSettings();
                    _changeComplexity(recommended.animationComplexity);
                  },
                  child: const Text('Use Recommended'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Build a performance badge
  Widget _buildPerformanceBadge(BuildContext context, DevicePerformanceTier tier) {
    Color color;
    String label;
    
    switch (tier) {
      case DevicePerformanceTier.high:
        color = Colors.green;
        label = 'High';
        break;
      case DevicePerformanceTier.medium:
        color = Colors.orange;
        label = 'Medium';
        break;
      case DevicePerformanceTier.low:
        color = Colors.red;
        label = 'Low';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  /// Build a complexity selection button
  Widget _buildComplexityButton(
    BuildContext context, 
    AnimationComplexity complexity, 
    String label,
  ) {
    final isSelected = _selectedComplexity == complexity;
    
    return ElevatedButton(
      onPressed: () => _changeComplexity(complexity),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected 
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceVariant,
        foregroundColor: isSelected 
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      child: Text(label),
    );
  }
  
  /// Build metrics table
  Widget _buildMetricsTable(BuildContext context, PerformanceMetrics metrics) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1.0),
      },
      children: [
        _buildMetricRow('Frame Rate', '${metrics.frameRate.toStringAsFixed(1)} fps'),
        _buildMetricRow('Frame Time', '${metrics.frameTime.toStringAsFixed(1)} ms'),
        _buildMetricRow('Dropped Frames', '${(metrics.droppedFrameRate * 100).toStringAsFixed(1)}%'),
        _buildMetricRow('Memory Usage', '${metrics.memoryUsage.toStringAsFixed(1)} MB'),
      ],
    );
  }
  
  /// Build a metric row
  TableRow _buildMetricRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            value,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}