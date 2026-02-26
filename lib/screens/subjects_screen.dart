import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';
import '../models/subject.dart';

class SubjectsScreen extends StatelessWidget {
  final Student student;
  const SubjectsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${student.name}\'s Subjects'),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        final studentSubjects = controller.subjects;
        
        if (studentSubjects.isEmpty) {
          return _buildEmptyState();
        }
        
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: studentSubjects.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final subject = studentSubjects[index];
            return _buildSubjectCard(subject, controller);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectDialog(context, controller),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No subjects enrolled',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Subject subject, StudentController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${subject.code} - ${subject.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${subject.credits} credits • ${subject.getTypeLabel()}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(subject.status).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    subject.getStatusLabel(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(subject.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  subject.schedule,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  subject.professor,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<SubjectStatus>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (status) => controller.updateSubjectStatus(subject.id, status),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: SubjectStatus.inProgress, child: Text('In Progress')),
                    const PopupMenuItem(value: SubjectStatus.completed, child: Text('Completed')),
                    const PopupMenuItem(value: SubjectStatus.failed, child: Text('Failed')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(SubjectStatus status) {
    switch (status) {
      case SubjectStatus.enrolled: return Colors.blue;
      case SubjectStatus.inProgress: return Colors.orange;
      case SubjectStatus.completed: return Colors.green;
      case SubjectStatus.failed: return Colors.red;
    }
  }

  void _showAddSubjectDialog(BuildContext context, StudentController controller) {
    final nameCtrl = TextEditingController();
    final codeCtrl = TextEditingController();
    final creditsCtrl = TextEditingController();
    final scheduleCtrl = TextEditingController();
    final professorCtrl = TextEditingController();
    SubjectType selectedType = SubjectType.mandatory;

    Get.dialog(
      AlertDialog(
        title: const Text('Add Subject'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Subject Name'),
              ),
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              TextField(
                controller: creditsCtrl,
                decoration: const InputDecoration(labelText: 'Credits'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: scheduleCtrl,
                decoration: const InputDecoration(labelText: 'Schedule'),
              ),
              TextField(
                controller: professorCtrl,
                decoration: const InputDecoration(labelText: 'Professor'),
              ),
              // ✅ CORREGIDO: initialValue en lugar de value (deprecated)
              DropdownButtonFormField<SubjectType>(
                initialValue: selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: SubjectType.values.map((t) {
                  return DropdownMenuItem(
                    value: t,
                    child: Text(t.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) selectedType = v;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && codeCtrl.text.isNotEmpty) {
                final subject = Subject(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameCtrl.text,
                  code: codeCtrl.text,
                  credits: int.tryParse(creditsCtrl.text) ?? 3,
                  type: selectedType,
                  schedule: scheduleCtrl.text,
                  professor: professorCtrl.text,
                );
                controller.enrollSubject(subject);
                Get.back();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}