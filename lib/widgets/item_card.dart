import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? item;
  final String? qty;
  final String? usd;
  final VoidCallback callBackDelete;
  const ItemCard(
      {super.key, this.item, this.qty, this.usd, required this.callBackDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors().secondaryBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item ?? "Empty data",
                style: AppStyle().normal.copyWith(
                      color: AppColors().secondaryText,
                    ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Quantity : $qty",
                style: AppStyle().normal.copyWith(
                      color: AppColors().secondaryText,
                    ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Price : $usd USD",
                style: AppStyle().normal.copyWith(
                      color: AppColors().secondaryText,
                    ),
              ),
            ),
            10.ph,
            GestureDetector(
              onTap: callBackDelete,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors().secondary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delete",
                      style: AppStyle().normal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
