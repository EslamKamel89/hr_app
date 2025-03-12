import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/features/companies/models/company_model.dart';

part 'company_form_state.dart';

class CompanyFormCubit extends Cubit<CompanyFormState> {
  CompanyFormCubit() : super(CompanyFormState());
}
