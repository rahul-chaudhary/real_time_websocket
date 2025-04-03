import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_websocket/provider/data_provider.dart';
import 'package:real_time_websocket/screen/data_route_screen.dart';
import 'package:real_time_websocket/websocket_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(service: RealtimeDataService())..startListening(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DataRouteScreen(),
    );
  }
}

