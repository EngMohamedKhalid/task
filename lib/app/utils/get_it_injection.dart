
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/home_feature/data/data_source/home_remote_data-source.dart';
import 'package:task/features/home_feature/data/repo_impl/home_repo_impl.dart';
import 'package:task/features/home_feature/domain/repo/home_repo.dart';
import 'package:task/features/home_feature/domain/use_cases/get_news_use_case.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import '../services/cache_service.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // data sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImp(networkManager: getIt()));
  // getIt.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(networkManager: getIt()));
  // getIt.registerLazySingleton<CoursesRemoteDataSource>(() => CoursesRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<EventsRemoteDataSource>(() => EventsRemoteDataSourceImpl(networkManager: getIt()),);

  //* Repository
   getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(homeRemoteDataSource: getIt(), networkInfo: getIt()),);
  // getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(profileRemoteDataSource: getIt(), networkInfo: getIt()),);
  // getIt.registerLazySingleton<CoursesRepo>(() => CourseRepoImpl( networkInfo: getIt(), coursesRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<EventsRepo>(() => EventsRepoImpl( networkInfo: getIt(), eventsRemoteDataSource: getIt()),);

  //* Use cases
  _homeUseCases();


  //! ----------- app -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  // getIt.registerLazySingleton<FirebaseNotificationService>(() => FirebaseNotificationService(),);
  // getIt.registerLazySingleton<FlutterLocalNotificationService>(() => FlutterLocalNotificationService(),);
  getIt.registerSingleton<NavHelper>(NavHelper());
  getIt.registerSingleton<CacheService>(CacheService());
}

void _homeUseCases() {
   getIt.registerLazySingleton<GetAllNewsUseCase>(() => GetAllNewsUseCase(repository: getIt()));
}
