/// Comprehensive input validation system
class InputValidator {
  /// Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }
    
    if (!email.contains('@') || !email.contains('.')) {
      return 'Please enter a valid email address';
    }
    
    if (email.length > 254) {
      return 'Email is too long (maximum 254 characters)';
    }
    
    return null;
  }

  /// Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (password.length > 128) {
      return 'Password is too long (maximum 128 characters)';
    }
    
    return null;
  }

  /// Confirm password validation
  static String? validateConfirmPassword(String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Name validation
  static String? validateName(String? name, {String fieldName = 'Name'}) {
    if (name == null || name.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    if (name.trim().length < 2) {
      return '$fieldName must be at least 2 characters long';
    }
    
    if (name.trim().length > 50) {
      return '$fieldName is too long (maximum 50 characters)';
    }
    
    return null;
  }

  /// Phone number validation
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    if (digitsOnly.length > 15) {
      return 'Phone number is too long (maximum 15 digits)';
    }
    
    return null;
  }

  /// Team name validation
  static String? validateTeamName(String? teamName) {
    if (teamName == null || teamName.trim().isEmpty) {
      return 'Team name is required';
    }
    
    if (teamName.trim().length < 3) {
      return 'Team name must be at least 3 characters long';
    }
    
    if (teamName.trim().length > 50) {
      return 'Team name is too long (maximum 50 characters)';
    }
    
    return null;
  }

  /// Location validation
  static String? validateLocation(String? location) {
    if (location == null || location.trim().isEmpty) {
      return 'Location is required';
    }
    
    if (location.trim().length < 2) {
      return 'Location must be at least 2 characters long';
    }
    
    if (location.trim().length > 100) {
      return 'Location is too long (maximum 100 characters)';
    }
    
    return null;
  }

  /// Description validation
  static String? validateDescription(String? description, {int maxLength = 500}) {
    if (description == null) {
      return null;
    }
    
    if (description.trim().length > maxLength) {
      return 'Description is too long (maximum $maxLength characters)';
    }
    
    return null;
  }

  /// Check if all validations pass
  static bool isValid(Map<String, String?> validations) {
    return validations.values.every((error) => error == null);
  }
}
