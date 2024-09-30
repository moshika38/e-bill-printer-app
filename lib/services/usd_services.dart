import 'package:bill_maker/models/usd_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// services code

class UsdServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Total');

  // ADD data
  Future<void> addUSD(
    String invoice,
    String usd,
  ) async {
    final data = UsdtModel(invoice: invoice, usd: usd);
    await collection.add(data.toMap());
  }

  // GET all data
  Future<List<UsdtModel>> getAllUSD() async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) {
      return UsdtModel.fromDocument(doc);
    }).toList();
  }

  // GET single data
  Future<UsdtModel?> getSingleUSD(String id) async {
    DocumentSnapshot doc = await collection.doc(id).get();
    if (doc.exists) {
      return UsdtModel.fromDocument(doc);
    } else {
      return null;
    }
  }

  // GET WHERE data

  Future<List<UsdtModel>> getUSDByName(String where, String value) async {
    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value).get();

    return querySnapshot.docs.map((doc) {
      return UsdtModel.fromDocument(doc);
    }).toList();
  }

  Future<List<UsdtModel>> getForPDF(String where, String value) async {
    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value.toString()).get();

    return querySnapshot.docs.map((doc) {
      return UsdtModel.fromDocument(doc);
    }).toList();
  }

  // DELETE data
  Future<void> deleteUSD(String id) async {
    await collection.doc(id).delete();
  }

  // UPDATE data
  Future<void> updateData(String id, String invoice, String usd) async {
    final data = UsdtModel(invoice: invoice, usd: usd);
    await collection.doc(id).update(data.toMap());
     
  }
}



/*

==================================================================

  List<UsdtModel> _cateData = [];

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