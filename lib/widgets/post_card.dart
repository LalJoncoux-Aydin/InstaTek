import 'package:flutter/material.dart';
import 'package:instatek/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mobileBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1665597136817-e6b2d82f6e56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map((e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    )))
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                  'https://images.unsplash.com/photo-1661956602153-23384936a1d3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  fit: BoxFit.cover),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  )
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    child: Text(
                      '1,231 likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text: 'username',
                            style: const TextStyle(fontWeight: FontWeight.bold,),
                          ),
                          TextSpan(
                            text: ' Hey this is some description to be replaced',
                          ),
                        ]
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all 200 comments',
                        style: const TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '13/10/2022',
                        style: const TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
