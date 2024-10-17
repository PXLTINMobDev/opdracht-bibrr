import 'package:firebase_auth/firebase_auth.dart';
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
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _username = preferences.getString('username') ?? "Username";
      String? imagePath = preferences.getString('profile_image');
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
    prefs.setString('profile_image', imagePath);
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _saveImagePath(pickedFile.path);
    }
  }

void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
                  _username = _usernameController.text;
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

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],),
      body: Container(
        color: const Color.fromARGB(255, 64, 204, 255),
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
                    onPressed: ()=>  _showPicker(context),
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
