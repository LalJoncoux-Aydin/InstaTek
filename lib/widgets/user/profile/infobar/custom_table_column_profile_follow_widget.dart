import 'package:flutter/material.dart';

class TableColumnProfileFollowWidget extends StatelessWidget {
  const TableColumnProfileFollowWidget({Key? key, required this.num, required this.label, required this.numPadding, required this.sizeLabel, required this.labelPadding}) : super(key: key);

  final int num;
  final String label;
  final double numPadding;
  final double sizeLabel;
  final double labelPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Container>[
        Container(
          margin: EdgeInsets.only(bottom: numPadding),
          child: Text(
            num.toString(),
            style: TextStyle(
              fontSize: sizeLabel,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: labelPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: sizeLabel - 2,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
