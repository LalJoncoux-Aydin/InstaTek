import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/models/user.dart' as model;
import 'package:instatek/screens/auth/login_screen.dart';
import 'package:instatek/widgets/tools/custom_delete_button.dart';
import 'package:instatek/widgets/tools/custom_error_text_widget.dart';
import 'package:provider/provider.dart';
import '../../../layout/admin_screen_layout.dart';
import '../../../layout/mobile_screen_layout.dart';
import '../../../layout/responsive_layout_screen.dart';
import '../../../layout/web_screen_layout.dart';
import '../../../methods/auth_methods.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/tools/custom_image_picker_widget.dart';
import '../../../widgets/tools/custom_loading_screen.dart';
import '../../../widgets/tools/custom_text_form_field_widget.dart';
import '../../../widgets/tools/custom_validation_button.dart';

class ModifyProfile extends StatefulWidget {
  const ModifyProfile({Key? key}) : super(key: key);

  @override
  State<ModifyProfile> createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  late UserProvider userProvider;
  late model.User myUser;
  late String? username;
  late String? bio;
  late String? photoUrl;
  Uint8List? _image;
  bool _isLoading = false;
  bool _isLoadingButton = false;
  late String errorText = "";
  late String uid = "";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        username = myUser.username;
        bio = myUser.bio;
        photoUrl = myUser.avatarUrl;
        uid = myUser.uid;
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _bioController.dispose();
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

    if (_isLoading == false) {
      setupUser();
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text(
            "Modify profil",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: <Expanded>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: paddingGlobal),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          CustomImagePicker(
                            imagePick: _image,
                            onPressedFunction: selectImage,
                          ),
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
                            displayText: 'Update profil',
                            formKey: formKey,
                            loadingState: _isLoadingButton,
                            onTapFunction: updateUser,
                            buttonColor: Theme.of(context).colorScheme.tertiary,
                          ),
                          CustomDeleteButton(
                            displayText: 'Delete profil',
                            loadingState: _isLoadingButton,
                            onTapFunction: deleteUser,
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
  }

  void deleteUser(BuildContext context) async {
    setState(() {
      _isLoadingButton = true;
    });
    final String res = await AuthMethods().deleteUser();
    setState(() {
      _isLoadingButton = false;
    });
    if (res == "success") {
      await AuthMethods().signOut();
      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    } else {
      setState(() {
        errorText = "A server error happened : $res";
      });
    }
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

  void updateUser(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoadingButton = true;
      });
      final String res = await AuthMethods().updateUser(
        username: _usernameController.text,
        bio: _bioController.text,
        profilePicture: _image,
      );
      setState(() {
        _isLoadingButton = false;
      });

      // if res is Success, go to next page
      if (res == "Success") {
        if (!mounted) return;
        navigateToRegister();
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

  void navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
          adminScreenLayout: AdminScreenLayout(),
        ),
      ),
    );
  }
}
