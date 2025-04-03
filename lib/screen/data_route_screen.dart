import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import '../websocket_service.dart';

class DataRouteScreen extends StatelessWidget {
  const DataRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (_) => DataProvider(service: RealtimeDataService())..startListening(),
      child: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Realtime Data Demo"),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: dataProvider.data != null
                  ? Text(
                dataProvider.data!.number, // Assuming `number` is a property in RealtimeDataModel
                style: const TextStyle(fontSize: 24),
              )
                  : const Text(
                "Connecting...",
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}
