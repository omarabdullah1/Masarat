class ProfileUpdateError implements Exception {
  final String message;
  final ProfileErrorType type;

  ProfileUpdateError({
    required this.message,
    required this.type,
  });

  @override
  String toString() => message;
}

enum ProfileErrorType { validation, network, server, unknown }
