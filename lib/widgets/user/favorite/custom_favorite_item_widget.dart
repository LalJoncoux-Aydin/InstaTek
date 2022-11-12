import 'package:flutter/cupertino.dart';

class CustomFavoriteItem extends StatelessWidget {
  const CustomFavoriteItem({Key? key, required this.followers}) : super(key: key);

  final List<dynamic> followers;

  @override
  Widget build(BuildContext context) {
    final double correctRatio = MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7);
    final Size size = MediaQuery.of(context).size;
    double paddingPosts = 0;
    if (size.width >= 1366) {
      paddingPosts = 10;
    } else {
      paddingPosts = 15;
    }

    print(followers);

    return Container(
      padding: EdgeInsets.only(top: paddingPosts),
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: followers.length,
          itemBuilder: (BuildContext context,int index) {
            return GestureDetector(
              child: Column(
                  children: [
                    Text(followers[index]),
                  ],
                ),
            );
          },
      ),
    );
  }
}
