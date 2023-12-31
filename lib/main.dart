import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopy/constants/theme.dart';
import 'package:smart_shopy/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:smart_shopy/firebase/firebase_options/firebase_options.dart';
import 'package:smart_shopy/provider/app_provider.dart';
import 'package:smart_shopy/screens/auth_ui/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_shopy/widgets/bottom_bar/custom_bottom_bar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.PlatformOptions,
  );
  _initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Shopy',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}

_initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
