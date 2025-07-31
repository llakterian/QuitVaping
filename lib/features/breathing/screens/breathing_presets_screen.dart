import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/breathing_preset_model.dart';
import 'package:quit_vaping/data/services/breathing_preset_service.dart';
import 'package:quit_vaping/features/breathing/screens/breathing_preset_edit_screen.dart';
import 'package:quit_vaping/shared/widgets/empty_state.dart';
import 'package:quit_vaping/shared/widgets/confirm_dialog.dart';

/// Screen for managing breathing presets
class BreathingPresetsScreen extends StatefulWidget {
  /// Create a breathing presets screen
  const BreathingPresetsScreen({Key? key}) : super(key: key);

  @override
  State<BreathingPresetsScreen> createState() => _BreathingPresetsScreenState();
}

class _BreathingPresetsScreenState extends State<BreathingPresetsScreen> {
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
    final presets = await presetService.getPresets();
    
    if (mounted) {
      setState(() {
        _presets = presets;
        _isLoading = false;
      });
    }
  }
  
  Future<void> _deletePreset(BreathingPresetModel preset) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete Preset',
      message: 'Are you sure you want to delete "${preset.name}"? This action cannot be undone.',
      confirmText: 'DELETE',
      isDestructive: true,
    );
    
    if (confirmed != true) return;
    
    final presetService = Provider.of<BreathingPresetService>(context, listen: false);
    await presetService.deletePreset(preset.id);
    
    // Refresh the list
    _loadPresets();
    
    // Show a snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preset "${preset.name}" deleted'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  
  Future<void> _editPreset(BreathingPresetModel preset) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BreathingPresetEditScreen(preset: preset),
      ),
    );
    
    if (result == true) {
      // Refresh the list if the preset was updated
      _loadPresets();
      
      // Show a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preset updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
  
  Future<void> _renamePreset(BreathingPresetModel preset) async {
    final nameController = TextEditingController(text: preset.name);
    
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Preset'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Preset Name',
            hintText: 'Enter a new name',
          ),
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(nameController.text),
            child: const Text('RENAME'),
          ),
        ],
      ),
    );
    
    if (newName == null || newName.isEmpty || newName == preset.name) return;
    
    // Check if name already exists
    final presetService = Provider.of<BreathingPresetService>(context, listen: false);
    final nameExists = await presetService.presetNameExists(newName);
    
    if (nameExists) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A preset with this name already exists'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }
    
    // Update the preset
    final updatedPreset = preset.copyWith(name: newName);
    await presetService.updatePreset(updatedPreset);
    
    // Refresh the list
    _loadPresets();
  }
  
  Future<void> _reorderPresets(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    setState(() {
      final preset = _presets.removeAt(oldIndex);
      _presets.insert(newIndex, preset);
    });
    
    // Update the display order in the service
    final presetService = Provider.of<BreathingPresetService>(context, listen: false);
    await presetService.reorderPresets(_presets.map((p) => p.id).toList());
  }
  
  void _startExercise(BreathingPresetModel preset) {
    Navigator.of(context).pushNamed(
      '/breathing/exercise',
      arguments: {
        'exerciseId': preset.exerciseId,
        'customPattern': preset.pattern,
        'duration': preset.durationSeconds,
        'presetId': preset.id,
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Presets'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }
  
  Widget _buildContent() {
    if (_presets.isEmpty) {
      return EmptyState(
        icon: Icons.bookmark_outline,
        title: 'No saved presets',
        message: 'Save your favorite breathing patterns for quick access',
      );
    }
    
    return RefreshIndicator(
      onRefresh: _loadPresets,
      child: ReorderableListView.builder(
        itemCount: _presets.length,
        onReorder: _reorderPresets,
        itemBuilder: (context, index) {
          final preset = _presets[index];
          return _PresetListItem(
            key: Key(preset.id),
            preset: preset,
            onTap: () => _startExercise(preset),
            onRename: () => _renamePreset(preset),
            onDelete: () => _deletePreset(preset),
          );
        },
      ),
    );
  }
}

class _PresetListItem extends StatelessWidget {
  final BreathingPresetModel preset;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  
  const _PresetListItem({
    Key? key,
    required this.preset,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        context.findAncestorStateOfType<_BreathingPresetsScreenState>()!._editPreset(preset);
                      } else if (value == 'rename') {
                        onRename();
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.tune),
                          title: Text('Edit Pattern'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'rename',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Rename'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildPatternInfo(theme),
                  const Spacer(),
                  Icon(
                    Icons.drag_handle,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPatternInfo(ThemeData theme) {
    final pattern = preset.pattern;
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${pattern.inhaleSeconds}-${pattern.inhaleHoldSeconds}-${pattern.exhaleSeconds}-${pattern.exhaleHoldSeconds}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.timer_outlined,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          '${preset.durationSeconds ~/ 60} min',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (preset.useCount > 0) ...[
          const SizedBox(width: 12),
          Icon(
            Icons.repeat,
            size: 16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            '${preset.useCount} ${preset.useCount == 1 ? 'use' : 'uses'}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}