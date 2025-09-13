import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../const/url_const.dart';
import '../models/detail_model.dart';

class DetailWssService {
  WebSocketChannel? _channel;
  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(UrlConst.wssDetailUrl),
    );
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  Stream<DetailModel>? getUpdatedPrice() {
    return _channel?.stream.map(
      (e) {
        return DetailModel.fromJson(jsonDecode(e));
      },
    );
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
