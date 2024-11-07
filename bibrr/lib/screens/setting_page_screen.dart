import 'package:bibrr/services/LanguageService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Settingpagescreen extends StatefulWidget {
  const Settingpagescreen({super.key});

  @override
  _SettingpagescreenState createState() => _SettingpagescreenState();
}

class _SettingpagescreenState extends State<Settingpagescreen> {
  File? _imageFile;
  String _username = "Username";
  final TextEditingController _usernameController = TextEditingController();
  final Map<String, String> _strings = {};
  Color _imageBorderColor = Colors.white;
  Color _usernameBorderColor = Colors.transparent;
  String _languageFile = 'assets/strings.json';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
    _loadUsernameAndImage();
  }

  Future<void> _loadLanguagePreference() async {
    final preferences = await SharedPreferences.getInstance();
    String? storedFile = preferences.getString('language_file');
    if (storedFile != 'assets/strings.json' && storedFile != 'assets/string_dutch.json') {
      storedFile = 'assets/strings.json';
      preferences.setString('language_file', storedFile);
    }
    _languageFile = storedFile ?? 'assets/strings.json';
    _loadStrings();
    print("Loaded language file: $_languageFile");
  }

  Future<void> _loadStrings() async {
    try {
      final String response = await rootBundle.loadString(_languageFile);
      final data = json.decode(response) as Map<String, dynamic>;
      _strings.addAll(data.map((key, value) => MapEntry(key, value.toString())));
      setState(() {});
    } catch (e) {
      print('Error loading strings: $e');
    }
  }

  Future<void> _saveLanguagePreference(String languageFile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language_file', languageFile);
  }

  Future<void> _loadUsernameAndImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final preferences = await SharedPreferences.getInstance();
      setState(() {
        _username = preferences.getString('${user.uid}_username') ?? _username;
        String? imagePath = preferences.getString('${user.uid}_profile_image');
        if (imagePath != null) {
          _imageFile = File(imagePath);
        }
      });
    }
  }

  Future<void> _saveUsername(String username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('${user.uid}_username', username);
    }
  }

  Future<void> _saveImagePath(String imagePath) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('${user.uid}_profile_image', imagePath);
    }
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
                title: Text(_strings['gallery'] ?? 'Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(_strings['camera'] ?? 'Camera'),
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
          title: Text(_strings['edit_username'] ?? 'Edit Username'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: _strings['enter_new_username'] ?? 'Enter new username'),
          ),
          actions: [
            TextButton(
              child: Text(_strings['cancel'] ?? 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(_strings['save'] ?? 'Save'),
              onPressed: () {
                setState(() {
                  _username = _usernameController.text;
                  _triggerUsernameBorderAnimation();
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

  void _triggerImageBorderAnimation() {
    setState(() {
      _imageBorderColor = Colors.blueAccent;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _imageBorderColor = Colors.white;
      });
    });
  }

  void _triggerUsernameBorderAnimation() {
    setState(() {
      _usernameBorderColor = Colors.blueAccent;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _usernameBorderColor = Colors.transparent;
      });
    });
  }

  void _changeLanguage(String languageFile) async {
    final languageService = Provider.of<LanguageService>(context, listen: false);
    await languageService.setLanguage(languageFile);
    setState(() {
      _languageFile = languageFile;
      _loadStrings();
    });
    _saveLanguagePreference(languageFile);
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageService.getString('settings_title', 'Settings')),
        actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],
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
          Positioned(
            bottom: 20,
            right: 20,
            child: DropdownButton<String>(
              value: _languageFile,
              icon: const Icon(Icons.language),
              items: const [
                DropdownMenuItem(
                  value: 'assets/strings.json',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'assets/string_dutch.json',
                  child: Text('Nederlands'),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}