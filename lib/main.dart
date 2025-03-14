import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/globals.dart';
import 'package:hr/core/router/app_router.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/core/themes/theme_cubit.dart';
import 'package:hr/features/companies/cubits/companies_index_cubit.dart';
import 'package:hr/features/companies/cubits/company_departments_index_cubit.dart';
import 'package:intl/intl_standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await findSystemLocale();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs', // Path to translation files
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => CompaniesIndexCubit()),
          BlocProvider(create: (_) => CompanyDepartmentsIndexCubit()),
        ],
        child: Builder(
          builder: (context) {
            final themeCubit = context.watch<ThemeCubit>();
            return MaterialApp(
              navigatorKey: navigatorKey,
              theme: themeCubit.state,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutesNames.splashScreen,
              // initialRoute: AppRoutesNames.companiesView,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: serviceLocator<AppRouter>().onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
