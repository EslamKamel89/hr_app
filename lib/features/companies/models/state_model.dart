class StateModel {
  int? id;
  String? name;

  StateModel({this.id, this.name});

  @override
  String toString() => 'StateModel(id: $id, name: $name)';

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      StateModel(id: json['id'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  StateModel copyWith({int? id, String? name}) {
    return StateModel(id: id ?? this.id, name: name ?? this.name);
  }
}
