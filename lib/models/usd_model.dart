import 'package:cloud_firestore/cloud_firestore.dart';

class UsdtModel {
  final String? id;
  final String invoice;
  final String usd;

  UsdtModel({
    this.id,
    required this.invoice,
    required this.usd,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'usd': usd,
    };
  }

  factory UsdtModel.fromDocument(DocumentSnapshot doc) {
    return UsdtModel(
      id: doc.id,
      invoice: doc['invoice'],
      usd: doc['usd'],
    );
  }
}
