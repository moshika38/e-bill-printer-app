import 'dart:io';
import 'package:bill_maker/models/bill_model.dart';
import 'package:bill_maker/models/item_model.dart';
import 'package:bill_maker/screens/history.dart';
import 'package:bill_maker/services/bill_services.dart';
import 'package:bill_maker/services/item_services.dart';
import 'package:bill_maker/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class BillPrintPage extends StatefulWidget {
  final int invoice;
  final String emailAddres;
  final String phoneNumber;

  const BillPrintPage(
      {super.key,
      required this.invoice,
      required this.emailAddres,
      required this.phoneNumber});

  @override
  _BillPrintPageState createState() => _BillPrintPageState();
}

class _BillPrintPageState extends State<BillPrintPage> {
  List<ItemModel> _itemInfo = [];
  List<BillModel> _billInfo = [];
  bool isDownload = false;

  final pdf = pw.Document();

  Future<void> _getItems() async {
    final itemsData =
        await ItemsServices().getforPDF("invoiceId", widget.invoice);
    final billData =
        await BillServices().getForPDF("invoice", widget.invoice.toString());

    if (mounted) {
      setState(() {
        _itemInfo = itemsData;
        _billInfo = billData;
      });
    }
  }

  Future<void> createPDF() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Customer: ${_billInfo.isNotEmpty ? _billInfo[0].coustomoer : 'Unknown'}'),
              pw.SizedBox(height: 10),
              pw.Text('Bill Items:', style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ['Description', 'Quantity', 'Unit Price', 'Total'],
                data: _itemInfo.map((item) {
                  return [
                    item.item,
                    item.qty.toString(),
                    item.price.toStringAsFixed(2),
                    (item.qty * item.price).toStringAsFixed(2),
                  ];
                }).toList(),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Thank you for your business!',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Contact Information:'),
              pw.Text('Email: ${widget.emailAddres}'),
              pw.Text('Phone: ${widget.phoneNumber}'),
            ],
          );
        },
      ),
    );
  }

  Future<void> savePDF() async {
    Directory downloadsDir = Directory('/storage/emulated/0/Download');

    if (await downloadsDir.exists()) {
      final file = File('${downloadsDir.path}/invoice_${widget.invoice}.pdf');
      await file.writeAsBytes(await pdf.save());

       

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved to ${file.path}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:   Text('Downloads folder not found'),
        ),
      );
    }
  }

  double get totalPrice =>
      _itemInfo.fold(0, (sum, item) => sum + (item.qty * item.price));

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  Future<void> requestStoragePermission() async {
    await Permission.photos.request();
    await Permission.storage.request();
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
       
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().secondaryBackground,
      appBar: AppBar(
        title: const Text(
          'Preview',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors().secondaryText,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const History(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer: ${_billInfo.isNotEmpty ? _billInfo[0].coustomoer : 'Unknown'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bill Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _itemInfo.length,
                itemBuilder: (context, index) {
                  final item = _itemInfo[index];
                  return ListTile(
                    title: Text(item.item),
                    subtitle: Text('Quantity: ${item.qty}'),
                    trailing: Text(
                        '${(item.qty * item.price).toStringAsFixed(2)} USD'),
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Total'),
              trailing: Text('\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Thank you!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text("Contact Information:"),
                  Text("Email: ${widget.emailAddres}"),
                  Text("Phone: ${widget.phoneNumber}"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isDownload) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Multiple downloads are not allowed !"),
              ),
            );
          } else {
            setState(() {
              isDownload = true;
            });
            await requestStoragePermission();
            await createPDF();
            await savePDF();
          }
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
