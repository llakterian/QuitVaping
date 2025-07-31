/// Enum representing different types of NRT (Nicotine Replacement Therapy)
enum NRTType {
  /// Nicotine patch
  patch,
  
  /// Nicotine gum
  gum,
  
  /// Nicotine lozenge
  lozenge,
  
  /// Nicotine inhaler
  inhaler,
  
  /// Nicotine nasal spray
  spray,
  
  /// Other NRT types
  other,
}

/// Extension methods for NRTType
extension NRTTypeExtension on NRTType {
  /// Get a user-friendly name for the NRT type
  String get displayName {
    switch (this) {
      case NRTType.patch:
        return 'Patch';
      case NRTType.gum:
        return 'Gum';
      case NRTType.lozenge:
        return 'Lozenge';
      case NRTType.inhaler:
        return 'Inhaler';
      case NRTType.spray:
        return 'Spray';
      case NRTType.other:
        return 'Other';
    }
  }
  
  /// Convert the NRT type to a string for storage
  String toStorageString() {
    return toString().split('.').last;
  }
  
  /// Create an NRTType from a string
  static NRTType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'patch':
        return NRTType.patch;
      case 'gum':
        return NRTType.gum;
      case 'lozenge':
        return NRTType.lozenge;
      case 'inhaler':
        return NRTType.inhaler;
      case 'spray':
        return NRTType.spray;
      default:
        return NRTType.other;
    }
  }
  
  /// Get the string representation of the NRT type
  String get substring => toStorageString();
}
