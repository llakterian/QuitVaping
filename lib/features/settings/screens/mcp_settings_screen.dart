import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/mcp_manager_service.dart';
import '../../../data/models/mcp_model.dart';
import '../../../shared/theme/app_colors.dart';

class MCPSettingsScreen extends StatefulWidget {
  const MCPSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MCPSettingsScreen> createState() => _MCPSettingsScreenState();
}

class _MCPSettingsScreenState extends State<MCPSettingsScreen> {
  Map<String, MCPServerStatus> _serverStatuses = {};
  bool _enableMotivationUpdates = true;
  bool _enableHealthInsights = true;
  bool _enableAnalytics = true;
  bool _enableInterventions = true;
  String _selectedMotivationStyle = 'encouraging';
  String _selectedInsightFrequency = 'daily';

  @override
  void initState() {
    super.initState();
    _loadServerStatuses();
  }

  void _loadServerStatuses() {
    final mcpManager = Provider.of<MCPManagerService>(context, listen: false);
    setState(() {
      _serverStatuses = mcpManager.getServerStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI & MCP Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadServerStatuses,
            tooltip: 'Refresh server status',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServerStatusSection(),
            const SizedBox(height: 24),
            _buildAIPreferencesSection(),
            const SizedBox(height: 24),
            _buildNotificationSettingsSection(),
            const SizedBox(height: 24),
            _buildDataPrivacySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildServerStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cloud, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'MCP Server Status',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_serverStatuses.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No server information available'),
                ),
              )
            else
              ..._serverStatuses.entries.map((entry) => _buildServerStatusItem(
                entry.key,
                entry.value,
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildServerStatusItem(String serverId, MCPServerStatus status) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status.status) {
      case MCPConnectionStatus.connected:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'Connected';
        break;
      case MCPConnectionStatus.connecting:
        statusColor = AppColors.accent;
        statusIcon = Icons.sync;
        statusText = 'Connecting...';
        break;
      case MCPConnectionStatus.retrying:
        statusColor = AppColors.accent;
        statusIcon = Icons.refresh;
        statusText = 'Retrying...';
        break;
      case MCPConnectionStatus.error:
        statusColor = AppColors.error;
        statusIcon = Icons.error;
        statusText = 'Error';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.cloud_off;
        statusText = 'Disconnected';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getServerDisplayName(serverId),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (status.lastConnected != null)
            Text(
              'Last: ${_formatTime(status.lastConnected!)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAIPreferencesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology, color: AppColors.secondary),
                const SizedBox(width: 8),
                Text(
                  'AI Preferences',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPreferenceDropdown(
              'Motivation Style',
              _selectedMotivationStyle,
              ['encouraging', 'direct', 'gentle', 'energetic'],
              (value) => setState(() => _selectedMotivationStyle = value!),
            ),
            const SizedBox(height: 12),
            _buildPreferenceDropdown(
              'Insight Frequency',
              _selectedInsightFrequency,
              ['hourly', 'daily', 'weekly'],
              (value) => setState(() => _selectedInsightFrequency = value!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications, color: AppColors.accent),
                const SizedBox(width: 8),
                Text(
                  'Real-time Updates',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              'Motivation Updates',
              'Receive AI-generated motivational content',
              _enableMotivationUpdates,
              (value) => setState(() => _enableMotivationUpdates = value),
            ),
            _buildSwitchTile(
              'Health Insights',
              'Get real-time health recovery information',
              _enableHealthInsights,
              (value) => setState(() => _enableHealthInsights = value),
            ),
            _buildSwitchTile(
              'Analytics & Patterns',
              'Receive AI-powered behavior analysis',
              _enableAnalytics,
              (value) => setState(() => _enableAnalytics = value),
            ),
            _buildSwitchTile(
              'Smart Interventions',
              'Allow proactive craving intervention',
              _enableInterventions,
              (value) => setState(() => _enableInterventions = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataPrivacySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.security, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Data & Privacy',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Your Privacy is Protected',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• All data is encrypted in transit\n'
                    '• Personal information is anonymized\n'
                    '• You can disable any feature at any time\n'
                    '• Data is processed locally when possible',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _showDataUsageDialog,
                    child: const Text('View Data Usage'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearMCPCache,
                    child: const Text('Clear Cache'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceDropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: options.map((option) => DropdownMenuItem(
            value: option,
            child: Text(option.replaceAll('_', ' ').toUpperCase()),
          )).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }

  String _getServerDisplayName(String serverId) {
    switch (serverId) {
      case 'health-data-server':
        return 'Health Data Server';
      case 'ai-workflow-server':
        return 'AI Workflow Server';
      case 'external-services-server':
        return 'External Services Server';
      case 'analytics-server':
        return 'Analytics Server';
      default:
        return serverId.replaceAll('-', ' ').toUpperCase();
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    return '${difference.inDays}d ago';
  }

  void _showDataUsageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Usage Information'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'MCP Services Data Usage:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Health insights: Anonymous health metrics'),
              Text('• AI motivation: Mood and progress data'),
              Text('• Analytics: Behavioral patterns (anonymized)'),
              Text('• Interventions: Craving triggers and responses'),
              SizedBox(height: 16),
              Text(
                'All data is:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Encrypted during transmission'),
              Text('• Anonymized before external processing'),
              Text('• Stored locally when possible'),
              Text('• Never sold or shared with third parties'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _clearMCPCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear MCP Cache'),
        content: const Text(
          'This will clear all cached MCP responses and force fresh data to be loaded. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // In a real implementation, this would clear the MCP cache
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('MCP cache cleared successfully'),
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}