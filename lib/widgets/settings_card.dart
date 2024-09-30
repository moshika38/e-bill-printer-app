import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:bill_maker/widgets/input.dart';
import 'package:coustom_flutter_widgets/container_button.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatefulWidget {
  final TextEditingController controller;
  final String? hintName;
  final VoidCallback? callback;

  const SettingsCard({
    super.key,
    required this.controller,
    this.hintName,
    this.callback,
  });

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  double clickId = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: clickId == 1 ? 250 : 80,
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors().secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: AppColors().primaryText,
                  blurRadius: 5,
                  offset: const Offset(1, 1),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.hintName ?? "",
                      style: AppStyle().normal.copyWith(
                            color: AppColors().secondaryText,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (clickId == 1) {
                            clickId = 0;
                          } else {
                            clickId = 1;
                          }
                        });
                      },
                      child: Icon(
                        clickId == 1
                            ? Icons.arrow_drop_up_outlined
                            : Icons.arrow_drop_down,
                        color: AppColors().secondaryText,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: clickId == 1 ? true : false,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.ph,
                          AppInput(
                            controller: widget.controller,
                            hintText: "Enter your text",
                          ),
                          GestureDetector(
                            onTap: widget.callback,
                            child: CoustomButoon(
                              heith: 55,
                              width: 100,
                              borderColor: AppColors().primary,
                              bgColor: AppColors().primary,
                              text: "Save",
                              textColors: AppColors().secondaryBackground,
                              textStyle: AppStyle().normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
