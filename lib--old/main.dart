import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psic_project/Screens/home_sceen.dart';
import 'package:psic_project/Screens/splash_screen.dart';
import 'package:psic_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterAppBadger.removeBadge();
  await Firebase.initializeApp(
    name: 'pakistan-live',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
