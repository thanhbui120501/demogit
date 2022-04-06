import 'dart:convert';

class Student {
  String? id;
  String code;
  String name;
  String group;
  Student({
    this.id,
    required this.code,
    required this.name,
    required this.group,
  });

  Student copyWith({
    String? id,
    String? code,
    String? name,
    String? group,
  }) {
    return Student(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'code': code});
    result.addAll({'name': name});
    result.addAll({'group': group});

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      group: map['group'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, code: $code, name: $name, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.code == code &&
        other.name == name &&
        other.group == group;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ name.hashCode ^ group.hashCode;
  }
}
