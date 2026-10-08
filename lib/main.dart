import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const _kGradient = [Color(0xFF5E35B1), Color(0xFF7E57C2)];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity3_biodata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF5E35B1), Color(0xFFEDE7F6), Colors.white],
          stops: [0.0, 0.45, 0.45],
        ),
      ),
      child: child,
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.deepPurple, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon = Icons.arrow_forward_rounded,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: Colors.deepPurple.withValues(alpha: 0.5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: _kGradient),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.deepPurple),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '—' : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _sectionController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sectionController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectEnrollmentPage(
          name: _nameController.text.trim(),
          section: _sectionController.text.trim(),
          course: _courseController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'User Registration',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 110, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PageHeader(
                icon: Icons.person_add_alt_1_rounded,
                title: 'Create Biodata',
                subtitle: 'Step 1 of 3 — Fill in your personal details',
              ),
              const SizedBox(height: 28),
              FormCard(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _sectionController,
                      decoration: const InputDecoration(
                        labelText: 'Section',
                        prefixIcon: Icon(Icons.group_outlined),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _courseController,
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                    ),
                    const SizedBox(height: 28),
                    GradientButton(
                      onPressed: _nextPage,
                      label: 'Next',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectEnrollmentPage extends StatefulWidget {
  const SubjectEnrollmentPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  final String name;
  final String section;
  final String course;

  @override
  State<SubjectEnrollmentPage> createState() => _SubjectEnrollmentPageState();
}

class _SubjectEnrollmentPageState extends State<SubjectEnrollmentPage> {
  final _subject1Controller = TextEditingController();
  final _time1Controller = TextEditingController();
  final _subject2Controller = TextEditingController();
  final _time2Controller = TextEditingController();

  @override
  void dispose() {
    _subject1Controller.dispose();
    _time1Controller.dispose();
    _subject2Controller.dispose();
    _time2Controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectVerificationPage(
          name: widget.name,
          section: widget.section,
          course: widget.course,
          subject1: _subject1Controller.text.trim(),
          time1: _time1Controller.text.trim(),
          subject2: _subject2Controller.text.trim(),
          time2: _time2Controller.text.trim(),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(height: 18, width: 4, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF372377),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Subject Enrollment',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 110, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PageHeader(
                icon: Icons.menu_book_rounded,
                title: 'Enroll Subjects',
                subtitle: 'Step 2 of 3 — Pick your subjects and times',
              ),
              const SizedBox(height: 28),
              FormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionLabel('Subject 1'),
                    TextField(
                      controller: _subject1Controller,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Mathematics',
                        prefixIcon: Icon(Icons.book_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _time1Controller,
                      decoration: const InputDecoration(
                        hintText: 'e.g. 8:00 AM - 9:00 AM',
                        prefixIcon: Icon(Icons.access_time_outlined),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel('Subject 2'),
                    TextField(
                      controller: _subject2Controller,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Science',
                        prefixIcon: Icon(Icons.book_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _time2Controller,
                      decoration: const InputDecoration(
                        hintText: 'e.g. 9:00 AM - 10:00 AM',
                        prefixIcon: Icon(Icons.access_time_outlined),
                      ),
                    ),
                    const SizedBox(height: 28),
                    GradientButton(
                      onPressed: _nextPage,
                      label: 'Next',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectVerificationPage extends StatefulWidget {
  const SubjectVerificationPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subject1,
    required this.time1,
    required this.subject2,
    required this.time2,
  });

  final String name;
  final String section;
  final String course;
  final String subject1;
  final String time1;
  final String subject2;
  final String time2;

  @override
  State<SubjectVerificationPage> createState() =>
      _SubjectVerificationPageState();
}

class _SubjectVerificationPageState extends State<SubjectVerificationPage> {
  bool _saving = false;

  Future<void> _confirm() async {
    if (_saving) return;
    setState(() => _saving = true);

    try {
      await FirebaseFirestore.instance.collection('biodata').add({
        'name': widget.name,
        'section': widget.section,
        'course': widget.course,
        'subject1': widget.subject1,
        'time1': widget.time1,
        'subject2': widget.subject2,
        'time2': widget.time2,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biodata saved to Firebase!'),
          backgroundColor: Color(0xFF2E7D32),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Subject Verification',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 110, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PageHeader(
                icon: Icons.fact_check_rounded,
                title: 'Details',
                subtitle: 'Step 3 of 3 — Review your filled-up form',
              ),
              const SizedBox(height: 28),
              FormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(
                      icon: Icons.person_outline,
                      label: 'Name',
                      value: widget.name,
                    ),
                    DetailRow(
                      icon: Icons.group_outlined,
                      label: 'Section',
                      value: widget.section,
                    ),
                    DetailRow(
                      icon: Icons.school_outlined,
                      label: 'Course',
                      value: widget.course,
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    DetailRow(
                      icon: Icons.book_outlined,
                      label: 'Subject 1',
                      value: widget.subject1,
                    ),
                    DetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'Time 1',
                      value: widget.time1,
                    ),
                    const SizedBox(height: 8),
                    DetailRow(
                      icon: Icons.book_outlined,
                      label: 'Subject 2',
                      value: widget.subject2,
                    ),
                    DetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'Time 2',
                      value: widget.time2,
                    ),
                    const SizedBox(height: 24),
                    _saving
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(
                                color: Colors.deepPurple,
                              ),
                            ),
                          )
                        : GradientButton(
                            onPressed: _confirm,
                            label: 'Confirm',
                            icon: Icons.cloud_upload_outlined,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
