import 'dart:io';

import 'package:hr/core/api_service/upload_image_to_api.dart';

class CompanyAdditionalInfoParams {
  File? companyLogo;
  int? companyBasicId;
  CompanyAdditionalInfoParams({this.companyLogo, this.companyBasicId});
  Future<Map<String, dynamic>> toJson() async => {
    'company_logo': await uploadFileImageToApi(companyLogo),
    'company_basic_id': companyBasicId,
  };
}
