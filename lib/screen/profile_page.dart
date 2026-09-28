import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.studentName,
    required this.studentId,
    required this.onLogout,
  });

  final String studentName;
  final String studentId;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 38,
                backgroundColor: Color(0xFFDDE9DF),
                child: Icon(Icons.person, size: 40, color: Color(0xFF285943)),
              ),
              const SizedBox(height: 14),
              Text(
                studentName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF20382D),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'NIM $studentId',
                style: const TextStyle(color: Color(0xFF68756D)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: const Text('Nama Mahasiswa'),
          subtitle: Text(studentName),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.numbers),
          title: const Text('NIM'),
          subtitle: Text(studentId),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFB64036),
            minimumSize: const Size.fromHeight(50),
            side: const BorderSide(color: Color(0xFFE5C9C3)),
          ),
        ),
      ],
    );
  }
}
