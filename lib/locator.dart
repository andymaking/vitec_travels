import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vitec_travels/data/services/storage-services/appCache.dart';
import 'package:vitec_travels/data/services/storage-services/appCache.dart';
import 'package:vitec_travels/ui/home/home.vm.dart';
import 'data/repository/repository.dart';
import 'data/repository/repository_impl.dart';
import 'data/services/navigation_service.dart';
import 'data/services/remote/remote.dart';
import 'data/services/remote/remote_impl.dart';
import 'data/services/storage-services/storage-service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  setupDio();
  locator.registerFactory<Remote>(() => RemoteImpl(locator<Dio>()));
  locator.registerFactory<Repository>(() => RepositoryImpl(locator<Remote>()));

  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<AppCache>(() => AppCache());

  registerViewModels();
}

void setupDio() {
  locator.registerFactory(() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });
}

void registerViewModels() {
  /* TODO Setup viewModels*/

  locator.registerFactory(() => HomeViewModel());
}