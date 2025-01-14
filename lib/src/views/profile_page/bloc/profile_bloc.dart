import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/views/profile_page/bloc/profile_event.dart';
import 'package:projectmanager/src/views/profile_page/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ProfileInitialEvent event,
    Emitter<ProfileState> emit,
  ) async {}
}
