import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:masarat/features/auth/login/ui/screens/login_screen.dart';
import 'package:masarat/features/auth/signup/logic/cubit/register_cubit.dart';
import 'package:masarat/features/auth/signup/ui/screens/sign_up_screen.dart';
import 'package:masarat/features/auth/ui/screens/onboarding_screen.dart';
import 'package:masarat/features/home/presentation/pages/home_screen.dart';
import 'package:masarat/features/home/presentation/pages/my_library.dart';
import 'package:masarat/features/instructor/data/models/course/course_model.dart'
    as instructor;
import 'package:masarat/features/instructor/home/presentation/pages/instructor_home_screen.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_cubit.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';
import 'package:masarat/features/instructor/presentation/pages/create_course_screen.dart';
import 'package:masarat/features/instructor/presentation/pages/instructor_course_management_page.dart';
import 'package:masarat/features/instructor/profile/logic/cubit/instructor_profile_cubit.dart';
import 'package:masarat/features/instructor/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:masarat/features/settings/presentation/pages/about_us_screen.dart';
import 'package:masarat/features/settings/presentation/pages/policies_screen.dart';
import 'package:masarat/features/splash/ui/splash_screen.dart';
import 'package:masarat/features/student/cart/presentation/pages/checkout_webview_screen.dart';
import 'package:masarat/features/student/cart/presentation/pages/shopping_cart_screen.dart';
import 'package:masarat/features/student/courses/data/models/course_model.dart';
import 'package:masarat/features/student/courses/data/models/lesson_model.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_cubit.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_state.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';
import 'package:masarat/features/student/courses/presentation/pages/student_course_details_screen.dart';
import 'package:masarat/features/student/courses/presentation/pages/student_courses_screen.dart';
import 'package:masarat/features/student/courses/presentation/pages/student_lesson_details_screen.dart';
import 'package:masarat/features/student/courses/presentation/pages/student_lesson_list_screen.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';
import 'package:masarat/features/student/profile/logic/cubit/student_profile_cubit.dart';
import 'package:masarat/features/student/profile/presentation/pages/student_profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.splash, // Start at onboarding
  routes: [
    // Splash Route
    GoRoute(
      path: AppRoute.splash,
      name: AppRoute.splash,
      builder: (context, state) => const SplashScreen(),
    ),

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
        return BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: LoginScreen(isTrainer: isTrainer),
        );
      },
    ),
    // SignUp Route
    GoRoute(
      path: AppRoute.signUp,
      name: AppRoute.signUp,
      builder: (context, state) {
        final isTrainer = (state.extra as bool?) ?? false;
        return BlocProvider(
          create: (context) => getIt<RegisterCubit>(param1: isTrainer),
          child: SignUpScreen(isTrainer: isTrainer),
        );
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
          path: AppRoute.studentProfile,
          name: AppRoute.studentProfile,
          builder: (context, state) => BlocProvider<StudentProfileCubit>.value(
            value: getIt<StudentProfileCubit>(),
            child: const StudentProfileScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.instructorProfile,
          name: AppRoute.instructorProfile,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<InstructorProfileCubit>(),
            child: const InstructorProfileScreen(),
          ),
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
          path: AppRoute.paymentWebView,
          name: AppRoute.paymentWebView,
          builder: (context, state) {
            final Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
            return CheckoutWebViewScreen(
              redirectUrl: args['redirectUrl'] as String,
              orderId: args['orderId'] as String,
            );
          },
        ),
        GoRoute(
          path: AppRoute.trainingCourses,
          name: AppRoute.trainingCourses,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<TrainingCoursesCubit>()..getCourses(),
            child: const StudentCoursesScreen(),
          ),
          routes: [
            GoRoute(
              path: AppRoute.courseDetails,
              name: AppRoute.courseDetails,
              builder: (context, state) {
                final courseService = getIt<CourseStateService>();

                // Try to get course from extra parameters first
                final courseFromExtra = state.extra as CourseModel?;

                // If we have course from extra, update our service and return the screen
                if (courseFromExtra != null) {
                  courseService.selectedCourse = courseFromExtra;
                  return StudentCourseDetailsScreen(course: courseFromExtra);
                }

                // If no course in extra, try to get from our service
                final savedCourse = courseService.selectedCourse;
                if (savedCourse != null) {
                  return StudentCourseDetailsScreen(course: savedCourse);
                }

                // If we still don't have course data, show error
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('خطأ'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  body: const Center(
                    child: Text(
                      'بيانات الدورة غير متوفرة. يرجى العودة والمحاولة مرة أخرى.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: AppRoute.lectureScreen,
                  name: AppRoute.lectureScreen,
                  builder: (context, state) {
                    // Get course data from our service
                    final courseService = getIt<CourseStateService>();
                    final course = courseService.selectedCourse;
                    return StudentLessonListScreen(course: course);
                  },
                  routes: [
                    GoRoute(
                      path: AppRoute.lectureDetails,
                      name: AppRoute.lectureDetails,
                      builder: (context, state) {
                        final lectureId = state.pathParameters['lectureid'];
                        // Get course data from our service
                        final courseService = getIt<CourseStateService>();
                        final course = courseService.selectedCourse;

                        // Find the lesson that matches the lecture ID
                        LessonModel? matchingLesson;

                        // First check if we have the lesson from API in our CourseStateService
                        if (lectureId != null) {
                          matchingLesson =
                              courseService.getLessonById(lectureId);
                          if (matchingLesson != null) {
                            debugPrint(
                                'Found lesson from CourseStateService: ${matchingLesson.title}');
                            debugPrint(
                                'Lesson content: ${matchingLesson.content}');
                          }
                        }

                        // If no lesson found in CourseStateService, try to get from the cubit state
                        if (matchingLesson == null) {
                          try {
                            final lessonsState =
                                getIt<StudentLessonsCubit>().state;
                            if (lessonsState.status ==
                                    StudentLessonsStatus.success &&
                                lessonsState.lessons != null &&
                                lessonsState.lessons!.isNotEmpty) {
                              // Try to find the lesson in the API response
                              try {
                                matchingLesson =
                                    lessonsState.lessons!.firstWhere(
                                  (lesson) => lesson.id == lectureId,
                                );
                                debugPrint(
                                    'Found lesson from API via cubit: ${matchingLesson.title}');
                                debugPrint(
                                    'Lesson content: ${matchingLesson.content}');
                              } catch (e) {
                                // No matching lesson found in the API response
                                debugPrint(
                                    'No matching lesson found in cubit state for ID: $lectureId');
                              }
                            }
                          } catch (e) {
                            debugPrint('Error getting lesson from cubit: $e');
                          }
                        }

                        // If still no matching lesson found, fall back to course model
                        if (matchingLesson == null &&
                            course != null &&
                            course.lessons.isNotEmpty) {
                          matchingLesson = course.lessons.firstWhere(
                            (lesson) => lesson.id == lectureId,
                            orElse: () => course.lessons.first,
                          );
                          debugPrint(
                              'Using lesson from course model: ${matchingLesson.title}');
                          debugPrint(
                              'Lesson content: ${matchingLesson.content}');
                        }

                        return StudentLessonDetailsScreen(
                          lectureId: lectureId!,
                          lesson: matchingLesson,
                        );
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

    // Trainer's Training Courses
    GoRoute(
      path: AppRoute.instructorCoursesManagement,
      name: AppRoute.instructorCoursesManagement,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            getIt<InstructorCoursesCubit>()..getPublishedCourses(),
        child: const InstructorHomeScreen(),
      ),
      routes: [
        GoRoute(
          path: AppRoute.createCourse,
          name: AppRoute.createCourse,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<CreateCourseCubit>(),
            child: const CreateCourseScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.trainerCourseDetails,
          name: AppRoute.trainerCourseDetails,
          builder: (context, state) {
            final courseId = state.pathParameters['courseid'];
            return InstructorCourseManagementPage(courseId: courseId!);
          },
        ),
        GoRoute(
          path: AppRoute.editCourseName,
          name: AppRoute.editCourseName,
          builder: (context, state) {
            final course = state.extra;
            final instructor.CourseModel? courseModel =
                course is instructor.CourseModel ? course : null;
            return BlocProvider(
              create: (context) => getIt<CreateCourseCubit>(),
              child: CreateCourseScreen(course: courseModel),
            );
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
