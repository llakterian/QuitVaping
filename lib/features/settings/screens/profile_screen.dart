import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/services/user_service.dart';
import '../../../shared/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _quitDate;
  String _selectedGender = 'Male';
  int _dailyFrequency = 10;
  int _nicotineStrength = 20;
  double _yearsVaping = 2.0;
  String _deviceType = 'Pod System';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final userService = Provider.of<UserService>(context, listen: false);
    final user = userService.currentUser;

    if (user != null) {
      setState(() {
        _nameController.text = user.name ?? '';
        _emailController.text = user.email ?? '';
        _quitDate = user.quitDate;
        _selectedGender = user.gender ?? 'Male';
        
        if (user.vapingHistory != null) {
          _dailyFrequency = user.vapingHistory!.dailyFrequency;
          _nicotineStrength = user.vapingHistory!.nicotineStrength;
          _yearsVaping = user.vapingHistory!.yearsVaping;
          _deviceType = user.vapingHistory!.deviceType;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primary.withOpacity(0.2),
                            child: Text(
                              _getInitials(),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Personal Information
                    _buildSectionHeader('Personal Information'),
                    
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Gender selection
                    const Text('Gender'),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Male'),
                        const SizedBox(width: 16),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Female'),
                        const SizedBox(width: 16),
                        Radio<String>(
                          value: 'Other',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Other'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Quit Journey
                    _buildSectionHeader('Quit Journey'),
                    
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Quit Date'),
                      subtitle: Text(
                        _quitDate != null
                            ? DateFormat('MMMM d, yyyy').format(_quitDate!)
                            : 'Not set',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _quitDate ?? DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        
                        if (date != null) {
                          setState(() {
                            _quitDate = date;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Vaping History
                    _buildSectionHeader('Vaping History'),
                    
                    const Text('Daily vaping frequency'),
                    Slider(
                      value: _dailyFrequency.toDouble(),
                      min: 1,
                      max: 50,
                      divisions: 49,
                      label: '$_dailyFrequency times/day',
                      onChanged: (value) {
                        setState(() {
                          _dailyFrequency = value.round();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    const Text('Nicotine strength (mg)'),
                    Slider(
                      value: _nicotineStrength.toDouble(),
                      min: 0,
                      max: 50,
                      divisions: 50,
                      label: '${_nicotineStrength}mg',
                      onChanged: (value) {
                        setState(() {
                          _nicotineStrength = value.round();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    const Text('Years vaping'),
                    Slider(
                      value: _yearsVaping,
                      min: 0.1,
                      max: 20,
                      divisions: 199,
                      label: _yearsVaping.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _yearsVaping = double.parse(value.toStringAsFixed(1));
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    const Text('Device type'),
                    DropdownButtonFormField<String>(
                      value: _deviceType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Pod System',
                          child: Text('Pod System'),
                        ),
                        DropdownMenuItem(
                          value: 'Vape Pen',
                          child: Text('Vape Pen'),
                        ),
                        DropdownMenuItem(
                          value: 'Box Mod',
                          child: Text('Box Mod'),
                        ),
                        DropdownMenuItem(
                          value: 'Disposable',
                          child: Text('Disposable'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _deviceType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 2,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  String _getInitials() {
    final name = _nameController.text;
    if (name.isEmpty) return '?';
    
    final parts = name.split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        final userService = Provider.of<UserService>(context, listen: false);
        
        await userService.updateProfile(
          name: _nameController.text,
          email: _emailController.text,
          gender: _selectedGender,
          quitDate: _quitDate,
          dailyFrequency: _dailyFrequency,
          nicotineStrength: _nicotineStrength,
          yearsVaping: _yearsVaping,
          deviceType: _deviceType,
        );
        
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }
}