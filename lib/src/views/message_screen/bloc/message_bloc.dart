import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/data/models/message/message_sent.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/message_screen/bloc/message_event.dart';
import 'package:projectmanager/src/views/message_screen/bloc/message_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:stomp_dart_client/stomp_frame.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(super.initialState) {
    on<MessageInitialEvent>(_onInitialize);
    on<SendMessageEvent>(_onSendMessage);
    on<FetchMessageEvent>(_onFetchMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
    on<AddNewMessageEvent>(_onAddNewMessage);
    on<UnsubscriberEvent>(_unSubscriberEvent);
  }

  String groupId = PrefUtils().getGroupId();
  UserData? userData = PrefUtils().getUser();

  int _currentPage = 0;

  final webSocket = WebSocketService();

  final _repository = Repository();

  _onInitialize(
    MessageInitialEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(
      state.copyWith(
        messageoneController: TextEditingController(),
        chatUser: types.User(
          id: userData!.id!,
          firstName: userData!.firstName! + userData!.lastName!,
        ),
        messageList: const [],
      ),
    );
    add(ReceiveMessageEvent());
  }

  void _onSendMessage(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) {
    Map<String, String> message = {
      'receiver': groupId,
      'sender': userData!.id!,
      'content': event.message,
      'userSender': userData!.firstName! + userData!.lastName!,
    };
    webSocket.sendMessage('/app/chat', message);
  }

  void _onReceiveMessage(
    ReceiveMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    await webSocket.onSubscribe(
      '/queue/message-user$groupId',
      (StompFrame frame) async {
        if (frame.body != null) {
          var message = MessageSent.fromJson(jsonDecode(frame.body!));
          add(AddNewMessageEvent(message: message));
        }
      },
    );
  }

  void _onAddNewMessage(
    AddNewMessageEvent event,
    Emitter<MessageState> emit,
  ) {
    MessageSent message = event.message;
    final newMessage = types.TextMessage(
      author: types.User(
        id: message.sender == userData!.id! ? userData!.id! : message.receiver!,
        firstName: message.userSender,
      ),
      id: UniqueKey().toString(),
      text: message.content!,
      createdAt:
          DateTime.parse(DateTime.now().toString()).microsecondsSinceEpoch,
    );
    var updateMessages = List<types.Message>.from(state.messageList)
      ..add(newMessage);
    emit(
      state.copyWith(
        messageList: updateMessages,
      ),
    );
  }

  Future<void> _onFetchMessage(
    FetchMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    if (state.hasMore) {
      return;
    } else {
      var queryParams = <String, dynamic>{
        'page': _currentPage,
        'size': 10,
      };
      var respone = await _repository.getMessage(queryParams: queryParams);
      respone.data!.sort(
        (a, b) => a.createdAt!.compareTo(b.createdAt!),
      );
      final messages = respone.data!.map((message) {
        return types.TextMessage(
          id: message.id.toString(),
          author: types.User(
            id: message.userId.toString(),
            firstName: message.userSender,
          ),
          text: message.message!,
          status: types.Status.seen,
          createdAt: DateTime.parse(message.createdAt!).millisecondsSinceEpoch,
        );
      }).toList();
      emit(
        state.copyWith(
          messageList: List.of(messages)..addAll(state.messageList),
          hasMore: respone.pagination!.currentPage ==
              respone.pagination!.totalPages! - 1,
        ),
      );
    }
    _currentPage++;
  }

  Future<void> _unSubscriberEvent(
    UnsubscriberEvent event,
    Emitter<MessageState> emit,
  ) async {
    await webSocket.onUnsubscribe(
      '/queue/message-user$groupId',
    );
  }
}
