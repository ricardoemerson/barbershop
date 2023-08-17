import 'dart:convert';

sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return switch (map['profile']) {
      'ADM' => UserAdmModel.fromMap(map),
      'EMPLOYEE' => UserEmployeeModel.fromMap(map),
      _ => throw ArgumentError('Perfil do usuário não informado.')
    };
  }
}

class UserAdmModel extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserAdmModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'work_days': workDays,
      'work_hours': workHours,
    };
  }

  factory UserAdmModel.fromMap(Map<String, dynamic> map) {
    return UserAdmModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'],
      workDays: List<String>.from(map['work_days']),
      workHours: List<int>.from(map['work_hours']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAdmModel.fromJson(String source) => UserAdmModel.fromMap(json.decode(source));
}

class UserEmployeeModel extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserEmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'barbershop_id': barbershopId,
      'work_days': workDays,
      'work_hours': workHours,
    };
  }

  factory UserEmployeeModel.fromMap(Map<String, dynamic> map) {
    return UserEmployeeModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'],
      barbershopId: map['barbershop_id']?.toInt() ?? 0,
      workDays: List<String>.from(map['work_days']),
      workHours: List<int>.from(map['work_hours']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEmployeeModel.fromJson(String source) =>
      UserEmployeeModel.fromMap(json.decode(source));
}
