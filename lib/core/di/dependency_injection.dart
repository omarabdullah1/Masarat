import 'package:get_it/get_it.dart';

import 'package:masarat/core/cubit/general_cubit.dart';
import 'package:masarat/core/networking/dio_factory.dart';
import 'package:masarat/features/auth/apis/auth_service.dart';
import 'package:masarat/features/auth/login/data/repos/login_repo.dart';
import 'package:masarat/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:masarat/features/auth/signup/data/repos/create_account_repo.dart';
import 'package:masarat/features/courses/apis/courses_service.dart';
import 'package:masarat/features/courses/data/repos/courses_repo.dart';
import 'package:masarat/features/courses/logic/cubit/create_course_cubit.dart';

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

    /************************* */
    /* ******** CUBIT *********
  /************************ */
  */
    ..registerFactory<GeneralCubit>(GeneralCubit.new)
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()))
    ..registerFactory<RegisterCubit>(() => RegisterCubit(getIt()))
    ..registerFactory<CreateCourseCubit>(() => CreateCourseCubit(getIt()));
}
