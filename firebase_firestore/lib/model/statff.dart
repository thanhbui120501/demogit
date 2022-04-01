import 'dart:convert';

class Staff {
  String id;
  String fullName;
  String urlImage;
  int age;
  Staff({
    required this.id,
    required this.fullName,
    required this.urlImage,
    required this.age,
  });

  Staff copyWith({
    String? id,
    String? fullName,
    String? urlImage,
    int? age,
  }) {
    return Staff(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      urlImage: urlImage ?? this.urlImage,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'fullName': fullName});
    result.addAll({'urlImage': urlImage});
    result.addAll({'age': age});

    return result;
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      urlImage: map['urlImage'] ?? '',
      age: map['age']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Staff(id: $id, fullName: $fullName, urlImage: $urlImage, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staff &&
        other.id == id &&
        other.fullName == fullName &&
        other.urlImage == urlImage &&
        other.age == age;
  }

  @override
  int get hashCode {
    return id.hashCode ^ fullName.hashCode ^ urlImage.hashCode ^ age.hashCode;
  }
}
