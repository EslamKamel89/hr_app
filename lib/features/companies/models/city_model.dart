class CityModel {
  int? id;
  String? name;

  CityModel({this.id, this.name});

  @override
  String toString() => 'CityModel(id: $id, name: $name)';

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(id: json['id'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  CityModel copyWith({int? id, String? name}) {
    return CityModel(id: id ?? this.id, name: name ?? this.name);
  }
}
