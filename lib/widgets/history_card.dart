import 'package:bill_maker/screens/bill.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:bill_maker/widgets/popup.dart';
import 'package:coustom_flutter_widgets/input_feild.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class Historycard extends StatefulWidget {
  final String name;
  final String datetime;
  final String usd;

  final String invoice;
  final String email;
  final String number;
  final VoidCallback callBackDelete;
  const Historycard({
    super.key,
    required this.name,
    required this.datetime,
    required this.callBackDelete,
    required this.usd,
    required this.invoice,
    required this.email,
    required this.number,
  });

  @override
  State<Historycard> createState() => _HistorycardState();
}

class _HistorycardState extends State<Historycard> {
  bool isMove = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController passcode = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillPrintPage(
                        emailAddres: widget.email,
                        invoice: int.parse(widget.invoice),
                        phoneNumber: widget.number,
                      ),
                    ),
                  );
                },
                onTap: () {
                  setState(() {
                    isMove = !isMove;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isMove ? 75.cmpw(context) : 90.cmpw(context),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors().secondaryBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice : ${widget.invoice} ",
                            style: AppStyle().normal.copyWith(
                                  fontSize: 15,
                                  color: AppColors().secondaryText,
                                ),
                          ),
                          25.ph,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 35.cmpw(context),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    widget.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle().normal.copyWith(
                                          color: AppColors().secondaryText,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.datetime,
                                style: AppStyle().normal.copyWith(
                                      fontSize: 14,
                                      color: AppColors().secondaryText,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // const SizedBox(height: 6),
                          Text(
                            widget.usd,
                            style: AppStyle().normal.copyWith(
                                  fontSize: 18,
                                  color: AppColors().secondary,
                                ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // delete button
          Visibility(
            visible: isMove,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                height: 140,
                width: 13.cmpw(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent,
                ),
                child: IconButton(
                  onPressed: () {
                    CoustomPopupWindow(
                      actionButtons: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (passcode.text == "0000") {
                              widget.callBackDelete();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passcode not mached !'),
                                ),
                              );
                            }
                            setState(() {
                              isMove = false;
                            });
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                      content: CoustomInputWidget(
                        controller: passcode,
                        hintText: "Passcode",
                      ),
                    ).showPopup(context);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
