import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk mengambil teks input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Pencari Kos'; // Default role

  Future signUp() async {
    try {
      // 1. Buat Akun di Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // 2. Simpan Detail User (Role) ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'email': _emailController.text.trim(), 'role': _selectedRole});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil Daftar! Silahkan Login")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun E-Kosan")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih Role (Poin 2.a UAS)
            DropdownButton<String>(
              value: _selectedRole,
              items: <String>['Pencari Kos', 'Pemilik Kos'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: const Text("Daftar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}
