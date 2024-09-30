import 'package:bill_maker/local/key_id.dart';
import 'package:bill_maker/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// services code

class ItemsServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('items');

  // ADD data
  Future<void> addItems(int invoic, String item, int qty, int price) async {
    final data =
        ItemModel(invoiceId: invoic, item: item, qty: qty, price: price);
    await collection.add(data.toMap());
  }

  // GET all data
  Future<List<ItemModel>> getAllItems() async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) {
      return ItemModel.fromDocument(doc);
    }).toList();
  }

  // GET single data
  Future<ItemModel?> getSingleItems(String id) async {
    DocumentSnapshot doc = await collection.doc(id).get();
    if (doc.exists) {
      return ItemModel.fromDocument(doc);
    } else {
      return null;
    }
  }

  // GET WHERE data

  Future<List<ItemModel>> getItemsByName(String where) async {
    final value = await InvoiceId().getId();

    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value).get();
    return querySnapshot.docs.map((doc) {
      return ItemModel.fromDocument(doc);
    }).toList();
  }

  Future<List<ItemModel>> getItemsByNameHistory(String where,int value) async {
    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value).get();
    return querySnapshot.docs.map((doc) {
      return ItemModel.fromDocument(doc);
    }).toList();
  }


  Future<List<ItemModel>> getforPDF(String where,int value) async {

    QuerySnapshot querySnapshot =
        await collection.where(where, isEqualTo: value).get();
    return querySnapshot.docs.map((doc) {
      return ItemModel.fromDocument(doc);
    }).toList();
  }

  Future<void> deleteItemsByName(String where, String value) async {
    
    QuerySnapshot querySnapshot = await collection
        .where(
          where,
          isEqualTo: int.parse(value),
        )
        .get();
    for (var doc in querySnapshot.docs) {
      await collection.doc(doc.id).delete();
    }
  }

  // DELETE data
  Future<void> deleteItems(String id) async {
    await collection.doc(id).delete();
  }
}


/*

==================================================================

  List<ItemModel> _cateData = [];

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