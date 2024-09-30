import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class BillRow extends StatelessWidget {
  final String text1;
  final String text2;
  const BillRow({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: AppColors().secondaryText,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 35.cmpw(context),
              child: Text(
                " $text1 : ",
                style: AppStyle().normal.copyWith(
                      color: AppColors().primaryText,
                    ),
              ),
            ),
            SizedBox(
              width: 55.cmpw(context),
              child: Text(
                text2,
                style: AppStyle().normal.copyWith(
                      color: AppColors().secondaryText,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
