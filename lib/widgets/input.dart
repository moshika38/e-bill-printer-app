import 'package:bill_maker/utilis/colors.dart';
import 'package:coustom_flutter_widgets/input_feild.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  const AppInput({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: CoustomInputWidget(
        controller: controller,
        borderColor: AppColors().tertiart,
        borderRadius: 10,
        heigth: 18,
        hintText: hintText,
        backGroundColor: AppColors().primaryBackground,
        focusBorderColor: AppColors().secondary,
      ),
    );
  }
}
