import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth_screens/login_screen.dart';
import 'package:wanderlust/screens/sub_screens/privacy_policy.dart';

import 'package:wanderlust/screens/sub_screens/terms_conditions.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_listtile.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';

import 'package:wanderlust/widgets/global/custom_textfield.dart';

class EditprofileTIle extends StatefulWidget {
  User? currentUser;
  int? currentUserIndex;
  EditprofileTIle({
    super.key,
    required this.currentUser,
    required this.currentUserIndex,
  });

  @override
  State<EditprofileTIle> createState() => _EditprofileTIleState();
}

class _EditprofileTIleState extends State<EditprofileTIle> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKeyThree = GlobalKey<FormState>();

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(
        text: widget.currentUser?.email ?? 'no email value');
    phoneController = TextEditingController(
        text: widget.currentUser?.phone.toString() ?? 'no phone value');
    log('InitState - Email: ${emailController.text}, Phone: ${phoneController.text}');
  }

  @override
  void didUpdateWidget(covariant EditprofileTIle oldWidget) {
    if (widget.currentUser != oldWidget.currentUser) {
      emailController.text = widget.currentUser?.email ?? 'No email value';
      phoneController.text =
          widget.currentUser?.phone.toString() ?? 'No phone value';

      log('didUpdateWidget - Updated Email: ${emailController.text}, Phone: ${phoneController.text}');
    }
    super.didUpdateWidget(oldWidget);
  }

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
                    content: Form(
                      key: _formKeyThree,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GlobalTextField(
                              controller: emailController,
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter a email address";
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return "Please enter a valid emaid address";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GlobalTextField(
                              controller: phoneController,
                              prefixIcon: Icons.phone,
                              labelText: 'Phone',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter phone number';
                                } else if (!RegExp(r'^\d{10}$')
                                    .hasMatch(value)) {
                                  return 'Enter valid phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
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
                            if (_formKeyThree.currentState!.validate()) {
                              if (widget.currentUser != null &&
                                  widget.currentUserIndex != null) {
                                try {
                                  widget.currentUser!.email =
                                      emailController.text;
                                  widget.currentUser!.phone =
                                      int.parse(phoneController.text);

                                  await _userService.updateUser(
                                      widget.currentUserIndex!,
                                      widget.currentUser!);

                                  log('Updated user profile,  email: ${widget.currentUser!.email} phone: ${widget.currentUser!.phone}');
                                } catch (e) {
                                  log('error while editing user details $e');
                                }
                                Navigator.pop(context);
                              } else {
                                log('current user is null');
                              }
                            }
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
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
                            customSnackBar(context, 'Logout successful!');
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Privacy(),
                ));
          },
          child: const CustomListTile(
              leadingIcon: Icons.lock, text: 'Privacy Policy')),
    );
  }
}

class TermsListtile extends StatelessWidget {
  const TermsListtile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsConditions(),
                ));
          },
          child: const CustomListTile(
              leadingIcon: Icons.list, text: 'Terms and Conditions')),
    );
  }
}
