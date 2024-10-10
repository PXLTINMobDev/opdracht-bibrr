import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Settingpagescreen extends StatefulWidget {
  const Settingpagescreen({super.key});

  @override
  _SettingpagescreenState createState() => _SettingpagescreenState();
}

class _SettingpagescreenState extends State<Settingpagescreen> {
  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 4),
                    image: DecorationImage(
                      image: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider
                          : const NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: _pickImage, 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // edit username
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
