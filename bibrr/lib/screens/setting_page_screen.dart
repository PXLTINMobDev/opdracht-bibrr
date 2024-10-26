import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert'; // Import for JSON handling
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:lottie/lottie.dart';

class Settingpagescreen extends StatefulWidget {
  const Settingpagescreen({super.key});

  @override
  _SettingpagescreenState createState() => _SettingpagescreenState();
}

class _SettingpagescreenState extends State<Settingpagescreen> {
  File? _imageFile;
  String _username = "Username"; // This will hold the updated username
  final TextEditingController _usernameController = TextEditingController();

  // Map to hold strings loaded from JSON
  final Map<String, String> _strings = {};
  Color _imageBorderColor = Colors.white; // Initial border color for the image
  Color _usernameBorderColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _loadUsernameAndImage();
    _loadStrings(); // Load strings from JSON
  }

  // Load strings from the JSON file
  Future<void> _loadStrings() async {
    try {
      final String response =
          await rootBundle.loadString('assets/strings.json');
      final data = json.decode(response) as Map<String, dynamic>;
      _strings
          .addAll(data.map((key, value) => MapEntry(key, value.toString())));

      // Set the username to the default string from the JSON if it's not set
      _username = _strings['default_username'] ??
          _username; // Use the JSON default if available
    } catch (e) {
      print('Error loading strings: $e'); // Print error for debugging
    }
  }

  Future<void> _loadUsernameAndImage() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _username = preferences.getString('username') ??
          _username; // Load saved username or use the initialized value
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
        _triggerImageBorderAnimation();
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
                  _triggerUsernameBorderAnimation(); // Update the username
                });
                _saveUsername(_username); // Save the updated username
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _triggerImageBorderAnimation() {
    setState(() {
      _imageBorderColor = Colors.blueAccent; // Highlight color for image border
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _imageBorderColor = Colors.white; // Revert to the original color
      });
    });
  }

  void _triggerUsernameBorderAnimation() {
    setState(() {
      _usernameBorderColor =
          Colors.blueAccent; // Highlight color for username border
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _usernameBorderColor = Colors.transparent; // Revert to no border
      });
    });
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
       body: Stack(
        children: [
          Container(
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
                        border: Border.all(color: _imageBorderColor, width: 4),
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
                        onPressed: () => _showPicker(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _usernameBorderColor, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _username,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: _editUsername,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Lottie.asset(
              'assets/Animation.json',
              width: 100,
              height: 100,
              repeat: true,
              animate: true,
            ),
          ),
        ],
      ),
    );
  }
}