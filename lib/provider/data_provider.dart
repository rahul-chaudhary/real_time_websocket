import 'dart:async';
import 'package:flutter/material.dart';
import '../model/data.dart';
import '../websocket_service.dart';

class DataProvider extends ChangeNotifier {
  final RealtimeDataService service;
  RealtimeDataModel? _data;

  DataProvider({required this.service}) {
    service.start();
    service.stream.listen((data) {
      _updateData(data);
    });
  }

  RealtimeDataModel? get data => _data;

  void _updateData(Map data) {
    _data = RealtimeDataModel.fromMap(data);
    notifyListeners();
  }
}


