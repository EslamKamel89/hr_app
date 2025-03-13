class CompanyContactModel {
  String? contactName;
  String? companyEmail;
  String? primaryMobileNumber;
  String? secondaryMobileNumber;
  String? landlineNumber;
  String? faxNumber;
  String? hrMobileNumber;
  String? hrLandlineNumber;
  String? hrEmail;
  int? companyBasicId;
  String? createdAt;
  String? updatedAt;

  CompanyContactModel({
    this.contactName,
    this.companyEmail,
    this.primaryMobileNumber,
    this.secondaryMobileNumber,
    this.landlineNumber,
    this.faxNumber,
    this.hrMobileNumber,
    this.hrLandlineNumber,
    this.hrEmail,
    this.companyBasicId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyContactModel(contactName: $contactName, companyEmail: $companyEmail, primaryMobileNumber: $primaryMobileNumber, secondaryMobileNumber: $secondaryMobileNumber, landlineNumber: $landlineNumber, faxNumber: $faxNumber, hrMobileNumber: $hrMobileNumber, hrLandlineNumber: $hrLandlineNumber, hrEmail: $hrEmail, companyBasicId: $companyBasicId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyContactModel.fromJson(Map<String, dynamic> json) {
    return CompanyContactModel(
      contactName: json['contact_name'] as String?,
      companyEmail: json['company_email'] as String?,
      primaryMobileNumber: json['primary_mobile_number'] as String?,
      secondaryMobileNumber: json['secondary_mobile_number'] as String?,
      landlineNumber: json['landline_number'] as String?,
      faxNumber: json['fax_number'] as String?,
      hrMobileNumber: json['hr_mobile_number'] as String?,
      hrLandlineNumber: json['hr_landline_number'] as String?,
      hrEmail: json['hr_email'] as String?,
      companyBasicId:
          json['company_basic_id'] == null ? null : int.parse(json['company_basic_id'].toString()),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'contact_name': contactName,
    'company_email': companyEmail,
    'primary_mobile_number': primaryMobileNumber,
    'secondary_mobile_number': secondaryMobileNumber,
    'landline_number': landlineNumber,
    'fax_number': faxNumber,
    'hr_mobile_number': hrMobileNumber,
    'hr_landline_number': hrLandlineNumber,
    'hr_email': hrEmail,
    // 'company_basic_id': companyBasicId,
    // 'created_at': createdAt,
    // 'updated_at': updatedAt,
  };

  CompanyContactModel copyWith({
    String? contactName,
    String? companyEmail,
    String? primaryMobileNumber,
    String? secondaryMobileNumber,
    String? landlineNumber,
    String? faxNumber,
    String? hrMobileNumber,
    String? hrLandlineNumber,
    String? hrEmail,
    int? companyBasicId,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyContactModel(
      contactName: contactName ?? this.contactName,
      companyEmail: companyEmail ?? this.companyEmail,
      primaryMobileNumber: primaryMobileNumber ?? this.primaryMobileNumber,
      secondaryMobileNumber: secondaryMobileNumber ?? this.secondaryMobileNumber,
      landlineNumber: landlineNumber ?? this.landlineNumber,
      faxNumber: faxNumber ?? this.faxNumber,
      hrMobileNumber: hrMobileNumber ?? this.hrMobileNumber,
      hrLandlineNumber: hrLandlineNumber ?? this.hrLandlineNumber,
      hrEmail: hrEmail ?? this.hrEmail,
      companyBasicId: companyBasicId ?? this.companyBasicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
