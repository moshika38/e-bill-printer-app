import 'package:bill_maker/models/bill_model.dart';
import 'package:bill_maker/models/contact_model.dart';
import 'package:bill_maker/services/bill_services.dart';
import 'package:bill_maker/services/contact_services.dart';
import 'package:bill_maker/services/item_services.dart';
import 'package:bill_maker/services/usd_services.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:bill_maker/utilis/fonts.dart';
import 'package:bill_maker/widgets/history_card.dart';
import 'package:coustom_flutter_widgets/size_extensiton.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<BillModel> _allBill = [];
  List<ContactModel> _contactInfo = [];

  Future<void> _getAllData() async {
    final bill = await BillServices().getAllBill();
    final dataCon = await ContactServices().getContactInfo();
    if (mounted) {
      setState(() {
        _contactInfo = dataCon;
        _allBill = bill;
      });
    }
  }

  Future<String> _searchTotal(String invoice) async {
    final usd = await UsdServices().getUSDByName("invoice", invoice);
    return usd[0].usd;
  }

  @override
  void initState() {
    super.initState();
    _getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "History",
              style: AppStyle().title.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
            20.ph,
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _allBill.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 16 / 7,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder<String>(
                  future: _searchTotal(_allBill[index].invoice),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching USD'));
                    }
                    final usdValue =
                        snapshot.data ?? '0'; // Default to '0' if null

                    return Historycard(
                      invoice: _allBill[index].invoice,
                      email:
                          _contactInfo.isNotEmpty ? _contactInfo[0].email : "",
                      number:
                          _contactInfo.isNotEmpty ? _contactInfo[0].number : "",
                      callBackDelete: () {
                        // Delete data
                        Navigator.pop(context);
                        BillServices()
                            .deleteBill(_allBill[index].id.toString());
                        ItemsServices().deleteItemsByName(
                            "invoiceId", _allBill[index].invoice);
                        _getAllData();
                      },
                      datetime: _allBill[index].datetime.split(' ')[0],
                      name: _allBill[index].coustomoer,
                      usd: "$usdValue USD",
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
