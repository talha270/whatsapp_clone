import 'package:fluttertoast/fluttertoast.dart';

import '../theme/style.dart';

void toast({required String message}){
  Fluttertoast.showToast(msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: tabColor,
      textColor: whiteColor,
      fontSize: 16.0);
}