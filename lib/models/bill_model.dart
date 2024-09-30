import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  final String? id;
  final String invoice;
  final String coustomoer;
  final String datetime;

  BillModel({
    this.id,
    required this.invoice,
    required this.coustomoer,
    required this.datetime,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice': invoice,
      'coustomoer': coustomoer,
      'datetime': datetime,
    };
  }

 
  factory BillModel.fromDocument(DocumentSnapshot doc) {
    return BillModel(
      id: doc.id,
      invoice: doc['invoice'],
      coustomoer: doc['coustomoer'],
      datetime: doc['datetime'],
    );
  }
}
