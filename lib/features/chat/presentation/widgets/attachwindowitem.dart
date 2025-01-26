import'package:flutter/material.dart';

import '../../../app/theme/style.dart';

attachwindowitem(
    {required IconData icon,
      required String title,
      required Color color,
      required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Column(
      children: [
        Container(
          height: 55,
          width: 55,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(icon),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(color: greyColor, fontSize: 13),
        )
      ],
    ),
  );
}
