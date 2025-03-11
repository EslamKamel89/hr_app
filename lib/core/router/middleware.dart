import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/features/auth/helpers/auth_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppMiddleWare {
  SharedPreferences sharedPreferences;
  AppMiddleWare({required this.sharedPreferences});
  static bool _onBoarding() {
    return true;
  }

  static bool _isSignedIn() {
    return AuthHelpers.isSignedIn();
  }

  String? middlleware(String? routeName) {
    // return routeName;
    if (routeName == AppRoutesNames.signInView && _isSignedIn()) {
      return AppRoutesNames.companiesView;
    }
    return routeName;
  }
}
