import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:projectmanager/src/data/models/message/message_data.dart';

// ignore: must_be_immutable
class MessageState extends Equatable {
  MessageState({
    this.messageoneController,
    this.chatUser = const types.User(id: ''),
    this.messageList = const [],
    this.hasMore = false,
  });

  bool hasMore;

  TextEditingController? messageoneController;

  types.User chatUser;

  List<types.Message> messageList;

  @override
  List<Object?> get props =>
      [messageoneController, chatUser, messageList, hasMore];

  MessageState copyWith({
    TextEditingController? messageoneController,
    types.User? chatUser,
    List<types.Message>? messageList,
    bool? hasMore,
  }) {
    return MessageState(
      messageoneController: messageoneController ?? this.messageoneController,
      chatUser: chatUser ?? this.chatUser,
      messageList: messageList ?? this.messageList,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// ignore: must_be_immutable
class ReceivedMessage extends MessageState {
  final MessageData message;

  ReceivedMessage(this.message);
}
