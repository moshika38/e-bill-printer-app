import 'package:bill_maker/onboding/landing.dart';
import 'package:bill_maker/onboding/user.dart';
import 'package:bill_maker/screens/home_page.dart';
import 'package:bill_maker/utilis/them_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUser = false;

  Future<void> _checkUser() async {
    bool isCheck = await SaveUser().getUser();
    setState(() {
      isUser = isCheck;
       
    });
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemData().lightThem,
      home: isUser ? const HomePage() : const LandingPage(),
    );
  }
}
