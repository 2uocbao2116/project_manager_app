import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/main.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/option_logout_dialog/bloc/option_logout_event.dart';
import 'package:projectmanager/src/views/option_logout_dialog/bloc/option_logout_state.dart';

class OptionLogoutBloc extends Bloc<OptionLogoutEvent, OptionLogoutState> {
  OptionLogoutBloc(super.initialState) {
    on<OptionLogoutInitialEvent>(_onInitialize);
    on<LogoutEvent>(_onLogout);
  }

  _onInitialize(
    OptionLogoutInitialEvent event,
    Emitter<OptionLogoutState> emit,
  ) async {}

  final _webSocketService = WebSocketService();

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<OptionLogoutState> emit,
  ) async {
    // _webSocketService.onDisconnect();
    clearToken();
    PrefUtils().clearPreferentcesData();
  }
}
