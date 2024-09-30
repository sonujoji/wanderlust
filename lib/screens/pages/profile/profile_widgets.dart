import 'package:flutter/material.dart';
import 'package:wanderlust/screens/auth/login/login_screen.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailidUpdateController,
  });

  final TextEditingController emailidUpdateController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
        controller: emailidUpdateController,
        labelText: 'email',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter a email address";
          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return "Please enter a valid emaid address";
          }
          return null;
        });
  }
}

class PhoneTextfield extends StatelessWidget {
  const PhoneTextfield({
    super.key,
    required this.phoneUpdateController,
  });

  final TextEditingController phoneUpdateController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
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
    );
  }
}
class EditprofileTIle extends StatelessWidget {
  const EditprofileTIle({
    super.key,
    required this.emailidUpdateController,
    required this.screenHeight,
    required this.phoneUpdateController,
  });

  final TextEditingController emailidUpdateController;
  final double screenHeight;
  final TextEditingController phoneUpdateController;

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
                          EmailTextField(
                              emailidUpdateController:
                                  emailidUpdateController),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          PhoneTextfield(
                              phoneUpdateController:
                                  phoneUpdateController),
                          SizedBox(
                            height: screenHeight * 0.01,
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
                          onPressed: () {},
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 49, 52, 73)),
          child: const ListTile(
            leading: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
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
                    backgroundColor:
                        const Color.fromARGB(255, 49, 52, 73),
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
                                    builder: (context) =>
                                        const LogInScreen()),
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
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 49, 52, 73)),
          child: const ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
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
          
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 49, 52, 73)),
          child: const ListTile(
            leading: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Colors.white,
                  // Color.fromARGB(255, 27, 26, 26),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
