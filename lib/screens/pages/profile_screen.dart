import 'dart:io';
//import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/screens/pages/page_widgets/profile_widgets.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/models/user.dart';

import 'package:wanderlust/service/signup_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  User? currentUser;
  int? currentUserIndex;
  File? _selectedImage;

  Future<void> _loadUserdata() async {
    List<User> users = await _userService.getUserData();

    if (users.isNotEmpty) {
      setState(() {
        currentUser = users.last;
        currentUserIndex = users.length - 1;
        emailController.text = currentUser!.email;
        phoneController.text = currentUser!.phone.toString();
        if (currentUser!.profileImage != null) {
          _selectedImage = File(currentUser!.profileImage!);
        }
      });
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

  Future<void> editUserDetails() async {
    currentUser!.email = emailController.text;
    currentUser!.phone = int.parse(phoneController.text);
    log('this line is working');
    if (currentUser != null && currentUserIndex != null) {
      await _userService.updateUser(currentUserIndex!, currentUser!);

      Navigator.pop(context);
    }
    setState(() {});
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
        child: Form(
          key: _formKey,
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
                currentEmailController: emailController,
                currentPhoneController: phoneController,
                screenHeight: screenHeight,
                currentUser: currentUser,
                currentUserIndex: currentUserIndex,
              ),
              const PrivacyListtile(),
              const LogoutTile(),
            ],
          ),
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
