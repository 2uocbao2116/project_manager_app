import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/data/models/message/message_sent.dart';

class MessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageInitialEvent extends MessageEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SendMessageEvent extends MessageEvent {
  final String message;
  SendMessageEvent(this.message);
}

class ReceiveMessageEvent extends MessageEvent {}

class AddNewMessageEvent extends MessageEvent {
  final MessageSent message;
  AddNewMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class FetchMessageEvent extends MessageEvent {}

class UnsubscriberEvent extends MessageEvent {}
