import 'dart:async';
import 'package:hamtarot_app/Services/3card_service.dart';
import 'package:hamtarot_app/model/3card_model.dart';

class ThreeCardController {
  final Services service;
  List<ThreeCard> threecard = List.empty();

  StreamController<bool> onSyncController =
      StreamController(); // checking status stream onsync (on process / finish)
  Stream<bool> get onSync => onSyncController.stream;

  ThreeCardController(this.service);

  Future<List<ThreeCard>> fectthreecard() async {
    onSyncController.add(true); // stream connected
    threecard = await service.getthreecard();
    onSyncController.add(false); // stop connected
    return threecard;
  }
}
