import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/features/auth/login/presentation/pages/login_screen.dart';
import 'package:masarat/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:masarat/features/cart/presentation/pages/shopping_cart_screen.dart';
import 'package:masarat/features/courses/presentation/pages/course_details_screen.dart';
import 'package:masarat/features/courses/presentation/pages/lecture_details.dart';
import 'package:masarat/features/courses/presentation/pages/lecture_screen.dart';
import 'package:masarat/features/courses/presentation/pages/trainer_course_details_screen.dart';
import 'package:masarat/features/courses/presentation/pages/training_courses_screen.dart';
import 'package:masarat/features/courses/presentation/pages/training_courses_trainer_screen.dart';
import 'package:masarat/features/home/presentation/pages/home_screen.dart';
import 'package:masarat/features/home/presentation/pages/my_library.dart';
import 'package:masarat/features/packages/presentation/pages/career_guidance_screen.dart';
import 'package:masarat/features/packages/presentation/pages/pricing_screen.dart';
import 'package:masarat/features/profile/presentation/pages/profile_screen.dart';
import 'package:masarat/features/settings/presentation/pages/about_us_screen.dart';
import 'package:masarat/features/settings/presentation/pages/policies_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.onboarding, // Start at onboarding
  routes: [
    // Onboarding Route
    GoRoute(
      path: AppRoute.onboarding,
      name: AppRoute.onboarding,
      builder: (context, state) => const ProfessionalTracksApp(),
    ),

    // Login Route
    GoRoute(
      path: AppRoute.login,
      name: AppRoute.login,
      builder: (context, state) {
        final isTrainer = (state.extra as bool?) ?? false;
        return LoginScreen(isTrainer: isTrainer);
      },
    ),

    // Home Route
    GoRoute(
      path: AppRoute.home,
      name: AppRoute.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
      routes: [
        // Nested Routes
        GoRoute(
          path: AppRoute.profile,
          name: AppRoute.profile,
          builder: (context, state) {
            final isTrainer = (state.extra as bool?) ?? false;
            return ProfileScreen(isTrainer: isTrainer);
          },
        ),
        GoRoute(
          path: AppRoute.myLibrary,
          name: AppRoute.myLibrary,
          builder: (context, state) => const MyLibrary(),
        ),
        GoRoute(
          path: AppRoute.policies,
          name: AppRoute.policies,
          builder: (context, state) => const PoliciesScreen(),
        ),
        GoRoute(
          path: AppRoute.aboutUs,
          name: AppRoute.aboutUs,
          builder: (context, state) => const AboutUsScreen(),
        ),
        GoRoute(
          path: AppRoute.shoppingCart,
          name: AppRoute.shoppingCart,
          builder: (context, state) => const ShoppingCartScreen(),
        ),
        GoRoute(
          path: AppRoute.trainingCourses,
          name: AppRoute.trainingCourses,
          builder: (context, state) => const TrainingCoursesScreen(),
          routes: [
            GoRoute(
              path: AppRoute.courseDetails,
              name: AppRoute.courseDetails,
              builder: (context, state) {
                final courseId = state.pathParameters['courseId'];
                return CourseDetailsScreen(courseId: courseId!);
              },
              routes: [
                GoRoute(
                  path: AppRoute.lectureScreen,
                  name: AppRoute.lectureScreen,
                  builder: (context, state) => const LectureScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoute.lectureDetails,
                      name: AppRoute.lectureDetails,
                      builder: (context, state) {
                        final lectureId = state.pathParameters['lectureId'];
                        return LectureDetailsScreen(lectureId: lectureId!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Career Guidance Route
    GoRoute(
      path: AppRoute.careerGuidance,
      name: AppRoute.careerGuidance,
      builder: (context, state) => const CareerGuidanceScreen(),
      routes: [
        GoRoute(
          path: AppRoute.pricing,
          name: AppRoute.pricing,
          builder: (context, state) => const PricingScreen(),
        ),
      ],
    ),

    // Trainer's Training Courses
    GoRoute(
      path: AppRoute.trainingCoursesTrainer,
      name: AppRoute.trainingCoursesTrainer,
      builder: (context, state) => const TrainingCoursesTrainerScreen(),
      routes: [
        GoRoute(
          path: AppRoute.trainerCourseDetails,
          name: AppRoute.trainerCourseDetails,
          builder: (context, state) {
            final courseId = state.pathParameters['courseId'];
            return TrainerCourseDetailsScreen(courseId: courseId!);
          },
        ),
      ],
    ),
  ],

  // Error Page
  errorPageBuilder: (context, state) {
    return MaterialPage(
      child: Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: const Center(child: Text('404: Page Not Found')),
      ),
    );
  },

  // Redirect Logic
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthenticated = checkAuthentication();
    final userRole = getUserRole();

    if (userRole == null && state.matchedLocation != AppRoute.onboarding) {
      return AppRoute.onboarding;
    }

    if (state.matchedLocation == AppRoute.login) {
      if (userRole == 'trainer') {
        return AppRoute.login;
      } else if (userRole == 'student') {
        return AppRoute.login;
      }
    }

    if (!isAuthenticated) {
      if (state.matchedLocation != AppRoute.login &&
          state.matchedLocation != AppRoute.onboarding) {
        return AppRoute.login;
      }
    }

    return null;
  },
);
bool checkAuthentication() {
  // Simulated authentication check
  // Replace this with actual logic
  // (e.g., using a provider, shared preferences, etc.)
  return true; // Assume user is authenticated for demonstration
}

String? getUserRole() {
  // Simulated role retrieval
  // Replace this with actual role retrieval logic
  return 'trainer'; // Assume the user is a "student" for demonstration
}
