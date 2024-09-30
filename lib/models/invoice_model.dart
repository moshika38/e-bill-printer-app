import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceModel {
  final String? id;
  final int invoiceId;

  InvoiceModel({
    this.id,
    required this.invoiceId,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      
    };
  }

  factory InvoiceModel.fromDocument(DocumentSnapshot doc) {
    return InvoiceModel(
      id: doc.id,
      invoiceId: doc['invoiceId'],
      
    );
  }
}
