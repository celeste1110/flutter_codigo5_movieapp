import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/general/colors.dart';

class TitleDescriptionWidget extends StatelessWidget {
  String title;

  TitleDescriptionWidget({required this.title});
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 3,
          width: 40,
          decoration: BoxDecoration(
            color: kBrandSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
