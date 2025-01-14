import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/contact_screen/bloc/contact_event.dart';
import 'package:projectmanager/src/views/contact_screen/bloc/contact_state.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_item.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(super.initialState) {
    on<ContactInitialEvent>(_onInitialize);
    on<FetchFriendsEvent>(_callFetchFriends);
    on<AssignTaskEvent>(_assignTaskEvent);
  }

  final _repository = Repository();

  final _currentPage = 0;

  var friendsResponse = ResponseListData<UserData>();

  _onInitialize(
    ContactInitialEvent event,
    Emitter<ContactState> emit,
  ) async {
    add(FetchFriendsEvent());
  }

  Future<void> _callFetchFriends(
    FetchFriendsEvent event,
    Emitter<ContactState> emit,
  ) async {
    var queryParams = <String, dynamic>{
      'page': _currentPage,
      'size': 10,
    };

    await _repository
        .getFriends(
      queryParams: queryParams,
    )
        .then((value) {
      friendsResponse = value;
      _onFetchFriendsSuccess(value, emit);
    }).onError((error, stackTrace) {
      _onFetchFriendsError(error, emit);
    });
  }

  void _onFetchFriendsSuccess(
    ResponseListData<UserData> resp,
    Emitter<ContactState> emit,
  ) {
    final friends = resp.data?.map((user) {
      return ContactItem(
        id: user.id,
        name: user.firstName! + user.lastName!,
        phoneNumber: user.phoneNumber,
      );
    }).toList();

    if (friends != null) {
      emit(
        state.copyWith(
          contactModelObj: state.contactModelObj?.copyWith(
            contactItem: friends,
          ),
        ),
      );
    }
  }

  void _onFetchFriendsError(
    Object? error,
    Emitter<ContactState> emit,
  ) {}

  Future<void> _assignTaskEvent(
    AssignTaskEvent event,
    Emitter<ContactState> emit,
  ) async {
    String taskId = PrefUtils().getCurrentTaskId();
    var response =
        await _repository.assignTask(taskId: taskId, toUserId: event.toUserId);
    if (response.status == 200) {
      NavigatorService.pushNamed(
        AppRoutes.projectScreen,
      );
    }
  }
}
