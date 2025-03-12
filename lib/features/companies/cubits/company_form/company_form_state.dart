// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_form_cubit.dart';

class CompanyFormState {
  ApiResponseModel<CompanyModel?>? company;
  CompanyFormState({this.company});

  CompanyFormState copyWith({ApiResponseModel<CompanyModel?>? company}) {
    return CompanyFormState(company: company ?? this.company);
  }

  @override
  String toString() => 'CompanyFormState(company: $company)';
}
