import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../models/mcp_model.dart';

/// MCP Client Service for handling connections to MCP servers
class MCPClientService {
  static const String _configPath = '.kiro/settings/mcp.json';
  static const int _defaultTimeout = 30;
  static const int _maxRetries = 3;
  static const Duration _baseRetryDelay = Duration(seconds: 2);

  final Dio _dio;
  final Map<String, MCPServerConfig> _serverConfigs = {};
  final Map<String, MCPServerStatus> _serverStatuses = {};
  final Map<String, WebSocketChannel?> _connections = {};
  final Map<String, Timer?> _reconnectTimers = {};
  final StreamController<MCPServerStatus> _statusController = 
      StreamController<MCPServerStatus>.broadcast();

  MCPClientService() : _dio = Dio() {
    _initializeDio();
  }

  /// Stream of server status updates
  Stream<MCPServerStatus> get serverStatusStream => _statusController.stream;

  /// Get current status of all servers
  Map<String, MCPServerStatus> get serverStatuses => Map.unmodifiable(_serverStatuses);

  void _initializeDio() {
    _dio.options.connectTimeout = Duration(seconds: _defaultTimeout);
    _dio.options.receiveTimeout = Duration(seconds: _defaultTimeout);
    _dio.options.sendTimeout = Duration(seconds: _defaultTimeout);
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      error: true,
    ));
  }

  /// Initialize MCP client with server configurations
  Future<void> initialize() async {
    try {
      await _loadServerConfigs();
      await _connectToServers();
    } catch (e) {
      debugPrint('Failed to initialize MCP client: $e');
      rethrow;
    }
  }

  /// Load server configurations from mcp.json
  Future<void> _loadServerConfigs() async {
    try {
      // In a real implementation, you would read from the file system
      // For now, we'll use the configuration we created
      final configData = {
        "mcpServers": {
          "health-data-server": {
            "command": "uvx",
            "args": ["postman-health-mcp-server@latest"],
            "env": {
              "FASTMCP_LOG_LEVEL": "ERROR",
              "HEALTH_API_BASE_URL": "https://api.health.gov",
              "MEDICAL_DB_API_KEY": "\${MEDICAL_DB_API_KEY}"
            },
            "disabled": false,
            "autoApprove": ["get_health_recovery_timeline", "get_cessation_benefits", "get_nrt_protocols"]
          },
          "ai-workflow-server": {
            "command": "uvx",
            "args": ["postman-ai-workflow-mcp-server@latest"],
            "env": {
              "FASTMCP_LOG_LEVEL": "ERROR",
              "POSTMAN_AI_AGENT_API_KEY": "\${POSTMAN_AI_AGENT_API_KEY}",
              "OPENAI_API_KEY": "\${OPENAI_API_KEY}"
            },
            "disabled": false,
            "autoApprove": ["generate_motivation_content", "analyze_mood", "create_intervention_plan", "generate_celebration_message"]
          },
          "external-services-server": {
            "command": "uvx",
            "args": ["postman-external-services-mcp-server@latest"],
            "env": {
              "FASTMCP_LOG_LEVEL": "ERROR",
              "WEATHER_API_KEY": "\${WEATHER_API_KEY}",
              "FINANCIAL_API_KEY": "\${FINANCIAL_API_KEY}",
              "COMMUNITY_API_KEY": "\${COMMUNITY_API_KEY}"
            },
            "disabled": false,
            "autoApprove": ["get_weather_data", "get_financial_opportunities", "match_community_peers"]
          },
          "analytics-server": {
            "command": "uvx",
            "args": ["postman-analytics-mcp-server@latest"],
            "env": {
              "FASTMCP_LOG_LEVEL": "ERROR",
              "ANALYTICS_DB_URL": "\${ANALYTICS_DB_URL}"
            },
            "disabled": false,
            "autoApprove": ["analyze_user_patterns", "generate_insights", "predict_quit_success", "create_progress_report"]
          }
        }
      };

      final servers = configData['mcpServers'] as Map<String, dynamic>;
      
      for (final entry in servers.entries) {
        final serverId = entry.key;
        final config = entry.value as Map<String, dynamic>;
        
        _serverConfigs[serverId] = MCPServerConfig(
          serverId: serverId,
          command: config['command'] as String,
          args: List<String>.from(config['args'] as List),
          env: Map<String, String>.from(config['env'] as Map),
          disabled: config['disabled'] as bool? ?? false,
          autoApprove: List<String>.from(config['autoApprove'] as List? ?? []),
        );

        _serverStatuses[serverId] = MCPServerStatus(
          serverId: serverId,
          status: MCPConnectionStatus.disconnected,
          maxRetries: _maxRetries,
        );
      }
    } catch (e) {
      debugPrint('Failed to load MCP server configs: $e');
      rethrow;
    }
  }

  /// Connect to all enabled MCP servers
  Future<void> _connectToServers() async {
    final futures = <Future>[];
    
    for (final config in _serverConfigs.values) {
      if (!config.disabled) {
        futures.add(_connectToServer(config.serverId));
      }
    }
    
    await Future.wait(futures, eagerError: false);
  }

  /// Connect to a specific MCP server with retry logic
  Future<void> _connectToServer(String serverId) async {
    final config = _serverConfigs[serverId];
    if (config == null || config.disabled) return;

    _updateServerStatus(serverId, MCPConnectionStatus.connecting);

    try {
      await retry(
        () => _establishConnection(serverId),
        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: _maxRetries,
        onRetry: (e) {
          debugPrint('Retrying connection to $serverId: $e');
          _updateServerStatus(serverId, MCPConnectionStatus.retrying, 
              error: e.toString());
        },
      );

      _updateServerStatus(serverId, MCPConnectionStatus.connected);
      debugPrint('Successfully connected to MCP server: $serverId');
      
    } catch (e) {
      debugPrint('Failed to connect to MCP server $serverId: $e');
      _updateServerStatus(serverId, MCPConnectionStatus.error, error: e.toString());
      _scheduleReconnect(serverId);
    }
  } 
 /// Establish WebSocket connection to MCP server
  Future<void> _establishConnection(String serverId) async {
    final config = _serverConfigs[serverId]!;
    
    // In a real implementation, you would start the MCP server process
    // and connect via WebSocket. For now, we'll simulate the connection.
    
    // Simulate connection delay
    await Future.delayed(Duration(milliseconds: 500));
    
    // For demo purposes, we'll create a mock WebSocket connection
    // In production, this would be: WebSocketChannel.connect(Uri.parse(serverUrl))
    
    // Store connection reference (null for now as we're mocking)
    _connections[serverId] = null;
  }

  /// Update server status and notify listeners
  void _updateServerStatus(String serverId, MCPConnectionStatus status, {String? error}) {
    final currentStatus = _serverStatuses[serverId];
    if (currentStatus == null) return;

    final newStatus = currentStatus.copyWith(
      status: status,
      error: error,
      lastConnected: status == MCPConnectionStatus.connected ? DateTime.now() : currentStatus.lastConnected,
      retryCount: status == MCPConnectionStatus.retrying ? currentStatus.retryCount + 1 : 0,
    );

    _serverStatuses[serverId] = newStatus;
    _statusController.add(newStatus);
  }

  /// Schedule reconnection attempt for failed server
  void _scheduleReconnect(String serverId) {
    _reconnectTimers[serverId]?.cancel();
    
    _reconnectTimers[serverId] = Timer(Duration(minutes: 5), () {
      debugPrint('Attempting to reconnect to MCP server: $serverId');
      _connectToServer(serverId);
    });
  }

  /// Send request to MCP server with error handling and retry logic
  Future<MCPResponse> sendRequest(MCPRequest request) async {
    final serverId = request.serverId;
    final serverStatus = _serverStatuses[serverId];
    
    if (serverStatus?.status != MCPConnectionStatus.connected) {
      throw MCPException('Server $serverId is not connected');
    }

    try {
      return await retry(
        () => _executeRequest(request),
        retryIf: (e) => e is TimeoutException || e is SocketException,
        maxAttempts: 3,
      );
    } catch (e) {
      debugPrint('Failed to send MCP request to $serverId: $e');
      
      return MCPResponse(
        id: request.id,
        serverId: serverId,
        responseType: MCPResponseType.error,
        data: {'error': e.toString()},
        timestamp: DateTime.now(),
        error: e.toString(),
      );
    }
  } 
 /// Execute MCP request
  Future<MCPResponse> _executeRequest(MCPRequest request) async {
    // In a real implementation, this would send the request via WebSocket
    // and wait for the response. For now, we'll simulate different responses
    // based on the request method.
    
    await Future.delayed(Duration(milliseconds: 200 + Random().nextInt(800)));
    
    return _simulateResponse(request);
  }

  /// Simulate MCP server responses for different request types
  MCPResponse _simulateResponse(MCPRequest request) {
    final responseData = <String, dynamic>{};
    var responseType = MCPResponseType.error;
    
    switch (request.method) {
      case 'get_health_recovery_timeline':
        responseType = MCPResponseType.health;
        responseData.addAll({
          'timeline': [
            {'time': '20 minutes', 'benefit': 'Heart rate and blood pressure drop'},
            {'time': '12 hours', 'benefit': 'Carbon monoxide level normalizes'},
            {'time': '2-12 weeks', 'benefit': 'Circulation improves and lung function increases'},
            {'time': '1-9 months', 'benefit': 'Coughing and shortness of breath decrease'},
          ],
          'personalizedBenefits': [
            'Your lung capacity has improved by 15% since quitting',
            'Your risk of heart disease has decreased by 50%',
          ],
        });
        break;
        
      case 'generate_motivation_content':
        responseType = MCPResponseType.motivation;
        responseData.addAll({
          'content': 'You\'ve made incredible progress! Every day without vaping is a victory for your health and future.',
          'contentType': 'motivational_message',
          'personalizationFactors': ['quit_duration', 'recent_mood', 'weather'],
        });
        break;
        
      case 'analyze_user_patterns':
        responseType = MCPResponseType.analytics;
        responseData.addAll({
          'patterns': [
            {'type': 'craving_trigger', 'factor': 'stress', 'confidence': 0.85},
            {'type': 'success_factor', 'factor': 'morning_routine', 'confidence': 0.92},
          ],
          'recommendations': [
            'Consider stress management techniques during high-stress periods',
            'Continue your successful morning routine as it\'s helping prevent cravings',
          ],
        });
        break;
        
      default:
        responseData['message'] = 'Method not implemented in simulation';
    }
    
    return MCPResponse(
      id: request.id,
      serverId: request.serverId,
      responseType: responseType,
      data: responseData,
      confidence: 0.8 + Random().nextDouble() * 0.2,
      nextActions: [],
      timestamp: DateTime.now(),
    );
  }

  /// Check if a specific server is connected
  bool isServerConnected(String serverId) {
    return _serverStatuses[serverId]?.status == MCPConnectionStatus.connected;
  }

  /// Get list of connected servers
  List<String> getConnectedServers() {
    return _serverStatuses.entries
        .where((entry) => entry.value.status == MCPConnectionStatus.connected)
        .map((entry) => entry.key)
        .toList();
  }

  /// Disconnect from all servers and cleanup
  Future<void> dispose() async {
    // Cancel all reconnect timers
    for (final timer in _reconnectTimers.values) {
      timer?.cancel();
    }
    _reconnectTimers.clear();

    // Close all WebSocket connections
    for (final connection in _connections.values) {
      await connection?.sink.close(status.goingAway);
    }
    _connections.clear();

    // Close status stream
    await _statusController.close();

    // Close Dio client
    _dio.close();
  }
}

/// Custom exception for MCP-related errors
class MCPException implements Exception {
  final String message;
  final String? serverId;
  final dynamic originalError;

  MCPException(this.message, {this.serverId, this.originalError});

  @override
  String toString() => 'MCPException: $message${serverId != null ? ' (Server: $serverId)' : ''}';
}