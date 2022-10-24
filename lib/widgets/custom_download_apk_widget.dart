import 'dart:html';
import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

class CustomDownloadApk extends StatelessWidget {
  const CustomDownloadApk({Key? key}) : super(key: key);

  void downloadFile(dynamic url) {
    final AnchorElement anchorElement = AnchorElement(href: url);
    anchorElement.download = "Instatek-V1.apk";
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Text("Download Apk", style: TextStyle(color: blueColor)),
            ),
            GestureDetector(
              onTap: () => downloadFile("/build/app/outputs/flutter-apk/app-release.apk"),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("APK", style: TextStyle(fontWeight: FontWeight.bold, color: blueColor)),
              ),)
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
