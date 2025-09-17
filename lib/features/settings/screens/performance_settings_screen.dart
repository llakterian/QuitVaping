import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';
import '../widgets/mcp_performance_monitor.dart';

/// Screen for viewing and managing MCP performance settings
class PerformanceSettingsScreen extends StatefulWidget {
  const PerformanceSettingsScreen({Key? key}) : super(key: key);

  @override
  State<PerformanceSettingsScreen> createState() => _PerformanceSettingsScreenState();
}

class _PerformanceSettingsScreenState extends State<PerformanceSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showPerformanceInfo(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Performance Overview Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.speed, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Performance Optimization',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your app uses advanced performance optimizations to provide faster, more efficient experiences while reducing battery usage.',
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureList(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Real-time Performance Monitor
            const MCPPerformanceMonitor(),
            
            const SizedBox(height: 16),
            
            // Performance Controls
            _buildPerformanceControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      {
        'icon': Icons.batch_prediction,
        'title': 'Request Batching',
        'description': 'Groups similar requests to reduce server load'
      },
      {
        'icon': Icons.cached,
        'title': 'Smart Caching', 
        'description': 'Stores responses locally for instant access'
      },
      {
        'icon': Icons.analytics,
        'title': 'Performance Metrics',
        'description': 'Tracks and optimizes response times'
      },
      {
        'icon': Icons.battery_saver,
        'title': 'Battery Optimization',
        'description': 'Reduces background operations when battery is low'
      },
    ];

    return Column(
      children: features.map((feature) => ListTile(
        leading: Icon(feature['icon'] as IconData, size: 20),
        title: Text(feature['title'] as String),
        subtitle: Text(feature['description'] as String),
        dense: true,
        contentPadding: EdgeInsets.zero,
      )).toList(),
    );
  }

  Widget _buildPerformanceControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Controls',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Reset Performance Optimizer
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Reset Performance Optimizer'),
              subtitle: const Text('Clear cache and reset performance metrics'),
              trailing: ElevatedButton(
                onPressed: _resetPerformanceOptimizer,
                child: const Text('Reset'),
              ),
            ),
            
            const Divider(),
            
            // View Detailed Stats
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Detailed Performance Stats'),
              subtitle: const Text('View comprehensive performance analytics'),
              trailing: ElevatedButton(
                onPressed: _showDetailedStats,
                child: const Text('View'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPerformanceOptimizer() {
    final mcpManager = Provider.of<MCPManagerService?>(context, listen: false);
    if (mcpManager != null) {
      mcpManager.resetPerformanceOptimizer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Performance optimizer reset successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showDetailedStats() {
    final mcpManager = Provider.of<MCPManagerService?>(context, listen: false);
    if (mcpManager != null) {
      final stats = mcpManager.getPerformanceStats();
      _showStatsDialog(stats);
    }
  }

  void _showStatsDialog(Map<String, Map<String, dynamic>> stats) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Performance Stats'),
        content: SizedBox(
          width: double.maxFinite,
          child: stats.isEmpty
              ? const Text('No performance data available yet.')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: stats.length,
                  itemBuilder: (context, index) {
                    final entry = stats.entries.elementAt(index);
                    final requestType = entry.key;
                    final metrics = entry.value;
                    
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requestType,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            Text('Total Requests: ${metrics['totalRequests']}'),
                            Text('Avg Response Time: ${metrics['averageResponseTime'].toStringAsFixed(1)}ms'),
                            Text('Cache Hit Rate: ${metrics['cacheHitRate'].toStringAsFixed(1)}%'),
                            Text('Error Rate: ${metrics['errorRate'].toStringAsFixed(1)}%'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPerformanceInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Optimization'),
        content: const Text(
          'Your QuitVaping app uses advanced performance optimizations:\n\n'
          '• Request Batching: Groups similar requests together to reduce server load by up to 70%\n\n'
          '• Smart Caching: Stores frequently accessed data locally for instant responses\n\n'
          '• Performance Monitoring: Tracks response times and optimizes automatically\n\n'
          '• Battery Optimization: Reduces background operations when battery is low\n\n'
          'These optimizations work automatically to provide you with the best possible experience.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}