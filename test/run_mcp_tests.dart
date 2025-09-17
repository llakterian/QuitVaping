#!/usr/bin/env dart

import 'dart:io';

/// Test runner for MCP automated testing suite
/// 
/// This script runs all MCP-related tests and generates a comprehensive report
/// covering unit tests, integration tests, performance tests, and safety tests.
void main(List<String> args) async {
  print('🚀 Starting MCP Automated Testing Suite');
  print('=' * 50);
  
  final testResults = <String, TestResult>{};
  
  // Define test suites to run
  final testSuites = [
    TestSuite(
      name: 'MCP Client Service Unit Tests',
      file: 'test/mcp_client_service_test.dart',
      category: 'Unit Tests',
      description: 'Tests for MCP client functionality, connection management, and request handling',
    ),
    TestSuite(
      name: 'MCP Manager Service Unit Tests', 
      file: 'test/mcp_manager_service_test.dart',
      category: 'Unit Tests',
      description: 'Tests for high-level MCP orchestration and service coordination',
    ),
    TestSuite(
      name: 'MCP Cache Service Unit Tests',
      file: 'test/mcp_cache_service_test.dart', 
      category: 'Unit Tests',
      description: 'Tests for caching, offline functionality, and data synchronization',
    ),
    TestSuite(
      name: 'MCP Error Handling Unit Tests',
      file: 'test/mcp_error_handling_test.dart',
      category: 'Unit Tests', 
      description: 'Tests for error handling, retry logic, and service degradation',
    ),
    TestSuite(
      name: 'AI Workflow Integration Tests',
      file: 'test/ai_workflow_integration_test.dart',
      category: 'Integration Tests',
      description: 'End-to-end tests for AI agent workflows and MCP service integration',
    ),
    TestSuite(
      name: 'MCP Performance Tests',
      file: 'test/mcp_performance_test.dart',
      category: 'Performance Tests',
      description: 'Performance benchmarks, response time validation, and load testing',
    ),
    TestSuite(
      name: 'AI Content Safety Tests',
      file: 'test/ai_content_safety_test.dart',
      category: 'Safety Tests',
      description: 'Content appropriateness, bias detection, and safety validation',
    ),
    TestSuite(
      name: 'Comprehensive Test Suite',
      file: 'test/mcp_comprehensive_test_suite.dart',
      category: 'Integration Tests',
      description: 'Complete test suite validation and coverage verification',
    ),
  ];
  
  print('📋 Test Suites to Execute:');
  for (final suite in testSuites) {
    print('  • ${suite.name} (${suite.category})');
  }
  print('');
  
  // Run each test suite
  for (final suite in testSuites) {
    print('🧪 Running: ${suite.name}');
    print('   Category: ${suite.category}');
    print('   Description: ${suite.description}');
    
    final result = await runTestSuite(suite);
    testResults[suite.name] = result;
    
    if (result.success) {
      print('   ✅ PASSED (${result.duration.inMilliseconds}ms)');
    } else {
      print('   ❌ FAILED (${result.duration.inMilliseconds}ms)');
      if (result.errorOutput.isNotEmpty) {
        print('   Error: ${result.errorOutput}');
      }
    }
    print('');
  }
  
  // Generate comprehensive report
  generateTestReport(testResults);
  
  // Exit with appropriate code
  final allPassed = testResults.values.every((result) => result.success);
  exit(allPassed ? 0 : 1);
}

/// Runs a single test suite and returns the result
Future<TestResult> runTestSuite(TestSuite suite) async {
  final stopwatch = Stopwatch()..start();
  
  try {
    // Check if test file exists
    final testFile = File(suite.file);
    if (!await testFile.exists()) {
      return TestResult(
        success: false,
        duration: stopwatch.elapsed,
        errorOutput: 'Test file not found: ${suite.file}',
      );
    }
    
    // Run the test using flutter test
    final result = await Process.run(
      'flutter',
      ['test', suite.file, '--reporter=json'],
      workingDirectory: Directory.current.path,
    );
    
    stopwatch.stop();
    
    return TestResult(
      success: result.exitCode == 0,
      duration: stopwatch.elapsed,
      output: result.stdout.toString(),
      errorOutput: result.stderr.toString(),
    );
    
  } catch (e) {
    stopwatch.stop();
    return TestResult(
      success: false,
      duration: stopwatch.elapsed,
      errorOutput: 'Exception running test: $e',
    );
  }
}

/// Generates a comprehensive test report
void generateTestReport(Map<String, TestResult> results) {
  print('📊 MCP Test Suite Report');
  print('=' * 50);
  
  final categories = <String, List<String>>{};
  final totalTests = results.length;
  final passedTests = results.values.where((r) => r.success).length;
  final failedTests = totalTests - passedTests;
  
  // Group results by category
  for (final entry in results.entries) {
    final testName = entry.key;
    final result = entry.value;
    
    String category = 'Other';
    if (testName.contains('Unit Tests')) category = 'Unit Tests';
    else if (testName.contains('Integration Tests')) category = 'Integration Tests';
    else if (testName.contains('Performance Tests')) category = 'Performance Tests';
    else if (testName.contains('Safety Tests')) category = 'Safety Tests';
    
    categories.putIfAbsent(category, () => []);
    categories[category]!.add('${result.success ? "✅" : "❌"} $testName');
  }
  
  // Print summary
  print('📈 Summary:');
  print('  Total Test Suites: $totalTests');
  print('  Passed: $passedTests');
  print('  Failed: $failedTests');
  print('  Success Rate: ${(passedTests / totalTests * 100).toStringAsFixed(1)}%');
  print('');
  
  // Print results by category
  for (final entry in categories.entries) {
    print('📂 ${entry.key}:');
    for (final test in entry.value) {
      print('  $test');
    }
    print('');
  }
  
  // Print performance summary
  final totalDuration = results.values.fold<Duration>(
    Duration.zero,
    (sum, result) => sum + result.duration,
  );
  
  print('⏱️  Performance Summary:');
  print('  Total Execution Time: ${totalDuration.inMilliseconds}ms');
  print('  Average Test Suite Time: ${(totalDuration.inMilliseconds / totalTests).round()}ms');
  
  final slowestTest = results.entries.reduce(
    (a, b) => a.value.duration > b.value.duration ? a : b,
  );
  print('  Slowest Test Suite: ${slowestTest.key} (${slowestTest.value.duration.inMilliseconds}ms)');
  
  // Print failures if any
  if (failedTests > 0) {
    print('');
    print('❌ Failed Test Details:');
    for (final entry in results.entries) {
      if (!entry.value.success) {
        print('  • ${entry.key}:');
        if (entry.value.errorOutput.isNotEmpty) {
          print('    ${entry.value.errorOutput}');
        }
      }
    }
  }
  
  print('');
  print('🎯 Test Coverage Areas Validated:');
  print('  • MCP Client Functionality');
  print('  • Service Orchestration');
  print('  • Caching and Offline Support');
  print('  • Error Handling and Recovery');
  print('  • AI Workflow Integration');
  print('  • Performance Benchmarks');
  print('  • Content Safety Validation');
  print('  • End-to-End Workflows');
  
  print('');
  if (passedTests == totalTests) {
    print('🎉 All MCP tests passed! The automated testing suite is comprehensive and working correctly.');
  } else {
    print('⚠️  Some tests failed. Please review the failures above and fix the issues.');
  }
  
  print('=' * 50);
}

/// Represents a test suite to be executed
class TestSuite {
  final String name;
  final String file;
  final String category;
  final String description;
  
  TestSuite({
    required this.name,
    required this.file,
    required this.category,
    required this.description,
  });
}

/// Represents the result of running a test suite
class TestResult {
  final bool success;
  final Duration duration;
  final String output;
  final String errorOutput;
  
  TestResult({
    required this.success,
    required this.duration,
    this.output = '',
    this.errorOutput = '',
  });
}