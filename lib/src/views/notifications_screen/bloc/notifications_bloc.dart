import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_event.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(super.initialState) {
    on<NotificationsInitialEvent>(_onInitialize);
    on<FetchNotificationEvent>(_fetchNotifications);
    on<ConfirmFriendEvent>(_confirmFriendRequest);
    on<DeleteNotificationEvent>(_deleteNotification);
  }

  final _repository = Repository();

  int currentPage = 0;

  _onInitialize(
    NotificationsInitialEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    add(FetchNotificationEvent());
  }

  Future<void> _fetchNotifications(
    FetchNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.hasMore) {
      return;
    } else {
      var queryParams = <String, dynamic>{'page': currentPage, 'size': 10};
      await _repository
          .getNotifications(queryParams: queryParams)
          .then((value) {
        if (value.data != null) {
          emit(
            state.copyWith(
              notificationsModelObj: state.notificationsModelObj!.copyWith(
                notificationlistItemList: List.of(value.data!)
                  ..addAll(
                      state.notificationsModelObj!.notificationslistItemList),
              ),
              hasMore: value.pagination!.currentPage! ==
                  value.pagination!.totalPages! - 1,
            ),
          );
        }
      }).onError((error, stackTrace) {});
      currentPage++;
    }
  }

  Future<void> _confirmFriendRequest(
    ConfirmFriendEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    var requestParams = <String, dynamic>{
      'withUser': event.senderId,
    };
    await _repository.createGroup(requestParams: requestParams).then((onValue) {
      if (onValue.status == 200) {
        add(DeleteNotificationEvent(event.notifiId));
      }
    });
  }

  Future<void> _deleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    await _repository.deleteNotification(event.notifiId).then((onValue) {});
  }
}
