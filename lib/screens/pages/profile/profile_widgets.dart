import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth/login/login_screen.dart';
import 'package:wanderlust/screens/pages/profile/profile_screen.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_listtile.dart';

import 'package:wanderlust/widgets/global/custom_textfield.dart';

class EditprofileTIle extends StatefulWidget {
  EditprofileTIle({
    super.key,
    required this.screenHeight,
    required this.currentEmailController,
    required this.currentPhoneController,
    required this.currentUser,
    required this.currentUserIndex,
  });
  var currentEmailController;
  var currentPhoneController;
  final double screenHeight;
  User? currentUser;
  int? currentUserIndex;
  @override
  State<EditprofileTIle> createState() => _EditprofileTIleState();
}

class _EditprofileTIleState extends State<EditprofileTIle> {
  late TextEditingController emailUpdateController;
  late TextEditingController phoneUpdateController;

  UserService _userService = UserService();

  @override
  void initState() {
    emailUpdateController =
        TextEditingController(text: widget.currentUser?.email);
    phoneUpdateController =
        TextEditingController(text: widget.currentUser?.phone.toString());
    super.initState();
  }

  // @override
  // void dispose() {
  //   emailUpdateController.dispose();
  //   phoneUpdateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: secondaryColor,
                    title: const Text(
                      'Edit Details',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GlobalTextField(
                              controller: emailUpdateController,
                              labelText: 'email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter a email address";
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return "Please enter a valid emaid address";
                                }
                                return null;
                              }),
                          SizedBox(
                            height: widget.screenHeight * 0.01,
                          ),
                          GlobalTextField(
                            controller: phoneUpdateController,
                            labelText: 'Phone',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter phone number';
                              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Enter valid phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: widget.screenHeight * 0.01,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white))),
                      TextButton(
                          onPressed: () async {
                            widget.currentEmailController =
                                emailUpdateController.text;
                            widget.currentPhoneController =
                                int.parse(phoneUpdateController.text);
                            log('this line is working');
                            if (widget.currentUser != null &&
                                widget.currentUserIndex != null) {
                              widget.currentUser!.email =
                                  emailUpdateController.text;
                              widget.currentUser!.phone =
                                  int.parse(phoneUpdateController.text);
                              await _userService.updateUser(
                                  widget.currentUserIndex!,
                                  widget.currentUser!);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                            // setState(() {});
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ));
        },
        child:
            const CustomListTile(leadingIcon: Icons.edit, text: 'Edit Profile'),
      ),
    );
  }
}

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 49, 52, 73),
                    title: const Text(
                      'Do yo want to logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          )),
                      TextButton(
                          onPressed: () async {
                            await setLoginState(false);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()),
                                (Route<dynamic> route) => false);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text('Logout successful!',
                                  style: TextStyle()),
                            ));
                          },
                          child: const Text(
                            'Ok',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ));
        },
        child: const CustomListTile(
            leadingIcon: Icons.logout_rounded, text: 'Logout'),
      ),
    );
  }
}

class PrivacyListtile extends StatelessWidget {
  const PrivacyListtile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: GestureDetector(
          onTap: () {},
          child: const CustomListTile(
              leadingIcon: Icons.lock, text: 'Privacy Policy')),
    );
  }
}
