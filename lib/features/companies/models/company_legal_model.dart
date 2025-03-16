class CompanyLegalModel {
  int? id;
  String? tradeLicenseExpiryDate;
  String? vatRegistrationNumber;
  String? chamberOfCommerceMembershipNumber;
  int? companyBasicId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CompanyLegalModel({
    this.id,
    this.tradeLicenseExpiryDate,
    this.vatRegistrationNumber,
    this.chamberOfCommerceMembershipNumber,
    this.companyBasicId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyLeagalModel(id: $id, tradeLicenseExpiryDate: $tradeLicenseExpiryDate, vatRegistrationNumber: $vatRegistrationNumber, chamberOfCommerceMembershipNumber: $chamberOfCommerceMembershipNumber, companyBasicId: $companyBasicId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyLegalModel.fromJson(Map<String, dynamic> json) {
    return CompanyLegalModel(
      id: json['id'] as int?,
      tradeLicenseExpiryDate: json['trade_license_expiry_date'] as String?,
      vatRegistrationNumber: json['vat_registration_number'] as String?,
      chamberOfCommerceMembershipNumber: json['chamber_of_commerce_membership_number'] as String?,
      companyBasicId: json['company_basic_id'] as int?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'trade_license_expiry_date': tradeLicenseExpiryDate,
    'vat_registration_number': vatRegistrationNumber,
    'chamber_of_commerce_membership_number': chamberOfCommerceMembershipNumber,
    'company_basic_id': companyBasicId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  CompanyLegalModel copyWith({
    int? id,
    String? tradeLicenseExpiryDate,
    String? vatRegistrationNumber,
    String? chamberOfCommerceMembershipNumber,
    int? companyBasicId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyLegalModel(
      id: id ?? this.id,
      tradeLicenseExpiryDate: tradeLicenseExpiryDate ?? this.tradeLicenseExpiryDate,
      vatRegistrationNumber: vatRegistrationNumber ?? this.vatRegistrationNumber,
      chamberOfCommerceMembershipNumber:
          chamberOfCommerceMembershipNumber ?? this.chamberOfCommerceMembershipNumber,
      companyBasicId: companyBasicId ?? this.companyBasicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
