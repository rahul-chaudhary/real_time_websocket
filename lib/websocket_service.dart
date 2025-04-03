import 'dart:async';
import 'package:bson/bson.dart' as bson;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class RealtimeDataService {
  IOWebSocketChannel? _channel;
  late StreamController<Map> _controller;
  bool _isConnected = false;
  final String url = "ws://192.168.1.33:3000/ws"; // Your WebSocket URL

  RealtimeDataService() {
    _controller = StreamController<Map>.broadcast();
  }

  Stream<Map> get stream => _controller.stream;

  void start() {
    _connect();
  }

  void _connect() {
    if (_isConnected) return; // Prevent duplicate connections
    print("Connecting to WebSocket...");

    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;

      _channel!.stream.listen(
            (data) {
          try {
            Map decodedData = bson.BsonCodec.deserialize(bson.BsonBinary.from(data));
            _controller.add(decodedData);
          } catch (e) {
            print("Data parse error: $e");
          }
        },
        onDone: () {
          print("WebSocket closed.");
          _isConnected = false;
          _reconnect();
        },
        onError: (error) {
          print("WebSocket error: $error");
          _isConnected = false;
          _reconnect();
        },
      );
    } catch (e) {
      print("WebSocket connection failed: $e");
      _isConnected = false;
      _reconnect();
    }
  }

  void _reconnect() {
    if (_isConnected) return;
    Future.delayed(Duration(seconds: 3), () {
      print("Reconnecting...");
      _connect();
    });
  }

  void dispose() {
    _channel?.sink.close(status.goingAway);
    _controller.close();
  }
}
