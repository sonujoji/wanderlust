import 'dart:io';
//import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/widgets/feature/profile_widgets.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/models/user.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  User? currentUser;
  int? currentUserIndex;
  File? _selectedImage;

  Future<void> _loadUserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedInUsername = prefs.getString('loggedInUsername');

    if (loggedInUsername != null) {
      List<User> users = await _userService.getUserData();
      for (var i = 0; i < users.length; i++) {
        if (users[i].username == loggedInUsername) {
          setState(
            () {
              currentUser = users[i];
              currentUserIndex = i;
              if (currentUser!.profileImage != null) {
                _selectedImage = File(currentUser!.profileImage!);
              }
            },
          );
          break;
        } else {
          log('No logged-in user found');
        }
      }
    }
  }

  void setImage(File image) {
    setState(() {
      _selectedImage = image;
    });

    if (currentUser != null && currentUserIndex != null) {
      currentUser!.profileImage = image.path;
      _userService.updateUser(currentUserIndex!, currentUser!);
    }
  }

  @override
  void initState() {
    _loadUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Your Profile',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: grey, width: 15)),
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () async {
                    File? pickedImage = await pickImageFromGallery();
                    if (pickedImage != null) {
                      setImage(pickedImage);
                    }
                  },
                  child:
                      currentUser != null && currentUser!.profileImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.file(
                                fit: BoxFit.cover,
                                File(currentUser!.profileImage!),
                              ),
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              currentUser?.username ?? 'username',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            EditprofileTIle(            
              currentUser: currentUser,
              currentUserIndex: currentUserIndex,
            ),
            const PrivacyListtile(),
            const TermsListtile(),
            const LogoutTile(),
          ],
        ),
      ),
    );
  }

  Future<File?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
