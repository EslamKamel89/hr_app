// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:hr/core/api_service/upload_image_to_api.dart';

class CompanyAttachmentsParams {
  File? tradeLicense;
  File? ownerEmirateIdFrontCopy;
  File? ownerEmirateIdBackCopy;
  File? ownerPassportCopy;
  File? vatRegisterationCertificateCopy;
  File? chamberOfCommerceCertificateCopy;
  CompanyAttachmentsParams({
    this.tradeLicense,
    this.ownerEmirateIdFrontCopy,
    this.ownerEmirateIdBackCopy,
    this.ownerPassportCopy,
    this.vatRegisterationCertificateCopy,
    this.chamberOfCommerceCertificateCopy,
  });
  Future<Map<String, dynamic>> toJson() async => {
    'trade_license': await uploadFileImageToApi(tradeLicense),
    'owner_emirate_id_front_copy': await uploadFileImageToApi(
      ownerEmirateIdFrontCopy,
    ),
    'owner_emirate_id_back_copy': await uploadFileImageToApi(
      ownerEmirateIdBackCopy,
    ),
    'owner_passport_copy': await uploadFileImageToApi(ownerPassportCopy),
    'vat_registeration_certificate_copy': await uploadFileImageToApi(
      vatRegisterationCertificateCopy,
    ),
    'chamber_of_commerce_certificate_copy': await uploadFileImageToApi(
      chamberOfCommerceCertificateCopy,
    ),
  };
}
