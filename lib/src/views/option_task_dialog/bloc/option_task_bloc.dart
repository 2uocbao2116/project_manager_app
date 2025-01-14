import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/views/option_task_dialog/bloc/option_task_event.dart';
import 'package:projectmanager/src/views/option_task_dialog/bloc/option_task_state.dart';

class OptionTaskBloc extends Bloc<OptionTaskEvent, OptionTaskState> {
  OptionTaskBloc(super.initialState) {
    on<OptionTaskInitialEvent>(_onInitialize);
  }

  _onInitialize(
    OptionTaskInitialEvent event,
    Emitter<OptionTaskState> emit,
  ) async {}
}
