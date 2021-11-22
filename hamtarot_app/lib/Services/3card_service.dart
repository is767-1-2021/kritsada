import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamtarot_app/model/3card_model.dart';

abstract class Services {
  Future<List<ThreeCard>> getthreecard();
}

class ThreeCardServices extends Services {
  @override
  Future<List<ThreeCard>> getthreecard() async {
    QuerySnapshot snapshot = // read DB
        await FirebaseFirestore.instance
            .collection('ham_3card')
            //  .where('id',isGreaterThan: 1) // select data
            .get();

    AllThreeCard threecard = AllThreeCard.fromSnapshot(snapshot);
    return threecard.threecard;
  }
}
