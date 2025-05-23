import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Helper class for navigation-related operations
class NavigationHelper {
  /// Try to navigate back using multiple methods
  static bool tryGoBack(BuildContext context) {
    bool navigated = false;

    // Method 1: Try Go Router with error handling
    try {
      final router = GoRouter.of(context);
      if (router.canPop()) {
        router.pop();
        debugPrint('✅ NavigationHelper: Successfully used GoRouter.pop()');
        return true;
      }
    } catch (e) {
      debugPrint('❌ NavigationHelper: GoRouter.pop() failed: $e');
    }

    // Method 2: Try standard Navigator
    try {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
        debugPrint('✅ NavigationHelper: Successfully used Navigator.pop()');
        return true;
      }
    } catch (e) {
      debugPrint('❌ NavigationHelper: Navigator.pop() failed: $e');
    }

    // Method 3: Try smarter navigation based on current route
    try {
      final router = GoRouter.of(context);
      // Get the current route info using RouteMatchList
      final location = GoRouterState.of(context).fullPath ?? '';
      debugPrint('Current location: $location');

      // Define common navigation patterns
      if (location == '/signUp') {
        // From signup, go back to login
        router.go('/login');
        debugPrint('✅ NavigationHelper: Navigated from signUp to login');
      } else if (location == '/login') {
        // From login, go back to onboarding
        router.go('/onboarding');
        debugPrint('✅ NavigationHelper: Navigated from login to onboarding');
      } else if (location.startsWith('/home/')) {
        // From a nested route under home, go back to home
        router.go('/home');
        debugPrint('✅ NavigationHelper: Navigated from nested route to home');
      } else if (location.split('/').length > 2) {
        // We're in a multi-level nested route, go to parent
        router.go('..');
        debugPrint('✅ NavigationHelper: Used router.go("..")');
      } else {
        // Default case for other routes
        router.go('/onboarding');
        debugPrint('✅ NavigationHelper: Navigated to onboarding');
      }
      return true;
    } catch (e) {
      debugPrint('❌ NavigationHelper: router.go navigation failed: $e');
    } // Method 4: Try Navigator.maybePop which is safer
    try {
      Navigator.maybePop(context);
      debugPrint(
          '⚠️ NavigationHelper: Used Navigator.maybePop() - result unknown');
      return true; // Assume it worked
    } catch (e) {
      debugPrint('❌ NavigationHelper: Navigator.maybePop failed: $e');
    }

    // Method 5: Last effort try to use browser-like back navigation
    try {
      final router = GoRouter.of(context);
      router.pop();
      debugPrint('⚠️ NavigationHelper: Last attempt with router.pop()');
      return true;
    } catch (e) {
      debugPrint('❌ NavigationHelper: All navigation methods failed: $e');
    }

    return navigated;
  }
}
