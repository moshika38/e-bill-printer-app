import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String? id;
  final int invoiceId;
  final String item;
  final int qty;
  final int price;

  ItemModel({
    this.id,
    required this.invoiceId,
    required this.item,
    required this.qty,
    required this.price,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'item': item,
      'qty': qty,
      'price': price,
    };
  }

 
  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      id: doc.id,
      invoiceId: doc['invoiceId'],
      item: doc['item'],
      qty: doc['qty'],
      price: doc['price'],
    );
  }
}
