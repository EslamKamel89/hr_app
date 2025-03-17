class CompanyAttachmentsModel {
  int? id;
  String? tradeLicense;
  String? ownerEmirateIdFrontCopy;
  String? ownerEmirateIdBackCopy;
  String? ownerPassportCopy;
  String? vatRegisterationCertificateCopy;
  String? chamberOfCommerceCertificateCopy;
  int? companyBasicId;
  String? path;
  String? createdAt;
  String? updatedAt;

  CompanyAttachmentsModel({
    this.id,
    this.tradeLicense,
    this.ownerEmirateIdFrontCopy,
    this.ownerEmirateIdBackCopy,
    this.ownerPassportCopy,
    this.vatRegisterationCertificateCopy,
    this.chamberOfCommerceCertificateCopy,
    this.companyBasicId,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyAttachmentsModel(id: $id, tradeLicense: $tradeLicense, ownerEmirateIdFrontCopy: $ownerEmirateIdFrontCopy, ownerEmirateIdBackCopy: $ownerEmirateIdBackCopy, ownerPassportCopy: $ownerPassportCopy, vatRegisterationCertificateCopy: $vatRegisterationCertificateCopy, chamberOfCommerceCertificateCopy: $chamberOfCommerceCertificateCopy, companyBasicId: $companyBasicId, path: $path, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyAttachmentsModel.fromJson(Map<String, dynamic> json) {
    return CompanyAttachmentsModel(
      id: json['id'] as int?,
      tradeLicense: json['trade_license'] as String?,
      ownerEmirateIdFrontCopy: json['owner_emirate_id_front_copy'] as String?,
      ownerEmirateIdBackCopy: json['owner_emirate_id_back_copy'] as String?,
      ownerPassportCopy: json['owner_passport_copy'] as String?,
      vatRegisterationCertificateCopy:
          json['vat_registeration_certificate_copy'] as String?,
      chamberOfCommerceCertificateCopy:
          json['chamber_of_commerce_certificate_copy'] as String?,
      companyBasicId: json['company_basic_id'] as int?,
      path: json['path'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'trade_license': tradeLicense,
    'owner_emirate_id_front_copy': ownerEmirateIdFrontCopy,
    'owner_emirate_id_back_copy': ownerEmirateIdBackCopy,
    'owner_passport_copy': ownerPassportCopy,
    'vat_registeration_certificate_copy': vatRegisterationCertificateCopy,
    'chamber_of_commerce_certificate_copy': chamberOfCommerceCertificateCopy,
    'company_basic_id': companyBasicId,
    'path': path,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  CompanyAttachmentsModel copyWith({
    int? id,
    String? tradeLicense,
    String? ownerEmirateIdFrontCopy,
    String? ownerEmirateIdBackCopy,
    String? ownerPassportCopy,
    String? vatRegisterationCertificateCopy,
    String? chamberOfCommerceCertificateCopy,
    int? companyBasicId,
    String? path,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyAttachmentsModel(
      id: id ?? this.id,
      tradeLicense: tradeLicense ?? this.tradeLicense,
      ownerEmirateIdFrontCopy:
          ownerEmirateIdFrontCopy ?? this.ownerEmirateIdFrontCopy,
      ownerEmirateIdBackCopy:
          ownerEmirateIdBackCopy ?? this.ownerEmirateIdBackCopy,
      ownerPassportCopy: ownerPassportCopy ?? this.ownerPassportCopy,
      vatRegisterationCertificateCopy:
          vatRegisterationCertificateCopy ??
          this.vatRegisterationCertificateCopy,
      chamberOfCommerceCertificateCopy:
          chamberOfCommerceCertificateCopy ??
          this.chamberOfCommerceCertificateCopy,
      companyBasicId: companyBasicId ?? this.companyBasicId,
      path: path ?? this.path,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
