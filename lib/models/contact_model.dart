import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String? id;
  final String email;
  final String number;

  ContactModel({
    this.id,
    required this.email,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': number,
    };
  }

  factory ContactModel.fromDocument(DocumentSnapshot doc) {
    return ContactModel(
      id: doc.id,
      email: doc['email'],
      number: doc['password'],
    );
  }
}
