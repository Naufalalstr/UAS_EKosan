import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddKosPage extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? data;

  const AddKosPage({super.key, this.docId, this.data});

  @override
  State<AddKosPage> createState() => _AddKosPageState();
}

class _AddKosPageState extends State<AddKosPage> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _imageLinkController = TextEditingController();
  final _whatsappController = TextEditingController(); // Controller Baru

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _namaController.text = widget.data!['nama'] ?? "";
      _hargaController.text = widget.data!['harga']?.toString() ?? "";
      _alamatController.text = widget.data!['alamat'] ?? "";
      _imageLinkController.text = widget.data!['image_url'] ?? "";
      _whatsappController.text =
          widget.data!['whatsapp'] ?? ""; // Ambil data lama jika EDIT
    }
  }

  Future simpanKos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Pastikan semua field terisi
      if (_namaController.text.isEmpty || _whatsappController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nama dan WhatsApp wajib diisi!")),
        );
        return;
      }

      final payload = {
        'nama': _namaController.text.trim(),
        'harga': int.tryParse(_hargaController.text.trim()) ?? 0,
        'alamat': _alamatController.text.trim(),
        'image_url': _imageLinkController.text.trim(),
        'whatsapp': _whatsappController.text.trim(), // Simpan nomor WA
        'owner_id': user.uid,
        'updated_at': Timestamp.now(),
      };

      if (widget.docId == null) {
        await FirebaseFirestore.instance.collection('kos_data').add(payload);
      } else {
        await FirebaseFirestore.instance
            .collection('kos_data')
            .doc(widget.docId)
            .update(payload);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docId == null ? "Tambah Data Kos" : "Edit Data Kos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama Kos"),
            ),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(labelText: "Harga per Bulan"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: "Alamat Lengkap"),
            ),
            TextField(
              controller: _imageLinkController,
              decoration: const InputDecoration(labelText: "Link URL Foto Kos"),
            ),
            // Input WhatsApp (Poin 2.h)
            TextField(
              controller: _whatsappController,
              decoration: const InputDecoration(
                labelText: "Nomor WhatsApp (Contoh: 628123...)",
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: simpanKos,
              child: Text(
                widget.docId == null ? "Simpan Data Kos" : "Update Data Kos",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
