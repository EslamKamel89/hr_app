import 'package:flutter/material.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/router/middleware.dart';
import 'package:hr/core/widgets/ui_components_screen.dart';
import 'package:hr/features/companies/presentation/views/companies_view.dart';
import 'package:hr/features/splash_onboarding/splash_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.uiComponentScreen:
        return CustomPageRoute(
          builder: (context) => const UiComponentScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.companiesView:
        return CustomPageRoute(
          builder: (context) => const CompaniesView(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required super.builder,
    required RouteSettings super.settings,
  });
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
