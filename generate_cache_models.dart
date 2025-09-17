// Simple script to generate cache model files
import 'package:build_runner/build_runner.dart';

void main() async {
  // This will generate the freezed files for cache models
  await build(['lib/data/models/mcp_cache_models.dart']);
}