import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Settingpagescreen extends StatefulWidget {
  const Settingpagescreen({super.key});

  @override
  _SettingpagescreenState createState() => _SettingpagescreenState();
}

class _SettingpagescreenState extends State<Settingpagescreen> {
  File? _imageFile;
  String _username = "Username"; 
  final TextEditingController _usernameController = TextEditingController(); 
  
   @override
  void initState() {
    super.initState();
    _loadUsernameAndImage(); 
  }

  Future<void> _loadUsernameAndImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "Username";
      String? imagePath = prefs.getString('profile_image');
      if (imagePath != null) {
        _imageFile = File(imagePath);
      }
    });
  }

  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username); 
  }

  Future<void> _saveImagePath(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', imagePath); // **Save the image file path**
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _saveImagePath(pickedFile.path); // **Cache the new image path**
    }
  }

  void _editUsername() {
    _usernameController.text = _username; 

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Username"),
          content: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  _username = _usernameController.text; // **Update the username**
                });
                _saveUsername(_username);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                Text(
                  _username, 
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: _editUsername, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
