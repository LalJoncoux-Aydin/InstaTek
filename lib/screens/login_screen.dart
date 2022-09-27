import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our auth method
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    // if string returned is success, user has been created
    if (res == "Success") {
      setState(() {
        _isLoading = false;
      });
      // TODO NAVIGATE TO FEED
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: _buildBodyContainer())
        ));
  }

  Widget _buildBodyContainer() {
    // For the spacing
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        children: [
          Flexible(flex: 2, child: Container()),
          _buildHeader(),
          _buildInput('Enter your email', _emailController, false),
          _buildInput('Enter your password', _passwordController, true),
          _buildButton('Login'),
          Flexible(flex: 2, child: Container()),
          _buildNavLink("I don't have an account", "Register"),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 24),
        SvgPicture.asset(
          'assets/instatek_logo.svg',
          color: primaryColor,
          height: 44,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildInput(displayTxt, controller, pw) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextFieldInput(
          hintText: displayTxt,
          textInputType: TextInputType.text,
          textEditingController: controller,
          isPass: pw,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () => loginUser(),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
              color: blueColor,
            ),
            child: !_isLoading ? Text(displayTxt) : const CircularProgressIndicator(color: primaryColor),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildNavLink(displayText1, displayText2) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(displayText1),
            ),
            GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(displayText2,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ))
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}