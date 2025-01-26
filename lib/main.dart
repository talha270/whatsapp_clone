import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/app/splash_screen/splashscreen.dart';
import 'features/app/theme/style.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        dialogBackgroundColor: appBarColor,
        appBarTheme: const AppBarTheme(
        color: backgroundColor
        )
      ),
      home: Splashscreen() ,
    );
  }
}
