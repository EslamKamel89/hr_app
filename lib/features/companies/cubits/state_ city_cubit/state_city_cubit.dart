import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/state_city_controller.dart';
import 'package:hr/features/companies/models/city_model.dart';
import 'package:hr/features/companies/models/state_model.dart';

part 'state_city_state.dart';

class StateCityCubit extends Cubit<StateCityState> {
  final StateCityController controller = serviceLocator();
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
  Future fetchStates() async {
    final t = prt('fetchStates - StateCityCubit');
    emit(
      state.copyWith(states: ApiResponseModel(errorMessage: null, response: ResponseEnum.loading)),
    );
    final states = await controller.states();
    pr(states, t);
    emit(state.copyWith(states: states));
  }

  Future selectState(int stateId) async {
    const t = 'selectState - StateCityCubit';
    if (state.states.data?.isEmpty == true) {
      pr("can't select state because the states list is empty", t);
      emit(
        state.copyWith(
          selectedState: null,
          cities: ApiResponseModel(response: ResponseEnum.success, data: []),
        ),
      );
      return;
    }
    final selectedState = state.states.data?.where((e) => e.id == stateId).firstOrNull;
    emit(state.copyWith(selectedState: selectedState));
    _fetchCities();
  }

  Future _fetchCities() async {
    final t = prt('_fetchCities - StateCityCubit');
    if (state.selectedState?.id == null) {
      pr('Error: selected state cant be null', t);
      return;
    }
    emit(
      state.copyWith(cities: ApiResponseModel(errorMessage: null, response: ResponseEnum.loading)),
    );
    final cities = await controller.cities((state.selectedState?.id)!);
    pr(cities, t);
    emit(state.copyWith(cities: cities));
  }

  Future selectCity(int cityId) async {
    const t = 'selectCity - StateCityCubit';
    if (state.cities.data?.isEmpty == true) {
      pr("can't select city because the cities list is empty", t);
      emit(state.copyWith(selectedCity: null));
      return;
    }
    final selectedCity = state.cities.data?.where((e) => e.id == cityId).firstOrNull;
    emit(state.copyWith(selectedCity: selectedCity));
    _fetchCities();
  }
}
