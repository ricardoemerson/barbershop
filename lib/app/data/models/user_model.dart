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
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserAdmModel(
          id: id,
          name: name,
          email: email,
          avatar: map['avatar'],
          workDays: map['work_days']?.cast<String>(),
          workHours: map['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON string.')
    };
  }
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
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserEmployeeModel(
          id: id,
          name: name,
          email: email,
          avatar: map['avatar'],
          barbershopId: barbershopId,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON string.')
    };
  }

  String toJson() => json.encode(toMap());

  factory UserEmployeeModel.fromJson(String source) =>
      UserEmployeeModel.fromMap(json.decode(source));
}
