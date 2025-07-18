import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:masarat/core/helpers/constants.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/widgets/instructor_drawer.dart';
import 'package:masarat/core/widgets/student_drawer.dart';

/// A custom drawer that selects the appropriate drawer implementation based on user role.
/// This widget handles the logic of determining whether to show the instructor-specific drawer
/// or the student-specific drawer.
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  // Static test field for development/testing purposes
  // This will be ignored when actual user role is available from storage
  static String? testUserRole;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? _userRole;
  bool _isLoading = true;

  // Helper method to decode base64 URL safe string
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }

    // Convert from base64
    try {
      return Uri.decodeComponent(String.fromCharCodes(
        base64Decode(output),
      ));
    } catch (e) {
      log('Error decoding base64: $e');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    // Load user role when widget initializes
    _loadUserRole();
  }

  // Load user role asynchronously
  Future<void> _loadUserRole() async {
    try {
      // Check if user is logged in first
      final token =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
      log('Retrieved token from secure storage: ${token != null ? "exists (${token.substring(0, 20)}...)" : "null"}');

      // If no token, user is not logged in, default to student
      if (token == null || token.isEmpty) {
        log('User is not logged in, defaulting to student drawer');
        if (mounted) {
          setState(() {
            _userRole = 'student';
            _isLoading = false;
          });
        }
        return;
      }

      // Get user role from secure storage
      final storedRole =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userRole);
      log('Retrieved role from secure storage: ${storedRole ?? "null"}');

      // Try to extract role from JWT if no explicit role is stored
      String? roleFromToken;
      if ((storedRole == null || storedRole.isEmpty) && token.isNotEmpty) {
        try {
          final parts = token.split('.');
          if (parts.length > 1) {
            // Decode the payload part of the JWT token
            final payload = _decodeBase64(parts[1]);
            log('JWT payload: $payload');
            if (payload.contains('"role"')) {
              final roleStart = payload.indexOf('"role"') + 7;
              final roleEnd = payload.indexOf('"', roleStart + 1);
              if (roleStart > 0 && roleEnd > roleStart) {
                roleFromToken = payload.substring(roleStart + 1, roleEnd);
                log('Extracted role from JWT: $roleFromToken');
              }
            }
          }
        } catch (e) {
          log('Error extracting role from JWT: $e');
        }
      }

      if (mounted) {
        setState(() {
          // Use role with this priority: 1. Stored role, 2. JWT role, 3. Default student
          _userRole = (storedRole != null && storedRole.isNotEmpty)
              ? storedRole
              : (roleFromToken != null)
                  ? roleFromToken
                  : 'student';
          _isLoading = false;
        });
      }

      log('Final selected user role: $_userRole');
    } catch (e) {
      log('Error loading user role: $e', error: e);
      if (mounted) {
        setState(() {
          _userRole = 'student'; // Default to student on error
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while fetching user role
    if (_isLoading) {
      return const Drawer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Get the user role, with fallback options:
    // 1. Use actual user role from storage if available
    // 2. Use test role if provided (for development/testing)
    // 3. Default to 'student' as fallback
    final String userRole = _userRole ?? CustomDrawer.testUserRole ?? 'student';

    // Log the user role for debugging purposes
    log('Rendering drawer for user role: $userRole');

    // Return different drawer based on role
    if (userRole == 'instructor' || userRole == 'trainer') {
      return const InstructorDrawer();
    } else {
      return const StudentDrawer();
    }
  }
}
