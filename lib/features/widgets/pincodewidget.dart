import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../app/theme/style.dart';


Widget pincodewidget({required controller}){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 50),
    child: Column(
      children: [
        PinCodeFields(
          controller: controller,
          length: 6,
          activeBorderColor: tabColor,
          onComplete: (String pincode) {},
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        const Text("Enter your 6 digit code")
      ],
    ),
  );
}