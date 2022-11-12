import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:instatek/utils/global_variables.dart';
import 'package:instatek/widgets/auth/header_login_register.dart';
import 'package:instatek/widgets/tools/custom_image_picker_widget.dart';

import '../../layout/admin_screen_layout.dart';
import '../../layout/mobile_screen_layout.dart';
import '../../layout/responsive_layout_screen.dart';
import '../../layout/web_screen_layout.dart';
import '../../methods/auth_methods.dart';
import '../../utils/utils.dart';
import '../../widgets/tools/custom_error_text_widget.dart';
import '../../widgets/tools/custom_text_form_field_widget.dart';
import '../../widgets/tools/custom_validation_button.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({Key? key, required this.emailController, required this.passwordController}) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<RegisterScreen2> createState() => _RegisterScreenState2();
}

class _RegisterScreenState2 extends State<RegisterScreen2> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  late String username = "";
  late String bio = "";
  late String errorText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingGlobal = 0;
    if (size.width >= 1366) {
      paddingGlobal = 500;
    } else {
      paddingGlobal = 60;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        const HeaderLoginRegister(),
                        CustomImagePicker(imagePick: _image, onPressedFunction: selectImage),
                        CustomTextFormField(
                          hintText: 'Enter your username',
                          textEditingController: _usernameController,
                          isPass: false,
                          isValid: usernameIsValid(username),
                          updateInput: updateUsername,
                        ),
                        CustomTextFormField(
                          hintText: 'Enter your bio',
                          textEditingController: _bioController,
                          isPass: false,
                          isValid: bioIsValid(bio),
                          updateInput: updateBio,
                        ),
                        CustomErrorText(displayStr: errorText),
                        CustomValidationButton(
                          displayText: 'Register',
                          formKey: formKey,
                          loadingState: _isLoading,
                          onTapFunction: registerUser,
                          shapeDecoration: null,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateUsername(dynamic newUsername) {
    setState(() {
      username = newUsername;
    });
  }
  String? usernameIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void updateBio(dynamic newBio) {
    setState(() {
      bio = newBio;
    });
  }
  String? bioIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void selectImage() async {
    final Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void registerUser(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      // set loading to true
      setState(() {
        _isLoading = true;
      });

      if (_image == null) {
        await http
            .get(
          Uri.parse(defaultAvatarUrl),
        )
            .then((http.Response response) {
          _image = response.bodyBytes;
        });
      }

      // signup user using our auth method
      final String res = await AuthMethods().registerUser(
        email: widget.emailController.text,
        password: widget.passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        profilePicture: _image,
      );

      setState(() {
        _isLoading = false;
      });
      // if string returned is success, user has been created
      if (res == "Success") {
        if (!mounted) return;
        await Navigator.of(context!).pushReplacement(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
              adminScreenLayout: AdminScreenLayout(),
            ),
          ),
        );
      } else if (res == 'username-already-in-use') {
        setState(() {
          errorText = "Username is already in use by another account";
        });
      } else {
        setState(() {
          errorText = "A server error happened : $res";
        });
      }
    } else {
      setState(() {
        errorText = "An internal error happened";
      });
    }
  }
}
