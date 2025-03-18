import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_address_model.dart';

class CompanyAddressCubit extends Cubit<ApiCrudResponseModel<CompanyAddressModel>> {
  CompanyFormController controller = serviceLocator();
  bool isTheSame = true;
  CompanyAddressCubit() : super(ApiCrudResponseModel.initial());
  Future addressShow(BuildContext context) async {
    final t = prt('addressShow - CompanyAddressCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        showResponse: ResponseEnum.loading,
        upsertResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final addressRes = await controller.addressShow(company.id!);
    isTheSame = addressRes.data?.addressSame?.trim().toLowerCase() == 'yes';
    pr(addressRes, t);
    if (!isClosed) {
      emit(addressRes);
    }
  }

  Future addressUpsert(BuildContext context, CompanyAddressModel address) async {
    final t = prt('addressUpsert - CompanyAddressCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        upsertResponse: ResponseEnum.loading,
        showResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final contactRes = await controller.addressUpsert(company.id!, address);
    pr(contactRes, t);
    emit(contactRes);
  }
}
