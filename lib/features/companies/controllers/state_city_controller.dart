import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/handle_exception.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/models/city_model.dart';
import 'package:hr/features/companies/models/state_model.dart';

class StateCityController {
  ApiConsumer api = serviceLocator();
  Future<ApiResponseModel<List<StateModel>>> states() async {
    final t = prt('states - StateCityController');
    try {
      final response = await api.get(EndPoint.states);
      List<StateModel> states =
          (response['states'] as List).map((json) => StateModel.fromJson(json)).toList();

      return pr(ApiResponseModel(response: ResponseEnum.success, data: states), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<List<CityModel>>> cities(int stateId) async {
    final t = prt('cities - StateCityController');
    try {
      final response = await api.get('${EndPoint.cities}/$stateId');
      List<CityModel> cities =
          (response['cities'] as List).map((json) => CityModel.fromJson(json)).toList();

      return pr(ApiResponseModel(response: ResponseEnum.success, data: cities), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }
}
