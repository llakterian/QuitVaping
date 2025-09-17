import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/mcp_cache_models.dart';
import '../../../data/services/mcp_manager_service.dart';
import '../../../data/services/battery_optimization_service.dart';

/// Widget to display cache and battery optimization status
class CacheStatusWidget extends StatefulWidget {
  const CacheStatusWidget({Key? key}) : super(key: key);

  @override
  State<CacheStatusWidget> createState() => _CacheStatusWidgetState();
}

class _CacheStatusWidgetState extends State<CacheStatusWidget> {
  MCPCacheStats? _cacheStats;
  BatteryOptimizationStatus? _batteryStatus;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final mcpManager = context.read<MCPManagerService>();
      final cacheStats = await mcpManager.getCacheStats();
      final batteryStatus = mcpManager.getBatteryStatus();
      
      setState(() {
        _cacheStats = cacheStats;
        _batteryStatus = batteryStatus;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cache & Battery Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Connectivity Status
            _buildStatusRow(
              'Connection Status',
              _cacheStats?.isOnline == true ? 'Online' : 'Offline',
              _cacheStats?.isOnline == true ? Colors.green : Colors.orange,
            ),
            
            // Cache Statistics
            if (_cacheStats != null) ...[
              const SizedBox(height: 8),
              _buildStatusRow(
                'Cached Responses',
                '${_cacheStats!.totalEntries}',
                Colors.blue,
              ),
              _buildStatusRow(
                'Offline Content',
                '${_cacheStats!.offlineContentEntries}',
                Colors.purple,
              ),
              _buildStatusRow(
                'Sync Queue',
                '${_cacheStats!.syncQueueEntries}',
                Colors.amber,
              ),
            ],
            
            // Battery Status
            if (_batteryStatus != null) ...[
              const SizedBox(height: 16),
              Text(
                'Battery Optimization',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _buildStatusRow(
                'Battery Level',
                '${_batteryStatus!.batteryLevel}%',
                _getBatteryColor(_batteryStatus!.batteryLevel),
              ),
              _buildStatusRow(
                'Low Power Mode',
                _batteryStatus!.isLowPowerMode ? 'Enabled' : 'Disabled',
                _batteryStatus!.isLowPowerMode ? Colors.orange : Colors.green,
              ),
              _buildStatusRow(
                'Background Sync',
                _batteryStatus!.backgroundSyncEnabled ? 'Enabled' : 'Disabled',
                _batteryStatus!.backgroundSyncEnabled ? Colors.green : Colors.grey,
              ),
            ],
            
            // Recommendations
            if (_batteryStatus?.recommendations.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Text(
                'Recommendations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ..._batteryStatus!.recommendations.map(
                (recommendation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Action Buttons
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _clearCache,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Cache'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _loadStatus,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel > 50) return Colors.green;
    if (batteryLevel > 20) return Colors.orange;
    return Colors.red;
  }

  Future<void> _clearCache() async {
    try {
      final mcpManager = context.read<MCPManagerService>();
      await mcpManager.clearCache();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache cleared successfully')),
      );
      
      _loadStatus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear cache: $e')),
      );
    }
  }
}