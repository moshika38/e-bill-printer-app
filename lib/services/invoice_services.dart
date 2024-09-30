import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addInvoice(String invoice) async {
    await firestore.collection("invoiceId").add({
      'name': invoice,
    }).then((value) {
      print("Invoice added successfully: ${value.id}");
    }).catchError((error) {
      print("Invoice added Failed : $error");
    });
  }

  void getInvoice() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection("invoiceId").get();

      for (var doc in querySnapshot.docs) {
        print('Document ID: ${doc.id}');
      }
    } catch (e) {
      print("Failed to fetch Invoice: $e");
    }
  }
}
