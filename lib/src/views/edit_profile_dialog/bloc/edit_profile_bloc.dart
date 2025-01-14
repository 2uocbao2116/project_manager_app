import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/bloc/edit_profile_event.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/bloc/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(super.initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  final _repository = Repository();

  _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    // emit(state.copyWith(
    //   firstNameInputController: TextEditingController(),
    //   lastNameInputController: TextEditingController(),
    //   emailInputController: TextEditingController(),
    //   phoneNumberInputController: TextEditingController(),
    // ));
  }

  _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    UserData userData = UserData(
      firstName: event.firstName?.text,
      lastName: event.lastName?.text,
      phoneNumber: event.phoneNumber!.text,
      email: event.email!.text,
    );
    await _repository
        .updateUser(requestData: userData.toJson())
        .then((onValue) async {
      PrefUtils().setUser(onValue.data!);
      emit(
        UpdateProfileSuccess(isSuccess: true),
      );
    }).onError((handleError, stackTrace) async {
      String errorMessage = 'An unexpected error occurred.';
      if (handleError is DioException) {
        final errorResp = ResponseError.fromJson(handleError.response?.data);
        errorMessage = errorResp.detail!;
      }
      emit(
        UpdateProfileFailure(message: errorMessage),
      );
    });
  }
}
