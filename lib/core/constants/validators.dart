class AppValidator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب!';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة!';
    }
    if (value.length < 8) {
      return 'يجب أن تتكون كلمة السر من 8 أحرف على الأقل!';
    }
    return null;
  }

  static String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف'; // "Please enter a phone number"
    }

    // A basic regex for validating phone numbers (adjust to your requirements)
    final RegExp phoneRegExp = RegExp(r'^[0-9]{8,15}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'يرجى إدخال رقم هاتف صحيح'; // "Please enter a valid phone number"
    }

    return null; // Validation passed
  }
}
