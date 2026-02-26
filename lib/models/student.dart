enum StudentStatus { active, inactive, graduated }

class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String program;
  final int semester;
  final StudentStatus status;
  final DateTime registrationDate;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.program,
    required this.semester,
    this.status = StudentStatus.active,
    required this.registrationDate,
  });

  // CopyWith for immutability (OOP Best Practice)
  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? program,
    int? semester,
    StudentStatus? status,
    DateTime? registrationDate,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      program: program ?? this.program,
      semester: semester ?? this.semester,
      status: status ?? this.status,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  String getStatusLabel() {
    switch (status) {
      case StudentStatus.active: return 'Active';
      case StudentStatus.inactive: return 'Inactive';
      case StudentStatus.graduated: return 'Graduated';
    }
  }
}