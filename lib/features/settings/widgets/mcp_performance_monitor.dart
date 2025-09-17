import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';

/// Widget that displays MCP performance statistics and optimization metrics
class MCPPerformanceMonitor extends StatefulWidget {
  const MCPPerformanceMonitor({Key? key}) : super(key: key);

  @override
  State<MCPPerformanceMonitor> createState() => _MCPPerformanceMonitorState();
}

class _MCPPerformanceMonitorState extends State<MCPPerformanceMonitor> {
  Map<String, Map<String, dynamic>> _performanceStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPerformanceStats();
    
    // Refresh stats every 30 seconds
    Future.delayed(Duration(seconds: 30), () {
      if (mounted) {
        _loadPerformanceStats();
      }
    });
  }

  Future<void> _loadPerformanceStats() async {
    try {
      final mcpManager = Provider.of<MCPManagerService?>(context, listen: false);
      if (mcpManager != null) {
        final stats = mcpManager.getPerformanceStats();
        if (mounted) {
          setState(() {
            _performanceStats = stats;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Performance Monitor',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (_performanceStats.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Performance Monitor',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              Text(
                'No performance data available yet',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Performance Monitor',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _loadPerformanceStats,
                  tooltip: 'Refresh Stats',
                ),
              ],
            ),
            SizedBox(height: 16),
            ..._performanceStats.entries.map((entry) => _buildPerformanceCard(
              context,
              entry.key,
              entry.value,
            )),
            SizedBox(height: 16),
            _buildOverallSummary(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard(
    BuildContext context,
    String requestType,
    Map<String, dynamic> metrics,
  ) {
    final totalRequests = metrics['totalRequests'] as int;
    final avgResponseTime = metrics['averageResponseTime'] as double;
    final cacheHitRate = metrics['cacheHitRate'] as double;
    final errorRate = metrics['errorRate'] as double;
    final p95ResponseTime = metrics['p95ResponseTime'] as int;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatRequestType(requestType),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  context,
                  'Requests',
                  totalRequests.toString(),
                  Icons.analytics,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  context,
                  'Avg Time',
                  '${avgResponseTime.toStringAsFixed(0)}ms',
                  Icons.timer,
                  color: _getResponseTimeColor(avgResponseTime),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  context,
                  'Cache Hit',
                  '${cacheHitRate.toStringAsFixed(1)}%',
                  Icons.cached,
                  color: _getCacheHitColor(cacheHitRate),
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  context,
                  'P95 Time',
                  '${p95ResponseTime}ms',
                  Icons.speed,
                  color: _getResponseTimeColor(p95ResponseTime.toDouble()),
                ),
              ),
            ],
          ),
          if (errorRate > 0) ...[
            SizedBox(height: 8),
            _buildMetricItem(
              context,
              'Error Rate',
              '${errorRate.toStringAsFixed(1)}%',
              Icons.error,
              color: Colors.red,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? Theme.of(context).iconTheme.color,
        ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverallSummary(BuildContext context) {
    final totalRequests = _performanceStats.values
        .fold<int>(0, (sum, metrics) => sum + (metrics['totalRequests'] as int));
    
    final avgCacheHitRate = _performanceStats.values.isEmpty
        ? 0.0
        : _performanceStats.values
            .fold<double>(0.0, (sum, metrics) => sum + (metrics['cacheHitRate'] as double)) /
          _performanceStats.values.length;
    
    final avgResponseTime = _performanceStats.values.isEmpty
        ? 0.0
        : _performanceStats.values
            .fold<double>(0.0, (sum, metrics) => sum + (metrics['averageResponseTime'] as double)) /
          _performanceStats.values.length;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Performance',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                context,
                'Total Requests',
                totalRequests.toString(),
                Icons.all_inclusive,
              ),
              _buildSummaryItem(
                context,
                'Avg Cache Hit',
                '${avgCacheHitRate.toStringAsFixed(1)}%',
                Icons.cached,
                color: _getCacheHitColor(avgCacheHitRate),
              ),
              _buildSummaryItem(
                context,
                'Avg Response',
                '${avgResponseTime.toStringAsFixed(0)}ms',
                Icons.timer,
                color: _getResponseTimeColor(avgResponseTime),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color ?? Theme.of(context).iconTheme.color,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  String _formatRequestType(String requestType) {
    switch (requestType) {
      case 'generateMotivationContent':
        return 'Motivation Content';
      case 'getHealthRecoveryTimeline':
        return 'Health Timeline';
      case 'predictCravingIntervention':
        return 'Craving Prediction';
      case 'generateAnalyticsReport':
        return 'Analytics Report';
      default:
        return requestType.replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(1)}',
        ).trim();
    }
  }

  Color _getResponseTimeColor(double responseTime) {
    if (responseTime < 100) return Colors.green;
    if (responseTime < 500) return Colors.orange;
    return Colors.red;
  }

  Color _getCacheHitColor(double cacheHitRate) {
    if (cacheHitRate > 80) return Colors.green;
    if (cacheHitRate > 50) return Colors.orange;
    return Colors.red;
  }
}