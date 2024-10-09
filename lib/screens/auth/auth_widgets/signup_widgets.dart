import 'package:flutter/material.dart';

import 'package:wanderlust/widgets/global/custom_textfield.dart';

class UsernameTextfield extends StatelessWidget {
  const UsernameTextfield({
    super.key,
    required TextEditingController usernameController,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
      controller: _usernameController,
      labelText: 'Username',
      prefixIcon: Icons.person,
      validator: (value) =>
          value == null || value.isEmpty ? "Enter a Username" : null,
    );
  }
}

class EmailTextfield extends StatelessWidget {
  const EmailTextfield({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
        controller: _emailController,
        labelText: 'EmailId',
        prefixIcon: Icons.email,
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
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
        controller: _phoneController,
        labelText: 'Phone',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter phone number';
          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
            return 'Enter valid phone number';
          }
          return null;
        });
  }
}

class PasswordTextfield extends StatelessWidget {
  const PasswordTextfield({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
        controller: _passwordController,
        prefixIcon: Icons.lock,
        labelText: 'Password',
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter password' : null);
  }
}
