import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import library

class DetailKosPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailKosPage({super.key, required this.data});

  // Fungsi untuk membuka WhatsApp
  Future<void> _bukaWhatsApp(String nomor) async {
    // Pastikan nomor diawali dengan 62 (bukan 0)
    String phone = nomor.startsWith('0') ? '62${nomor.substring(1)}' : nomor;

    final Uri url = Uri.parse(
      "https://wa.me/$phone?text=Halo, saya tertarik dengan kos ${data['nama']}",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak bisa membuka WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['nama'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data['image_url'],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['nama'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp ${data['harga']} / bulan",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 30),
                  const Text(
                    "Alamat:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['alamat']),
                  const SizedBox(height: 30),

                  // TOMBOL PESAN (Interaksi User)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _bukaWhatsApp(data['whatsapp'] ?? ""),
                      icon: const Icon(Icons.message, color: Colors.white),
                      label: const Text(
                        "Hubungi Pemilik via WhatsApp",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
