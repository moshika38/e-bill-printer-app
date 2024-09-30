import 'package:bill_maker/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// services code

class ContactServices {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('email');

  // ADD data
  Future<void> addContactInfo(String email, String pass) async {
    final data = ContactModel(email: email, number: pass);
    await collection.add(data.toMap());
  }

  // GET all data

  Future<List<ContactModel>> getContactInfo() async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) {
      return ContactModel.fromDocument(doc);
    }).toList();
  }

  // UPDATE data
  Future<void> updateContactInfo(String id, String email, String pass) async {
    final data = ContactModel(email: email, number: pass);
    await collection.doc(id).update(data.toMap());
  }
}
