import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/features/companies/models/city_model.dart';
import 'package:hr/features/companies/models/state_model.dart';

part 'state_city_state.dart';

class StateCityCubit extends Cubit<StateCityState> {
  StateCityCubit()
    : super(
        StateCityState(
          cities: ApiResponseModel<List<CityModel>>(
            response: ResponseEnum.initial,
            data: <CityModel>[],
          ),
          states: ApiResponseModel<List<StateModel>>(
            response: ResponseEnum.initial,
            data: <StateModel>[],
          ),
        ),
      );
}
