import 'dart:async';

import 'package:hamtarot_app/History/history_model.dart';
import 'package:hamtarot_app/History/history_services.dart';

class HistoryController {
  final Services service;
  List<History> history = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  HistoryController(this.service);

  Future<List<History>> fecthistory(String? email) async {
    onSyncController.add(true);
    history = await service.getHistory();
    onSyncController.add(false);
    return history;
    
  } 
}
