import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File yang kita buat tadi lewat terminal
import 'pages/register_page.dart'; // Import halaman daftar
import 'pages/login_page.dart';

void main() async {
  // Pastikan plugin Flutter siap digunakan
  WidgetsFlutterBinding.ensureInitialized();

  // Mengaktifkan koneksi ke project Firebase e-kosan-mobile
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner debug di pojok kanan
      title: 'E-Kosan Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Opsional: Agar tampilan lebih modern
      ),
      // Halaman pertama yang dibuka adalah halaman registrasi
      home: const LoginPage(),
    );
  }
}
