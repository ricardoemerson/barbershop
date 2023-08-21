enum EmployeeRegisterStatus { initial, success, error }

class EmployeeRegisterState {
  final EmployeeRegisterStatus status;
  final bool isRegisterAdmin;
  final List<String> workDays;
  final List<int> workHours;

  EmployeeRegisterState({
    required this.status,
    required this.isRegisterAdmin,
    required this.workDays,
    required this.workHours,
  });

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStatus.initial,
          isRegisterAdmin: false,
          workDays: <String>[],
          workHours: <int>[],
        );

  EmployeeRegisterState copyWith({
    EmployeeRegisterStatus? status,
    bool? isRegisterAdmin,
    List<String>? workDays,
    List<int>? workHours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      isRegisterAdmin: isRegisterAdmin ?? this.isRegisterAdmin,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
    );
  }
}
