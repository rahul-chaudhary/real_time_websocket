import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data.dart';
import '../websocket_service.dart';

class DataProvider extends ChangeNotifier {
  final RealtimeDataService service;
  late StreamController<Map> _streamController;
  RealtimeDataModel? _data;

  DataProvider({required this.service}) {
    _streamController = StreamController<Map>();
  }

  RealtimeDataModel? get data => _data;

  void startListening() {
    service.start(_streamController);
    _streamController.stream.listen((data) {
      _updateData(data);
    });
  }

  void _updateData(Map data) {
    _data = RealtimeDataModel.fromMap(data);
    notifyListeners(); // Notifies the UI to rebuild
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
