
import 'package:get_it/get_it.dart';

import '../../common/presentation/cubit/app_cubit/app_cubit.dart';
import '../../common/presentation/cubit/auth_cubit/auth_cubit.dart';




final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// bloc
  //  sl.registerFactory(() => HomeCubit());
     sl.registerFactory(() => AppCubit());
    sl.registerFactory(() => AuthCubit());
// sl.registerFactory(() => SubCategoryCubit());
    // sl.registerFactory(() => MapCubit());
    // sl.registerFactory(() => PlaceCubit(sl()));

    //    sl.registerFactory(() => SearchCubit(sl()));

  //   /// use Cases
  //   sl.registerLazySingleton(() => CheckUerNameUseCase(sl()));
  //   sl.registerLazySingleton(() => LoginUseCase(sl()));
  //   sl.registerLazySingleton(() => SignUpUseCase(sl()));
  //   sl.registerLazySingleton(() => AppUseCase(sl()));
  //   sl.registerLazySingleton(() => GetCarTypesUseCase(sl()));
  //  sl.registerLazySingleton(() => AddTripUseCase(sl()));
  //  sl.registerLazySingleton(() => HomeTripUseCase(sl()));
  // sl.registerLazySingleton(() => NotificationsCubit());
  //   // sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  //   // sl.registerLazySingleton(() => SearchCityUseCase(sl()));

  //   /// repository
  //   sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
  //   sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));
  //   sl.registerLazySingleton<BaseTripRepository>(() => TripRepository(sl()));
  //   // ///data source
  //   sl.registerLazySingleton<BaseAuthRemoteDataSource>(
  //       () => AuthRemoteDataSource());
  //   sl.registerLazySingleton<BaseAppRemoteDataSource>(
  //       () => AppRemoteDataSource());
  //  sl.registerLazySingleton<BaseTripRemoteDataSource>(() => TripRemoteDataSource());
  }
}
