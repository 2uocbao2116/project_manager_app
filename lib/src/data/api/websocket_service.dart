import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:projectmanager/src/data/api/api.dart';
import 'package:projectmanager/src/utils/logger.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:stomp_dart_client/stomp_handler.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  StompClient? stompClient;
  StompUnsubscribe? stompUnsubscribe;
  bool isConnected = false;
  Map<String, StompUnsubscribe> subscriptions = {};
  int haveNewMessage = 0;
  int haveNewNotification = 0;

  factory WebSocketService() {
    return _instance;
  }

  WebSocketService._internal();

  String url = '${Api().url}/ws';

  void connect(String? userId) {
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: url,
        onConnect: (p0) {
          isConnected = true;
          onSubscribe(
            '/queue/message-notifi$userId',
            (StompFrame frame) {
              if (frame.body != null) {
                haveNewMessage++;
                print(haveNewMessage);
                void showBasicNotification() {
                  AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 1,
                      channelKey: 'basic_channel',
                      title: 'Hello!',
                      body: 'This is a basic notification',
                    ),
                  );
                }
              }
            },
          );
          onSubscribe(
            '/queue/notifi-user$userId',
            (StompFrame frame) {
              if (frame.body != null) {
                haveNewNotification++;
              }
            },
          );
          Logger.info('Connected To WebSocket!');
        },
        onStompError: (dynamic error) {
          Logger.info("STOMP Error: $error");
        },
        onWebSocketError: (dynamic error) {
          Logger.info("WebSocket Error: $error");
        },
        onDisconnect: (StompFrame? frame) {
          Logger.info("Disconnected: $frame");
        },
        stompConnectHeaders: {'username': userId!},
      ),
    );
    stompClient?.activate();
  }

  void onDisconnect() {
    if (stompClient!.isActive) {
      stompClient!.deactivate();
      isConnected = false;
    }
  }

  onUnsubscribe(
    String destination,
  ) async {
    if (isConnected) {
      if (stompUnsubscribe != null) {
        stompUnsubscribe!(unsubscribeHeaders: {
          'simpSessionId': destination,
        });
        print('Unsubscribed from $destination');
      }
    } else {
      Logger.info("Cannot unsubscribe");
    }
  }

  onSubscribe(
    String destination,
    Function(StompFrame frame) onMessage,
  ) async {
    //Subscribe to private message
    if (isConnected) {
      stompUnsubscribe = stompClient!.subscribe(
        destination: destination,
        callback: onMessage,
      );
    } else {
      Logger.info("Cannot subscribe: WebSocket is not connected.");
    }
  }

  void sendMessage(String destination, Map<String, String> message) {
    if (isConnected) {
      stompClient!.send(
        destination: destination,
        body: jsonEncode(message),
      );
    } else {
      Logger.info("Cannot send message: WebSocket is not connected.");
    }
  }
}
