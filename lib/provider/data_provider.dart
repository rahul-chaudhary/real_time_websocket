import 'dart:async';
import 'package:flutter/material.dart';
import '../model/data.dart';
import '../websocket_service.dart';

class DataProvider extends ChangeNotifier {
  final RealtimeDataService service;
  late StreamController<Map> _streamController;
  RealtimeDataModel? _data;

  DataProvider({required this.service}) {
    _streamController = StreamController<Map>.broadcast();
  }

  RealtimeDataModel? get data => _data;

  void startListening() {
    service.start(_streamController);
    _streamController.stream.listen((data) {
      print("Received Data: $data");  // Debugging
      _updateData(data);
    });
  }

  void _updateData(Map data) {
    print("Updating Data: ${data.toString()}");  // Debugging
    _data = RealtimeDataModel.fromMap(data);
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

