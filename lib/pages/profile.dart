import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
    }
  }

  // Fungsi untuk menampilkan dialog pemilihan gambar
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.of(context).pop(); // Tutup dialog
                  await _pickImage(
                      ImageSource.camera); // Pilih gambar dari kamera
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Ambil dari Galeri'),
                onTap: () async {
                  Navigator.of(context).pop(); // Tutup dialog
                  await _pickImage(
                      ImageSource.gallery); // Pilih gambar dari galeri
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image == null
                        ? const NetworkImage(
                            'https://image.popmama.com/content-images/post/20211228/borutojpg-d974626c1f44f2ebc3c0577eab8a45aa.jpg?width=1200&height=800') // Ganti dengan URL gambar profil Anda
                        : FileImage(File(_image!.path)) as ImageProvider,
                  ),
                  Positioned(
                    bottom: -12,
                    right: -12,
                    child: IconButton(
                      icon:
                          const Icon(Icons.edit, color: Colors.blue, size: 30),
                      onPressed: _showImageSourceDialog,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Reza Dhifa Dhaus',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'redhidha@gmail.com',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Bio : ',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Text(
              'Deskripsi : ',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: () {
            //     // Tambahkan aksi tombol di sini
            //   },
            //   child: const Text('Edit Profile'),
            // ),
          ],
        ),
      ),
    );
  }
}

extension on TextTheme {
  get bodyText2 => null;

  get headline6 => null;

  get subtitle1 => null;

  get headline5 => null;
}
