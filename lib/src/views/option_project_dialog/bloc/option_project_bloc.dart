import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/views/option_project_dialog/bloc/option_project_event.dart';
import 'package:projectmanager/src/views/option_project_dialog/bloc/option_project_state.dart';

class OptionProjectBloc extends Bloc<OptionProjectEvent, OptionProjectState> {
  OptionProjectBloc(super.initialState) {
    on<OptionProjectInitialEvent>(_onInitialize);
  }

  _onInitialize(
    OptionProjectInitialEvent event,
    Emitter<OptionProjectState> emit,
  ) async {}
}
