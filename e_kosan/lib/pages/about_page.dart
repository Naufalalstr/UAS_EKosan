import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Aplikasi")),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "E-Kosan App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Versi 1.0.0"),
            SizedBox(height: 20),
            Text(
              "Aplikasi ini dirancang untuk memudahkan pencarian dan pengelolaan kos-kosan secara digital. "
              "Pengguna dapat mencari kos berdasarkan nama, melihat detail harga, dan menghubungi pemilik langsung."
              "\n\nCopyright By"
              "\n1. Naufal Annafi Alistair (23552011308)"
              "\n2. Irfan Slamet Fadhlurrahman (23552011414)"
              "\n3. Rafi Nur Muhammad Fauzi (23552011307)"
              "\n4. Ardika Nurdiansyah (23552011311)"
              "\n5. Farhan Permana (23552011325)",
              textAlign: TextAlign.justify,
            ),
            Spacer(),
            Center(
              child: Text(
                "Dibuat untuk Tugas UAS Pemrograman Mobile",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
