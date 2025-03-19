import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/controllers/params/company_additional_info_params.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_additional_info_model.dart';

class CompanyAdditionalInfoCubit extends Cubit<ApiCrudResponseModel<CompanyAdditionalInfoModel>> {
  CompanyFormController controller = serviceLocator();
  CompanyAdditionalInfoCubit() : super(ApiCrudResponseModel.initial());
  Future additionalInfoShow(BuildContext context) async {
    final t = prt('additionalInfoShow - CompanyAdditionalInfoCubit');
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
    final additonalInfoRes = await controller.additionalInfoShow(company.id!);
    pr(additonalInfoRes, t);
    if (!isClosed) {
      emit(additonalInfoRes);
    }
  }

  Future additionalInfoUpsert(BuildContext context, CompanyAdditionalInfoParams params) async {
    final t = prt('additionalInfoUpsert - CompanyAdditonalInfoCubit');

    emit(
      state.copyWith(
        upsertResponse: ResponseEnum.loading,
        showResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final additonalInfoRes = await controller.additionalInfoUpsert(params);
    pr(additonalInfoRes, t);
    emit(additonalInfoRes);
  }
}
