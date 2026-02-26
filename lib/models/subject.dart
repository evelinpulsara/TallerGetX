enum SubjectType { mandatory, elective, optional }

enum SubjectStatus { enrolled, inProgress, completed, failed }

class Subject {
  final String id;
  final String code;
  final String name;
  final int credits;
  final SubjectType type;
  final String schedule;
  final String professor;
  SubjectStatus status;

  Subject({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
    required this.type,
    required this.schedule,
    required this.professor,
    this.status = SubjectStatus.enrolled,
  });

  Subject copyWith({
    String? id,
    String? code,
    String? name,
    int? credits,
    SubjectType? type,
    String? schedule,
    String? professor,
    SubjectStatus? status,
  }) {
    return Subject(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      credits: credits ?? this.credits,
      type: type ?? this.type,
      schedule: schedule ?? this.schedule,
      professor: professor ?? this.professor,
      status: status ?? this.status,
    );
  }

  String getTypeLabel() {
    switch (type) {
      case SubjectType.mandatory: return 'Mandatory';
      case SubjectType.elective: return 'Elective';
      case SubjectType.optional: return 'Optional';
    }
  }

  String getStatusLabel() {
    switch (status) {
      case SubjectStatus.enrolled: return 'Enrolled';
      case SubjectStatus.inProgress: return 'In Progress';
      case SubjectStatus.completed: return 'Completed';
      case SubjectStatus.failed: return 'Failed';
    }
  }
}