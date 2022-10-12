import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instatek/widgets/header_login_register.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class RegisterScreen2 extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const RegisterScreen2({Key? key, required this.emailController, required this.passwordController}) : super(key: key);

  @override
  State<RegisterScreen2> createState() => _RegisterScreenState2();
}

class _RegisterScreenState2 extends State<RegisterScreen2> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
      padding: const EdgeInsets.symmetric(horizontal: 60),
      width: double.infinity,
      child: Column(
        children: [
          const HeaderLoginRegister(),
          _buildImageInput(),
          TextFieldInput(hintText: 'Enter your username', textEditingController: _usernameController, isPass: false),
          TextFieldInput(hintText: 'Enter your bio', textEditingController: _bioController, isPass: false),
          _buildButton('Register'),
        ],
      ),
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  Widget _buildImageInput() {
    return Column(
      children: [
        // image input
        const SizedBox(height: 10),
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
                icon: const Icon(
                    Icons.add_a_photo
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void registerUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our auth method
    String res = await AuthMethods().registerUser(
      email: widget.emailController.text,
      password: widget.passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      profilePicture : _image,
    );

    setState(() {
      _isLoading = false;
    });
    // if string returned is success, user has been created
    if (res == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // show the error
      showSnackBar(context, res);
    }
  }
  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 25),
        InkWell(
          onTap: () => registerUser(),
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
            child: !_isLoading ? Text(displayTxt, style: const TextStyle(color: whiteColor)) : const CircularProgressIndicator(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
