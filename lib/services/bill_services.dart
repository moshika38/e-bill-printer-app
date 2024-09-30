import 'package:bill_maker/local/key_id.dart';
import 'package:bill_maker/models/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// services code

class BillServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('bill');

  // ADD data
  Future<void> addBill(String invoice, String coustomoer,String time) async {
    final data = BillModel(invoice: invoice, coustomoer: coustomoer,datetime: time);
    await collection.add(data.toMap());
  }


  // GET all data
  Future<List<BillModel>> getAllBill() async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) {
      return BillModel.fromDocument(doc);
    }).toList();
  }

  // GET single data
  Future<BillModel?> getSingleBill(String id) async {
    DocumentSnapshot doc = await collection.doc(id).get();
    if (doc.exists) {
      return BillModel.fromDocument(doc);
    } else {
      return null;
    }
  }

  // GET WHERE data

  Future<List<BillModel>> getBillByName(String where) async {
    final value = await InvoiceId().getId();
    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value.toString()).get();

    return querySnapshot.docs.map((doc) {
      return BillModel.fromDocument(doc);
    }).toList();
  }

  Future<List<BillModel>> getForPDF(String where,String value) async {
    
    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value.toString()).get();

    return querySnapshot.docs.map((doc) {
      return BillModel.fromDocument(doc);
    }).toList();
  }

  // DELETE data
  Future<void> deleteBill(String id) async {
    await collection.doc(id).delete();
  }
}


/*

==================================================================

  List<BillModel> _cateData = [];

  @override
  void initState() {
    super.initState();
    _refreshCateData();
  }

  void _refreshCateData() async {
    final data = await FirestoreServices().getAllData();
    setState(() {
      _cateData = data;
    });
  }

=====================================================================

*/