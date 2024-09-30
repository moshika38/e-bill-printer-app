import 'package:bill_maker/screens/body.dart';
import 'package:bill_maker/screens/history.dart';
import 'package:bill_maker/screens/settings.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    const History(),
    const BodyHome(),
    const Settings(),
  ];

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().alternate,
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: AppColors().primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 2;
                  });
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: pages[_index],
      ),
    );
  }
}
