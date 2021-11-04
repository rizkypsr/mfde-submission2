import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BuildSubHeading extends StatelessWidget {
  const BuildSubHeading({Key? key, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
