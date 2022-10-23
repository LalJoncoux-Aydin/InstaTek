import 'package:flutter/cupertino.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({Key? key, required this.errorText}) : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          decoration: BoxDecoration(
              color: errorColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Oh snap !",
                      style: TextStyle(
                          fontSize: 18,
                          color: whiteColor,
                      ),
                    ),

                    Text(
                      errorText,
                      style: TextStyle(
                          fontSize: 12,
                          color: whiteColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
