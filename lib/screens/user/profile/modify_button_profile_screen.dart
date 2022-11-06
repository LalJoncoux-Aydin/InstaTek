import 'package:flutter/cupertino.dart';
import '../../../utils/colors.dart';
import '../../../widgets/tools/custom_validation_button.dart';
import 'modify_profile_screen.dart';

class ModifyButtonProfile extends StatefulWidget {
  const ModifyButtonProfile({Key? key}) : super(key: key);

  @override
  State<ModifyButtonProfile> createState() => _ModifyButtonProfileState();
}

class _ModifyButtonProfileState extends State<ModifyButtonProfile> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ShapeDecoration modifyButton = const ShapeDecoration(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    color: greyColor,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double paddingButtonTop = 0;
    double paddingButtonBottom = 0;
    if (size.width >= 1366) {
      paddingButtonTop = 1;
      paddingButtonBottom = 1;
    } else {
      paddingButtonTop = 20;
      paddingButtonBottom = 2;
    }


    return Container(
      padding: EdgeInsets.only(top: paddingButtonTop, bottom: paddingButtonBottom),
      width: double.infinity,
      child: Form(
        key: formKey,
        child: CustomValidationButton(displayText: "Modify my account", formKey: formKey, loadingState: false, onTapFunction: modifyAccount, shapeDecoration: modifyButton),
      ),
    );
  }


  void modifyAccount(dynamic formKey, BuildContext? context) async {
    await Navigator.of(context!).push(
      transitionRoute(),
    );
  }

  Route<ModifyProfile> transitionRoute() {
    return PageRouteBuilder<ModifyProfile>(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => const ModifyProfile(),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        const Offset begin = Offset(0.0, 1.0);
        const Offset end = Offset.zero;
        const Cubic curve = Curves.ease;

        final Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
