import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/dio_consumer.dart';
import 'package:hr/core/router/app_router.dart';
import 'package:hr/core/router/middleware.dart';
import 'package:hr/features/auth/controllers/auth_controller.dart';
import 'package:hr/features/companies/controllers/companies_controller.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt serviceLocator = GetIt.instance;

Future initServiceLocator() async {
  serviceLocator.registerLazySingleton<ImagePicker>(() => ImagePicker());
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: serviceLocator()),
  );
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);
  serviceLocator.registerLazySingleton<AppMiddleWare>(
    () => AppMiddleWare(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AppRouter>(
    () => AppRouter(appMiddleWare: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthController>(() => AuthController());
  serviceLocator.registerLazySingleton<CompaniesController>(
    () => CompaniesController(),
  );
  serviceLocator.registerLazySingleton<CompanyFormController>(
    () => CompanyFormController(),
  );
}
