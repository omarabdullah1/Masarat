import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:masarat/core/cubit/general_cubit.dart';
import 'package:masarat/core/networking/dio_factory.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/login/data/repos/login_repo.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:masarat/features/auth/signup/data/repos/create_account_repo.dart';
import 'package:masarat/features/instructor/data/apis/instructor_service.dart';
import 'package:masarat/features/instructor/data/repos/instructor_repo.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_cubit.dart';
import 'package:masarat/features/instructor/logic/delete_lesson/delete_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_cubit.dart';
import 'package:masarat/features/instructor/logic/instructor_courses/instructor_courses_cubit.dart';
import 'package:masarat/features/instructor/logic/update_lesson/update_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/upload_lesson_video/upload_lesson_video_cubit.dart';
import 'package:masarat/features/student/cart/data/apis/student_cart_api_constants.dart';
import 'package:masarat/features/student/cart/data/apis/student_cart_service.dart';
import 'package:masarat/features/student/cart/data/repos/student_cart_repo.dart';
import 'package:masarat/features/student/courses/apis/courses_service.dart';
import 'package:masarat/features/student/courses/data/apis/student_api_constants.dart';
import 'package:masarat/features/student/courses/data/apis/student_course_service.dart';
import 'package:masarat/features/student/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/student/courses/data/repos/student_course_repo.dart';
import 'package:masarat/features/student/courses/logic/cubit/student_lessons_cubit.dart';
import 'package:masarat/features/student/courses/logic/lesson_details/lesson_details_cubit.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';
import 'package:masarat/features/student/courses/services/course_state_service.dart';

import '../../features/auth/signup/logic/cubit/register_cubit.dart';
import '../../features/student/cart/logic/student_cart/student_cart_cubit.dart';
import '../../features/student/payment/presentation/cubits/payment_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /************************* */
  /* ***** Dio & Services ****
  /************************ */
  */

  final dio = DioFactory.getDio();

  // Register Dio instance first so it can be used by other services
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt
    ..registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(dio),
    )
    ..registerLazySingleton<CoursesService>(
      () => CoursesService(dio),
    )
    ..registerLazySingleton<InstructorService>(
      () => InstructorService(dio),
    )
    ..registerLazySingleton<StudentCourseService>(
      () => StudentCourseService(dio, baseUrl: StudentApiConstants.apiBaseUrl),
    )
    ..registerLazySingleton<StudentCartService>(
      () =>
          StudentCartService(dio, baseUrl: StudentCartApiConstants.apiBaseUrl),
    )

    // Add Course State Service as singleton
    ..registerLazySingleton(() => CourseStateService())

    /************************* */
    /* ******** REPOS *********
  /************************ */
  */

    ..registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()))
    ..registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepo(getIt()),
    )
    ..registerLazySingleton<CoursesRepo>(
      () => CoursesRepo(getIt()),
    )
    ..registerLazySingleton<InstructorRepo>(
      () => InstructorRepo(getIt()),
    )
    ..registerLazySingleton<StudentCourseRepo>(
      () => StudentCourseRepo(getIt<StudentCourseService>()),
    )
    ..registerLazySingleton<StudentCartRepo>(
      () => StudentCartRepo(getIt<StudentCartService>()),
    )

    /************************* */
    /* ******** CUBIT *********
  /************************ */
  */
    ..registerFactory<GeneralCubit>(GeneralCubit.new)
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
    ..registerFactoryParam<RegisterCubit, bool, void>(
        (isTrainer, _) => RegisterCubit(getIt(), isTrainer: isTrainer))
    ..registerFactory<CreateCourseCubit>(() => CreateCourseCubit(getIt()))
    ..registerFactory<AddLessonCubit>(() => AddLessonCubit(getIt()))
    ..registerFactory<DeleteLessonCubit>(() => DeleteLessonCubit(getIt()))
    ..registerFactory<GetLessonsCubit>(() => GetLessonsCubit(getIt()))
    ..registerFactory<UpdateLessonCubit>(() => UpdateLessonCubit(getIt()))
    ..registerFactory<UploadLessonVideoCubit>(
        () => UploadLessonVideoCubit(getIt()))
    ..registerFactory<InstructorCoursesCubit>(
        () => InstructorCoursesCubit(getIt()))
    ..registerFactory<StudentLessonsCubit>(
        () => StudentLessonsCubit(getIt<StudentCourseRepo>()))
    ..registerFactory<TrainingCoursesCubit>(() => TrainingCoursesCubit(getIt()))
    ..registerFactory<LessonDetailsCubit>(() => LessonDetailsCubit(getIt()))
    ..registerFactory<StudentCartCubit>(() => StudentCartCubit(getIt()))
    ..registerFactory<PaymentCubit>(
        () => PaymentCubit(getIt<StudentCartRepo>()));
}
