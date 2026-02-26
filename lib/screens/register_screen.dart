import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _programCtrl = TextEditingController();
  final _semesterCtrl = TextEditingController();
  
  StudentStatus _selectedStatus = StudentStatus.active;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _programCtrl.dispose();
    _semesterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Student'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person, size: 60, color: Colors.blue),
              const SizedBox(height: 24),
              
              _buildTextField(_nameCtrl, 'Full Name *', Icons.person, 
                validator: (v) => v?.isEmpty == true ? 'Required' : null),
              const SizedBox(height: 12),
              _buildTextField(_emailCtrl, 'Email *', Icons.email, 
                validator: (v) => v?.isEmpty == true ? 'Required' : null),
              const SizedBox(height: 12),
              _buildTextField(_phoneCtrl, 'Phone *', Icons.phone, 
                validator: (v) => v?.isEmpty == true ? 'Required' : null),
              const SizedBox(height: 12),
              _buildTextField(_programCtrl, 'Program *', Icons.school, 
                validator: (v) => v?.isEmpty == true ? 'Required' : null),
              const SizedBox(height: 12),
              _buildTextField(_semesterCtrl, 'Semester *', Icons.numbers, 
                isNumber: true, validator: (v) => v?.isEmpty == true ? 'Required' : null),
              const SizedBox(height: 12),
              _buildStatusDropdown(),
              
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Register Student', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    bool isNumber = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<StudentStatus>(
      initialValue: _selectedStatus,
      decoration: InputDecoration(
        labelText: 'Status',
        prefixIcon: const Icon(Icons.flag, color: Colors.blue),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: StudentStatus.values.map((status) {
        return DropdownMenuItem(
          value: status,
          child: Text(status.toString().split('.').last.toUpperCase()),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) setState(() => _selectedStatus = value);
      },
    );
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        phone: _phoneCtrl.text,
        program: _programCtrl.text,
        semester: int.tryParse(_semesterCtrl.text) ?? 1,
        status: _selectedStatus,
        registrationDate: DateTime.now(),
      );
      
      Get.find<StudentController>().addStudent(student);
      Get.back();
    }
  }
}