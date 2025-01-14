import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/theme/bloc/theme_event.dart';
import 'package:projectmanager/src/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(super.initialState) {
    on<ThemeChangeEvent>(_changeTheme);
  }

  _changeTheme(
    ThemeChangeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeType: event.themeType));
  }
}
