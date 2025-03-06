import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../app/theme/style.dart';

messagelayout({
  Color? messageBgColor,
  Alignment? alignment,
  DateTime? createAt,
  VoidCallback? onSwipe,
  String? message,
  bool? isShowTick,
  bool? isSeen,
  VoidCallback? onLongPress,
}) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: SwipeTo(
      onRightSwipe: (details) {
        if (onSwipe != null) {
          onSwipe;
        }
      },
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          alignment: alignment,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 5,right: 85,top: 5,bottom: 5),
                    constraints: BoxConstraints(maxWidth: Get.width * 0.8),
                    decoration: BoxDecoration(
                      color: messageBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$message",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  )
                ],
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        DateFormat.jm().format(createAt!),
                        style: const TextStyle(fontSize: 12, color: greyColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick == true
                          ? Icon(
                        isSeen == true ? Icons.done_all : Icons.done,
                        size: 16,
                        color: isSeen == true ? Colors.blue : greyColor,
                      )
                          : const SizedBox()
                    ],
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}