// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'state_city_cubit.dart';

class StateCityState {
  ApiResponseModel<List<StateModel>> states;
  ApiResponseModel<List<CityModel>> cities;
  StateModel? selectedState;
  CityModel? selectedCity;
  StateCityState({
    required this.states,
    required this.cities,
    this.selectedState,
    this.selectedCity,
  });

  StateCityState copyWith({
    ApiResponseModel<List<StateModel>>? states,
    ApiResponseModel<List<CityModel>>? cities,
    StateModel? selectedState,
    CityModel? selectedCity,
  }) {
    return StateCityState(
      states: states ?? this.states,
      cities: cities ?? this.cities,
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }

  @override
  String toString() {
    return 'StateCityState(states: $states, cities: $cities, selectedState: $selectedState, selectedCity: $selectedCity)';
  }
}
