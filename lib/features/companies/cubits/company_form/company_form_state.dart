// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_form_cubit.dart';

class CompanyFormState {
  ApiResponseModel<CompanyModel?>? company;
  ApiResponseModel<CompanyContactModel?>? contact;
  CompanyFormState({this.company, this.contact});

  CompanyFormState copyWith({
    ApiResponseModel<CompanyModel?>? company,
    ApiResponseModel<CompanyContactModel?>? contact,
  }) {
    return CompanyFormState(company: company ?? this.company, contact: contact ?? this.contact);
  }

  @override
  String toString() => 'CompanyFormState(company: $company, contact: $contact)';
}
