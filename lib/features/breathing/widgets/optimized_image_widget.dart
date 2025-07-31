import 'package:flutter/material.dart';
import '../utils/breathing_memory_optimizer.dart';

/// A widget that optimizes image loading and memory usage
class OptimizedImageWidget extends StatefulWidget {
  /// The asset path of the image
  final String assetPath;
  
  /// The width of the image
  final double? width;
  
  /// The height of the image
  final double? height;
  
  /// The fit of the image
  final BoxFit fit;
  
  /// Whether to preload the image
  final bool preload;
  
  /// Creates a new OptimizedImageWidget
  const OptimizedImageWidget({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.preload = false,
  }) : super(key: key);

  @override
  State<OptimizedImageWidget> createState() => _OptimizedImageWidgetState();
}

class _OptimizedImageWidgetState extends State<OptimizedImageWidget> {
  bool _isLoaded = false;
  
  @override
  void initState() {
    super.initState();
    
    if (widget.preload) {
      _preloadImage();
    }
  }
  
  @override
  void didUpdateWidget(OptimizedImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.assetPath != widget.assetPath) {
      _isLoaded = false;
      if (widget.preload) {
        _preloadImage();
      }
    }
  }
  
  Future<void> _preloadImage() async {
    await BreathingMemoryOptimizer.instance.preloadAsset(widget.assetPath);
    if (mounted) {
      setState(() {
        _isLoaded = true;
      });
    }
  }
  
  @override
  void dispose() {
    // No need to explicitly release the image here
    // The memory optimizer will handle cleanup based on usage patterns
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.assetPath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      // Use cacheWidth and cacheHeight for memory optimization
      cacheWidth: widget.width != null ? (widget.width! * MediaQuery.of(context).devicePixelRatio).toInt() : null,
      cacheHeight: widget.height != null ? (widget.height! * MediaQuery.of(context).devicePixelRatio).toInt() : null,
      // Use RepaintBoundary to optimize rendering
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return RepaintBoundary(child: child);
      },
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(
            child: Icon(Icons.broken_image),
          ),
        );
      },
    );
  }
}