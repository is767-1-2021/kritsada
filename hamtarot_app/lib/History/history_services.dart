import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hamtarot_app/History/history_model.dart';

abstract class Services {
  Future<List<History>> getHistory();
  final user = FirebaseAuth.instance.currentUser;
}

class HistoryServices extends Services {
  @override
  Future<List<History>> getHistory () async {
    QuerySnapshot snapshot =
      await FirebaseFirestore
      .instance
      .collection('ham_history')
      .where('email', isEqualTo: user!.email)
      .get();

    AllHistory history = AllHistory.fromSnapshot(snapshot);
    return history.history;
  }
}