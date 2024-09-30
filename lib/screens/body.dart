import 'package:bill_maker/local/key_id.dart';
import 'package:bill_maker/models/bill_model.dart';
import 'package:bill_maker/models/contact_model.dart';
import 'package:bill_maker/models/item_model.dart';
import 'package:bill_maker/models/usd_model.dart';
import 'package:bill_maker/screens/bill.dart';
import 'package:bill_maker/services/bill_services.dart';
import 'package:bill_maker/services/contact_services.dart';
import 'package:bill_maker/services/item_services.dart';
import 'package:bill_maker/services/usd_services.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:bill_maker/widgets/input.dart';
import 'package:bill_maker/widgets/item_card.dart';
import 'package:bill_maker/widgets/popup.dart';
import 'package:coustom_flutter_widgets/input_feild.dart';
import 'package:coustom_flutter_widgets/page_animation.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => BodyHomeState();
}

class BodyHomeState extends State<BodyHome> {
  TextEditingController invoice = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();

  bool isCreate = false;
  int invoiceId = 0;
  List<ItemModel> _allItems = [];
  List<BillModel> _allBill = [];
  List<ContactModel> _contactInfo = [];
  List<UsdtModel> _allUSD = [];

  double get totalPrice =>
      _allItems.fold(0, (sum, item) => sum + (item.qty * item.price));

  Future<void> _getInvoice() async {
    int getid = await InvoiceId().getId();
    if (mounted) {
      setState(() {
        invoiceId = getid;
        invoice.text = getid.toString();
      });
    }
  }

  Future<void> _getItems() async {
    final data = await ItemsServices().getItemsByName("invoiceId");
    final bill = await BillServices().getBillByName("invoice");
    final dataCon = await ContactServices().getContactInfo();
    final usd =
        await UsdServices().getUSDByName("invoice", invoiceId.toString());
    if (mounted) {
      setState(() {
        _allUSD = usd;
        if (_allUSD.isEmpty) {
          UsdServices().addUSD(invoiceId.toString(), "0000");
        }
        _contactInfo = dataCon;
        _allItems = data;
        _allBill = bill;
        if (_allBill.isNotEmpty) {
          isCreate = true;
          customerName.text = _allBill[0].coustomoer;
        } else {
          isCreate = false;
        }
      });
    }
  }

  Future<void> _usdAdd() async {
    int getid = await InvoiceId().getId();
    // await UsdServices().addUSD(getid.toString(), "0");
    final usd = await UsdServices().getUSDByName("invoice", getid.toString());
    if (usd.isEmpty) {
      await UsdServices().addUSD(getid.toString(), "1111");
    }
  }

  @override
  void initState() {
    super.initState();
    _usdAdd();
    _getInvoice();
    _getItems();
  }

  @override
  void dispose() {
    invoice.dispose();
    customerName.dispose();
    item.dispose();
    qty.dispose();
    price.dispose();
    super.dispose();
  }

  Future<void> _deleteItems(id) async {
    await ItemsServices().deleteItems(id);
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  CoustomPopupWindow(
                    actionButtons: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          item.clear();
                          qty.clear();
                          price.clear();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                         
                          if (isCreate) {
                            if (item.text.isNotEmpty &&
                                qty.text.isNotEmpty &&
                                price.text.isNotEmpty) {
                              try {
                                await ItemsServices().addItems(
                                  invoiceId,
                                  item.text,
                                  int.parse(qty.text),
                                  int.parse(price.text),
                                );

                                item.clear();
                                qty.clear();
                                price.clear();

                                await _getItems();

                                if (_allUSD.isNotEmpty) {
                                  await UsdServices().updateData(
                                    _allUSD[0].id.toString(),
                                    invoiceId.toString(),
                                    totalPrice.toString(),
                                  );
                                }

                                Navigator.pop(context);
                              } catch (e) {}
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enter customer name and create bill'),
                              ),
                            );
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                    content: SizedBox(
                      height: 20.cmph(context),
                      child: Column(
                        children: [
                          CoustomInputWidget(
                            controller: item,
                            hintText: "Item name",
                          ),
                          5.ph,
                          CoustomInputWidget(
                            controller: qty,
                            hintText: "Qty",
                          ),
                          5.ph,
                          CoustomInputWidget(
                            controller: price,
                            hintText: "USD",
                          ),
                        ],
                      ),
                    ),
                  ).showPopup(context);
                },
                icon: Icon(
                  Icons.add_box,
                  color: AppColors().primary,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  InvoiceId().saveId(invoiceId + 1);
                  customerName.clear();
                  _getItems();
                  _getInvoice();
                  setState(() {
                    isCreate = false;
                  });
                  Navigator.push(
                    context,
                    CoustomAnimation.pageAnimation(
                      BillPrintPage(
                        invoice: invoiceId,
                        emailAddres: _contactInfo.isNotEmpty
                            ? _contactInfo[0].email
                            : '',
                        phoneNumber: _contactInfo.isNotEmpty
                            ? _contactInfo[0].number
                            : '',
                      ),
                      const Offset(1.0, 0.0),
                      Offset.zero,
                      Curves.easeInOut,
                      500,
                    ),
                  );
                },
                icon: Icon(
                  Icons.print,
                  color: AppColors().primary,
                  size: 50,
                ),
              ),
            ],
          ),
          5.ph,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppInput(
                    controller: invoice,
                    hintText: "Invoice id",
                  ),
                  AppInput(
                    controller: customerName,
                    hintText: "Customer name",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!isCreate) {
                            if (customerName.text.isNotEmpty) {
                              try {
                                BillServices().addBill(
                                  invoice.text,
                                  customerName.text,
                                  DateTime.now().toString(),
                                );
                                setState(() {
                                  isCreate = true;
                                });
                              } catch (e) {
                                setState(() {
                                  isCreate = false;
                                });
                              }
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isCreate
                                ? const Text("Done")
                                : const Text("Create"),
                          ],
                        ),
                      ),
                      Text(
                        " $totalPrice USD",
                        style: AppStyle().normal.copyWith(
                              color: AppColors().secondary,
                            ),
                      )
                    ],
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _allItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 0,
                      childAspectRatio: 16 / 8.2,
                    ),
                    itemBuilder: (context, index) {
                      return ItemCard(
                        callBackDelete: () {
                          _deleteItems(_allItems[index].id);
                        },
                        item: _allItems[index].item,
                        qty: _allItems[index].qty.toString(),
                        usd: _allItems[index].price.toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
