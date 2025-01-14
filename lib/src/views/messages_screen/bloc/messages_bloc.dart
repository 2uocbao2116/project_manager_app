import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/group/group_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/date_time_utils.dart';
import 'package:projectmanager/src/views/messages_screen/bloc/messages_event.dart';
import 'package:projectmanager/src/views/messages_screen/bloc/messages_state.dart';
import 'package:projectmanager/src/views/messages_screen/models/userlist_item_model.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc(super.initialState) {
    on<MessagesInitialEvent>(_onInitialize);
    on<FetchMessagesEvent>(_onFetchMessages);
  }

  final _repository = Repository();

  List<GroupData> _groupData = [];

  int _currentPage = 0;

  _onInitialize(
    MessagesInitialEvent event,
    Emitter<MessagesState> emit,
  ) async {
    add(FetchMessagesEvent());
  }

  Future<void> _onFetchMessages(
    FetchMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    if (state.hasMore) {
      return;
    }
    var queryParams = <String, dynamic>{
      'page': _currentPage,
      'size': 10,
    };
    DateTime? dateTime = DateTime.now();
    await _repository.getGroups(queryParams: queryParams).then(
      (value) async {
        _groupData = value.data!;
        if (_groupData.isNotEmpty) {
          _groupData.sort(
            (a, b) => b.date!.compareTo(a.date!),
          );
        }
        final groups = _groupData.map((group) {
          return UserlistItemModel(
              id: group.id,
              name: group.name,
              message: group.lastMessage ?? '',
              time: dateTime.hasBeen(date: group.date!));
        }).toList();
        emit(
          state.copyWith(
            messagesModelObj: state.messagesModelObj?.copyWith(
              userlistItemList:
                  List.of(state.messagesModelObj!.userlistItemList)
                    ..addAll(groups),
            ),
            hasMore: value.pagination!.currentPage! ==
                value.pagination!.totalPages! - 1,
          ),
        );
        _currentPage++;
      },
    );
  }
}
