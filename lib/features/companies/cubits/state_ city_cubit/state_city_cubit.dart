import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'state_city_state.dart';

class StateCityCubit extends Cubit<StateCityState> {
  StateCityCubit() : super(StateCityInitial());
}
