class CompanyAddressModel {
  int? id;
  String? registeredBuildingOfficeName;
  String? registeredStreetAddress;
  int? registeredCity;
  int? registeredEmirateState;
  String? registeredPoBox;
  String? operationalBuildingOfficeName;
  String? operationalStreetAddress;
  int? operationalCity;
  int? operationalEmirateState;
  String? operationalPoBox;
  String? addressSame;
  int? companyBasicId;
  String? createdAt;
  String? updatedAt;

  CompanyAddressModel({
    this.id,
    this.registeredBuildingOfficeName,
    this.registeredStreetAddress,
    this.registeredCity,
    this.registeredEmirateState,
    this.registeredPoBox,
    this.operationalBuildingOfficeName,
    this.operationalStreetAddress,
    this.operationalCity,
    this.operationalEmirateState,
    this.operationalPoBox,
    this.addressSame,
    this.companyBasicId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CompanyAddressModel(id: $id, registeredBuildingOfficeName: $registeredBuildingOfficeName, registeredStreetAddress: $registeredStreetAddress, registeredCity: $registeredCity, registeredEmirateState: $registeredEmirateState, registeredPoBox: $registeredPoBox, operationalBuildingOfficeName: $operationalBuildingOfficeName, operationalStreetAddress: $operationalStreetAddress, operationalCity: $operationalCity, operationalEmirateState: $operationalEmirateState, operationalPoBox: $operationalPoBox, addressSame: $addressSame, companyBasicId: $companyBasicId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CompanyAddressModel.fromJson(Map<String, dynamic> json) {
    return CompanyAddressModel(
      id: json['id'] as int?,
      registeredBuildingOfficeName: json['registered_building_office_name'] as String?,
      registeredStreetAddress: json['registered_street_address'] as String?,
      registeredCity: json['registered_city'] as int?,
      registeredEmirateState: json['registered_emirate_state'] as int?,
      registeredPoBox: json['registered_po_box'] as String?,
      operationalBuildingOfficeName: json['operational_building_office_name'] as String?,
      operationalStreetAddress: json['operational_street_address'] as String?,
      operationalCity: json['operational_city'] as int?,
      operationalEmirateState: json['operational_emirate_state'] as int?,
      operationalPoBox: json['operational_po_box'] as String?,
      addressSame: json['address_same'] as String?,
      companyBasicId:
          json['company_basic_id'] == null ? null : int.parse(json['company_basic_id'].toString()),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'registered_building_office_name': registeredBuildingOfficeName,
    'registered_street_address': registeredStreetAddress,
    'registered_city': registeredCity,
    'registered_emirate_state': registeredEmirateState,
    'registered_po_box': registeredPoBox,
    'operational_building_office_name': operationalBuildingOfficeName,
    'operational_street_address': operationalStreetAddress,
    'operational_city': operationalCity,
    'operational_emirate_state': operationalEmirateState,
    'operational_po_box': operationalPoBox,
    'address_same': addressSame,
    'company_basic_id': companyBasicId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  CompanyAddressModel copyWith({
    int? id,
    String? registeredBuildingOfficeName,
    String? registeredStreetAddress,
    int? registeredCity,
    int? registeredEmirateState,
    String? registeredPoBox,
    String? operationalBuildingOfficeName,
    String? operationalStreetAddress,
    int? operationalCity,
    int? operationalEmirateState,
    String? operationalPoBox,
    String? addressSame,
    int? companyBasicId,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyAddressModel(
      id: id ?? this.id,
      registeredBuildingOfficeName:
          registeredBuildingOfficeName ?? this.registeredBuildingOfficeName,
      registeredStreetAddress: registeredStreetAddress ?? this.registeredStreetAddress,
      registeredCity: registeredCity ?? this.registeredCity,
      registeredEmirateState: registeredEmirateState ?? this.registeredEmirateState,
      registeredPoBox: registeredPoBox ?? this.registeredPoBox,
      operationalBuildingOfficeName:
          operationalBuildingOfficeName ?? this.operationalBuildingOfficeName,
      operationalStreetAddress: operationalStreetAddress ?? this.operationalStreetAddress,
      operationalCity: operationalCity ?? this.operationalCity,
      operationalEmirateState: operationalEmirateState ?? this.operationalEmirateState,
      operationalPoBox: operationalPoBox ?? this.operationalPoBox,
      addressSame: addressSame ?? this.addressSame,
      companyBasicId: companyBasicId ?? this.companyBasicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
