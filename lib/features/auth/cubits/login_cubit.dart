import 'package:bloc/bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/auth/controllers/auth_controller.dart';
import 'package:hr/features/auth/controllers/params/login_params.dart';
import 'package:hr/features/auth/models/user_model.dart';

class LoginCubit extends Cubit<ApiResponseModel<UserModel?>> {
  AuthController controller = serviceLocator();
  LoginCubit() : super(ApiResponseModel(response: ResponseEnum.initial));
  Future login({required LoginParams params}) async {
    final t = prt('login - RegisterCubit');
    pr(params, '$t -params');
    emit(
      pr(state.copyWith(errorMessage: null, response: ResponseEnum.loading), t),
    );
    emit(pr(await controller.login(params: params), t));
  }
}
