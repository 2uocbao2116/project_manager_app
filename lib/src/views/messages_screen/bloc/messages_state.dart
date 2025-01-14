import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/messages_screen/models/messages_model.dart';

// ignore: must_be_immutable
class MessagesState extends Equatable {
  MessagesState({
    this.messagesModelObj,
    this.hasMore = false,
  });

  MessagesModel? messagesModelObj;
  bool hasMore;

  @override
  List<Object?> get props => [messagesModelObj, hasMore];
  MessagesState copyWith({
    MessagesModel? messagesModelObj,
    bool? hasMore,
  }) {
    return MessagesState(
      messagesModelObj: messagesModelObj ?? this.messagesModelObj,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
