import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/student.dart';
import '../models/subject.dart';

class StudentController extends GetxController {
  // Reactive variables (GetX State Management)
  final RxList<Student> students = <Student>[].obs;
  final RxList<Subject> subjects = <Subject>[].obs;
  final Rx<Student?> currentStudent = Rx<Student?>(null);
  final RxBool isLoading = false.obs;

  // Getters
  List<Student> get allStudents => students;
  List<Subject> get studentSubjects => 
      subjects.where((s) => currentStudent.value != null).toList();
  int get totalStudents => students.length;
  int get activeStudents => students.where((s) => s.status == StudentStatus.active).length;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      // Sample students
      students.value = [
        Student(
          id: '1',
          name: 'Evelin',
          email: 'evelin@campus.cooperativa.edu.co',
          phone: '+57 300 123 4567',
          program: 'Systems Engineering',
          semester: 6,
          status: StudentStatus.active,
          registrationDate: DateTime.now().subtract(const Duration(days: 90)),
        ),
        Student(
          id: '2',
          name: 'Carlos',
          email: 'carlos@campus.cooperativa.edu.co',
          phone: '+57 310 987 6543',
          program: 'Business Administration',
          semester: 4,
          status: StudentStatus.active,
          registrationDate: DateTime.now().subtract(const Duration(days: 180)),
        ),
      ];

      // Sample subjects
      subjects.value = [
        Subject(
          id: '101',
          code: 'ING-301',
          name: 'Mobile Programming',
          credits: 4,
          type: SubjectType.mandatory,
          schedule: 'Mon/Wed 2:00-4:00 PM',
          professor: 'Dr. Jhonatan Mideros',
          status: SubjectStatus.inProgress,
        ),
        Subject(
          id: '102',
          code: 'ING-302',
          name: 'Database Design',
          credits: 3,
          type: SubjectType.mandatory,
          schedule: 'Tue/Thu 10:00-12:00 PM',
          professor: 'Dr. Maria Lopez',
          status: SubjectStatus.inProgress,
        ),
        Subject(
          id: '103',
          code: 'ING-303',
          name: 'Software Architecture',
          credits: 4,
          type: SubjectType.mandatory,
          schedule: 'Fri 8:00-12:00 PM',
          professor: 'Dr. Andres Perez',
          status: SubjectStatus.enrolled,
        ),
      ];
      isLoading.value = false;
    });
  }

  // Add new student
  void addStudent(Student student) {
    students.add(student);
    Get.snackbar(
      'Success',
      '${student.name} registered successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.9),
      colorText: Colors.white,
    );
  }

  // Update student
  void updateStudent(Student updated) {
    final index = students.indexWhere((s) => s.id == updated.id);
    if (index != -1) {
      students[index] = updated;
      Get.snackbar(
        'Updated',
        'Student information updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }

  // Delete student
  void deleteStudent(String studentId) {
    students.removeWhere((s) => s.id == studentId);
    Get.snackbar(
      'Deleted',
      'Student removed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.9),
      colorText: Colors.white,
    );
  }

  // Select student to view subjects
  void selectStudent(Student student) {
    currentStudent.value = student;
  }

  // Add subject to current student
  void enrollSubject(Subject subject) {
    subjects.add(subject);
    Get.snackbar(
      'Enrolled',
      '${subject.name} added to your schedule',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.9),
      colorText: Colors.white,
    );
  }

  // Update subject status
  void updateSubjectStatus(String subjectId, SubjectStatus status) {
    final index = subjects.indexWhere((s) => s.id == subjectId);
    if (index != -1) {
      subjects[index] = subjects[index].copyWith(status: status);
    }
  }
}