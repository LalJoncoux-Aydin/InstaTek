import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/helper.dart';
import '../widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void registerUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text);
    // if string returned is sucess, user has been created
    if (res == "success") {
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

  void selectImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(flex: 2, child: Container()),
            // image
            SvgPicture.asset(
              'assets/instatek_logo.svg',
              color: primaryColor,
              height: 44,
            ),
            const SizedBox(height: 30),
            // my image
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor: Colors.red,
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                        // backgroundColor: Colors.red,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            TextFieldInput(
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),
            const SizedBox(
              height: 24,
            ),
            // text field email
            TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),
            // text field password
            TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your bio',
              textInputType: TextInputType.text,
              textEditingController: _bioController,
            ),
            const SizedBox(
              height: 24,
            ),
            // button login
            InkWell(
              onTap: registerUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
                child: !_isLoading
                    ? const Text(
                        'Register',
                      )
                    : const CircularProgressIndicator(
                        color: primaryColor,
                      ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(flex: 2, child: Container()),
            // transitioning
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("I already have an account"),
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Login",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
