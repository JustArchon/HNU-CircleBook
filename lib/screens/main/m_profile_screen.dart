import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: const Center(
        child: Text(
          '프로필 페이지',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}