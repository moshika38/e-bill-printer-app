import 'package:bill_maker/onboding/user.dart';
import 'package:bill_maker/screens/home_page.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:coustom_flutter_widgets/page_animation.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 300,
              height: 300,
            ),
            GestureDetector(
              onTap: () {
                SaveUser().saveUser(true);
                Navigator.push(
                  context,
                  CoustomAnimation.pageAnimation(
                    const HomePage(),
                    const Offset(1.0, 0.0),
                    Offset.zero,
                    Curves.easeInOut,
                    500,
                  ),
                );
              },
              child: Container(
                width: 220,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors().secondary,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: AppColors().primaryText,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Get Start",
                    style: AppStyle().normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
