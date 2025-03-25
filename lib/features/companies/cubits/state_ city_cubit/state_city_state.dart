// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'state_city_cubit.dart';

class StateCityState {
  ApiResponseModel<List<StateModel>> states;
  ApiResponseModel<List<CityModel>> cities;
  ApiResponseModel<List<CityModel>> citiesOperational;
  StateModel? selectedState;
  CityModel? selectedCity;
  StateModel? selectedOperationalState;
  CityModel? selectedOperationalCity;
  StateCityState({
    required this.states,
    required this.cities,
    required this.citiesOperational,
    this.selectedState,
    this.selectedCity,
    this.selectedOperationalState,
    this.selectedOperationalCity,
  });

  StateCityState copyWith({
    ApiResponseModel<List<StateModel>>? states,
    ApiResponseModel<List<CityModel>>? cities,
    ApiResponseModel<List<CityModel>>? citiesOperational,
    StateModel? selectedState,
    CityModel? selectedCity,
    StateModel? selectedOperationalState,
    CityModel? selectedOperationalCity,
  }) {
    return StateCityState(
      states: states ?? this.states,
      cities: cities ?? this.cities,
      citiesOperational: citiesOperational ?? this.citiesOperational,
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedOperationalState: selectedOperationalState ?? this.selectedOperationalState,
      selectedOperationalCity: selectedOperationalCity ?? this.selectedOperationalCity,
    );
  }

  @override
  String toString() {
    return 'StateCityState(states: $states, cities: $cities, citiesOperational: $citiesOperational, selectedState: $selectedState, selectedCity: $selectedCity, selectedOperationalState: $selectedOperationalState, selectedOperationalCity: $selectedOperationalCity)';
  }
}
