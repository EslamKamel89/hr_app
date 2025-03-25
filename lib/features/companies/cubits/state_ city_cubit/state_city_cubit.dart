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
          citiesOperational: ApiResponseModel<List<CityModel>>(
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

  Future selectState({String? stateName, int? stateId, bool isOperational = false}) async {
    final t = prt('selectState - StateCityCubit - isOperational=$isOperational');
    // reset the previios selected city
    if (state.states.data == null || state.states.data?.isEmpty == true) {
      await fetchStates();
    }

    state.selectedCity = !isOperational ? null : state.selectedCity;
    state.selectedOperationalCity = isOperational ? null : state.selectedOperationalCity;
    state.cities =
        !isOperational ? ApiResponseModel(data: [], response: ResponseEnum.initial) : state.cities;
    state.citiesOperational =
        isOperational
            ? ApiResponseModel(data: [], response: ResponseEnum.initial)
            : state.citiesOperational;

    emit(state.copyWith());
    if (state.states.data?.isEmpty == null || state.states.data?.isEmpty == true) {
      pr("can't select state because the states list is empty", t);
      return;
    }
    final selectedState =
        state.states.data
            ?.where((e) => stateName != null ? e.name == stateName : e.id == stateId)
            .firstOrNull;
    pr(selectedState, '$t  - model');
    if (selectedState == null) return;
    emit(
      state.copyWith(
        selectedState: !isOperational ? selectedState : null,
        selectedOperationalState: isOperational ? selectedState : null,
      ),
    );
    await _fetchCities(isOperational);
  }

  Future _fetchCities(bool isOperational) async {
    final t = prt('_fetchCities - StateCityCubit - isOperational=$isOperational');

    emit(
      state.copyWith(
        cities:
            !isOperational
                ? ApiResponseModel(errorMessage: null, response: ResponseEnum.loading)
                : null,
        citiesOperational:
            isOperational
                ? ApiResponseModel(errorMessage: null, response: ResponseEnum.loading)
                : null,
      ),
    );
    final cities = await controller.cities(
      !isOperational ? state.selectedState?.id : state.selectedOperationalState?.id,
    );
    pr(cities, t);
    emit(
      state.copyWith(
        cities: !isOperational ? cities : null,
        citiesOperational: isOperational ? cities : null,
      ),
    );
  }

  Future selectCity({String? cityName, int? cityId, bool isOperational = false}) async {
    final t = prt('selectCity - StateCityCubit - isOperational=$isOperational');
    // if (state.cities.data?.isEmpty == true) {
    //   pr("can't select city because the cities list is empty", t);
    //   emit(state.copyWith(selectedCity: null));
    //   return;
    // }
    final cities = !isOperational ? state.cities.data : state.citiesOperational.data;
    final selectedCity =
        cities?.where((e) => cityName != null ? e.name == cityName : e.id == cityId).firstOrNull;
    if (selectedCity == null) return;
    pr(selectedCity, '$t - model');
    emit(
      state.copyWith(
        selectedCity: !isOperational ? selectedCity : null,
        selectedOperationalCity: isOperational ? selectedCity : null,
      ),
    );
  }
}
