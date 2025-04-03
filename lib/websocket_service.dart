import 'dart:async';
import 'dart:typed_data';
import 'package:bson/bson.dart' as bson;
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeDataService {
  void start(StreamController<Map> controller){
    final channel = WebSocketChannel.connect(Uri.parse("ws://192.168.1.33:3000/ws"));
    channel.stream.listen((event) {
      Map data = bson.BsonCodec.deserialize(bson.BsonBinary.from(event));
      controller.add(data);
    });
  }
}