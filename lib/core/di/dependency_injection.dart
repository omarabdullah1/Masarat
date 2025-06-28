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
import 'package:masarat/features/student/courses/apis/courses_service.dart';
import 'package:masarat/features/student/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';

import '../../features/auth/signup/logic/cubit/register_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /************************* */
  /* ***** Dio & Services ****
  /************************ */
  */

  final dio = DioFactory.getDio();

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

    /************************* */
    /* ******** CUBIT *********
  /************************ */
  */
    ..registerFactory<GeneralCubit>(GeneralCubit.new)
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
    ..registerFactory<RegisterCubit>(() => RegisterCubit(getIt()))
    ..registerFactory<CreateCourseCubit>(() => CreateCourseCubit(getIt()))
    ..registerFactory<AddLessonCubit>(() => AddLessonCubit(getIt()))
    ..registerFactory<DeleteLessonCubit>(() => DeleteLessonCubit(getIt()))
    ..registerFactory<GetLessonsCubit>(() => GetLessonsCubit(getIt()))
    ..registerFactory<InstructorCoursesCubit>(
        () => InstructorCoursesCubit(getIt()))
    ..registerFactory<TrainingCoursesCubit>(
        () => TrainingCoursesCubit(getIt()));
}
