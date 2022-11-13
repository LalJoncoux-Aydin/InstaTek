import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/global_variables.dart';
import '../../../tools/custom_validation_button.dart';

class CustomButtonProfile extends StatelessWidget {
    CustomButtonProfile({Key? key, required this.userUid, required this.isFollowed, required this.modifyAccount, required this.addFollowers, required this.removeFollowers, required this.theme, required this._isLoadingFollow}) : super(key: key);

  final String userUid;
  final bool isFollowed;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFollow = GlobalKey<FormState>();
  final bool _isLoadingFollow;
  final void Function(GlobalKey<FormState>, BuildContext? context) modifyAccount;
  final void Function(GlobalKey<FormState>, BuildContext? context) addFollowers;
  final void Function(GlobalKey<FormState>, BuildContext? context) removeFollowers;
  final Color theme;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingLeft = 0;
    double paddingRight = 0;
    double paddingVertical = 0;

    if (size.width >= webScreenSize) {
      paddingLeft = 0;
      paddingRight = 1000;
      paddingVertical = 5;
    } else {
      paddingLeft = 20;
      paddingRight = 20;
      paddingVertical = 10;
    }


    return Container(
      padding: EdgeInsets.only(top: paddingVertical, left: paddingLeft, right: paddingRight),
      child: whichButton(userUid, isFollowed, formKey, formKeyFollow, _isLoadingFollow, modifyAccount, addFollowers, removeFollowers, theme),
    );
  }

  Widget? whichButton(String userUid, bool isFollowed, GlobalKey<FormState> formKey, GlobalKey<FormState> formKeyFollow, bool isLoadingFollow, Function(GlobalKey<FormState>, BuildContext? context) modifyAccount, Function(GlobalKey<FormState>, BuildContext? context) addFollowers, Function(GlobalKey<FormState>, BuildContext? context) removeFollowers, Color theme) {
    if (userUid == "") {
      return CustomValidationButton(displayText: "Modify my account", formKey: formKey, loadingState: false, onTapFunction: modifyAccount, buttonColor: theme);
    } else if (isFollowed == false) {
      return CustomValidationButton(displayText: "Follow", formKey: formKeyFollow, loadingState: isLoadingFollow, onTapFunction: addFollowers, buttonColor: theme);
    } else if (isFollowed == true) {
      return CustomValidationButton(displayText: "Unfollow", formKey: formKeyFollow, loadingState: isLoadingFollow, onTapFunction: removeFollowers, buttonColor: theme);
    }
    return null;
  }
}
