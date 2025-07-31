import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/breathing_preset_model.dart';
import 'package:quit_vaping/data/services/breathing_preset_service.dart';
import 'package:quit_vaping/shared/theme/app_colors.dart';
import 'package:quit_vaping/shared/widgets/empty_state.dart';

/// A widget that displays a list of breathing presets for quick selection
class BreathingPresetList extends StatefulWidget {
  /// Callback when a preset is selected
  final Function(BreathingPresetModel) onPresetSelected;
  
  /// Whether to show a horizontal list (true) or vertical list (false)
  final bool horizontal;
  
  /// Maximum number of presets to show
  final int? maxPresets;
  
  /// Filter presets by exercise ID
  final String? exerciseId;
  
  /// Create a breathing preset list
  const BreathingPresetList({
    Key? key,
    required this.onPresetSelected,
    this.horizontal = true,
    this.maxPresets,
    this.exerciseId,
  }) : super(key: key);

  @override
  State<BreathingPresetList> createState() => _BreathingPresetListState();
}

class _BreathingPresetListState extends State<BreathingPresetList> {
  List<BreathingPresetModel> _presets = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadPresets();
  }
  
  Future<void> _loadPresets() async {
    setState(() {
      _isLoading = true;
    });
    
    final presetService = Provider.of<BreathingPresetService>(context, listen: false);
    List<BreathingPresetModel> presets;
    
    if (widget.exerciseId != null) {
      presets = await presetService.getPresetsByExercise(widget.exerciseId!);
    } else {
      presets = await presetService.getPresets();
    }
    
    if (widget.maxPresets != null && presets.length > widget.maxPresets!) {
      presets = presets.sublist(0, widget.maxPresets);
    }
    
    if (mounted) {
      setState(() {
        _presets = presets;
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (_presets.isEmpty) {
      return EmptyState(
        icon: Icons.bookmark_outline,
        title: 'No saved presets',
        message: 'Save your favorite breathing patterns for quick access',
      );
    }
    
    if (widget.horizontal) {
      return SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _presets.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return _PresetCard(
              preset: _presets[index],
              onTap: () => widget.onPresetSelected(_presets[index]),
            );
          },
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _presets.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return _PresetListItem(
            preset: _presets[index],
            onTap: () => widget.onPresetSelected(_presets[index]),
          );
        },
      );
    }
  }
}

/// A card widget for displaying a preset in a horizontal list
class _PresetCard extends StatelessWidget {
  final BreathingPresetModel preset;
  final VoidCallback onTap;
  
  const _PresetCard({
    Key? key,
    required this.preset,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(right: 12, bottom: 4, top: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                preset.name,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                preset.exerciseName,
                style: theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _buildPatternInfo(theme),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPatternInfo(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          size: 14,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          '${preset.durationSeconds ~/ 60} min',
          style: theme.textTheme.bodySmall,
        ),
        const Spacer(),
        _buildPatternText(theme),
      ],
    );
  }
  
  Widget _buildPatternText(ThemeData theme) {
    final pattern = preset.pattern;
    return Text(
      '${pattern.inhaleSeconds}-${pattern.inhaleHoldSeconds}-${pattern.exhaleSeconds}-${pattern.exhaleHoldSeconds}',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// A list item widget for displaying a preset in a vertical list
class _PresetListItem extends StatelessWidget {
  final BreathingPresetModel preset;
  final VoidCallback onTap;
  
  const _PresetListItem({
    Key? key,
    required this.preset,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      preset.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      preset.exerciseName,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPatternText(theme),
                  const SizedBox(height: 4),
                  Text(
                    '${preset.durationSeconds ~/ 60} min',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPatternText(ThemeData theme) {
    final pattern = preset.pattern;
    return Text(
      '${pattern.inhaleSeconds}-${pattern.inhaleHoldSeconds}-${pattern.exhaleSeconds}-${pattern.exhaleHoldSeconds}',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}