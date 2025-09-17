import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Web-compatible banner ad widget
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      debugPrint('BannerAdWidget: Web version - simulating ad load');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Return a placeholder for web demo
      return Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: const Center(
          child: Text(
            '📱 Ad Space (Web Demo)',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    // For non-web platforms, this would return actual banner ads
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    if (kIsWeb) {
      debugPrint('BannerAdWidget: Web version - disposing');
    }
    super.dispose();
  }
}