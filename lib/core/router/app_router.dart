import 'package:flutter/material.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/router/middleware.dart';
import 'package:hr/core/widgets/ui_components_screen.dart';
import 'package:hr/features/auth/presentation/views/sign_in_view.dart';
import 'package:hr/features/auth/presentation/views/signup_view.dart';
import 'package:hr/features/companies/models/company_model.dart';
import 'package:hr/features/companies/presentation/views/companies_view.dart';
import 'package:hr/features/companies/presentation/views/company_create_edit_view.dart';
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
      case AppRoutesNames.companyCreateEditView:
        return CustomPageRoute(
          builder:
              (context) =>
                  ComapanyCreateEditView(company: args as CompanyModel?),
          settings: routeSettings,
        );
      case AppRoutesNames.signInView:
        return CustomPageRoute(
          builder: (context) => const SignInView(),
          settings: routeSettings,
        );
      case AppRoutesNames.signUpView:
        return CustomPageRoute(
          builder: (context) => const SignUpView(),
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
