import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String email;
  final String result;
  final Timestamp historydate;

  History(this.email, this.result, this.historydate);

  factory History.fromJson(
    Map<String, dynamic> json,
  ) {
    return History(
      json['email'] as String,
      json['result'] as String,
      json['historydate'] as Timestamp,
    );
  }
}

class AllHistory {
  final List<History> history;
  AllHistory (this.history);

  factory AllHistory .fromJson(List<dynamic> json) {
    List<History> history;

    history = json.map((index) => History.fromJson(index)).toList();
    
    return AllHistory (history);
  }

  factory AllHistory .fromSnapshot(QuerySnapshot s) {
    List<History> history = s.docs.map((DocumentSnapshot ds) {
      return History.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();

    return AllHistory (history);

  }
}