import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import '../websocket_service.dart';

class DataRouteScreen extends StatelessWidget {
  const DataRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (_) => DataProvider(service: RealtimeDataService()),
      child: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Realtime Data"),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(dataProvider.data?.number ?? "Connecting..."),
            ),
          );
        },
      ),
    );
  }
}
