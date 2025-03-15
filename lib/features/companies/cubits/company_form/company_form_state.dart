// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_form_cubit.dart';

class CompanyFormState {
  ApiResponseModel<CompanyModel?>? company;
  // ApiResponseModel<CompanyContactModel?>? contact;
  int? currentTab;
  CompanyFormState({this.company, this.currentTab});

  CompanyFormState copyWith({
    ApiResponseModel<CompanyModel?>? company,
    int? currentTab,
  }) {
    return CompanyFormState(
      company: company ?? this.company,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  String toString() =>
      'CompanyFormState(company: $company,currentTab: $currentTab)';
}
