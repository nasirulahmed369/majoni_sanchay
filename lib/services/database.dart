import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:majoni_sanchay/models/customer.dart';

class DatabaseService {
  final CollectionReference db = FirebaseFirestore.instance.collection('users');

  List<CustomerModel> _userListFromFirebabase(QuerySnapshot snap) {
    //Map<String, dynamic> data = snap.dat
    return snap.docs.map((doc) {
      return CustomerModel(
        name: doc.data()['name'] ?? '',
        payType: doc.data()['payType'] ?? '',
        totalAmount: doc.data()['totalAmount'] ?? 0,
        account: doc.data()['account'] ?? '',
        phone: doc.data()['phone'] ?? '',
        isActive: doc.data()['isActive'] ?? false,
        date: doc.data()['date'] ?? '',
      );
    }).toList();
  }

  // Get users stream
  Stream<List<CustomerModel>> get users {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map(_userListFromFirebabase);
    //return db.snapshots().map(_userListFromFirebabase);
  }
}
