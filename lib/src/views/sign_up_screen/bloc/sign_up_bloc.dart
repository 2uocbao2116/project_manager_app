import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/main.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/sign_up_screen/bloc/sign_up_event.dart';
import 'package:projectmanager/src/views/sign_up_screen/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(super.initialState) {
    on<SignUpInitialEvent>(_onInitialize);
    on<SignUp>(_signUp);
  }

  final websocketService = WebSocketService();

  final _repository = Repository();

  var userResponse = ResponseData<UserData>();

  _onInitialize(
    SignUpInitialEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
        firstNameInputController: TextEditingController(),
        lastNameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
        phoneNumberInputController: TextEditingController(),
        passwordInputController: TextEditingController(),
        confirmPasswordInputController: TextEditingController()));
  }

  Future<void> _signUp(
    SignUp event,
    Emitter<SignUpState> emit,
  ) async {
    var requestData = UserData(
      firstName: event.firstName?.text,
      lastName: event.lastName?.text,
      phoneNumber: event.phoneNumber?.text,
      email: event.email?.text,
      password: event.password?.text,
    );
    await _repository
        .register(requestData: requestData.toJson())
        .then((value) async {
      PrefUtils().setUser(value.data!);
      saveToken(value.data!.token!);
      //Connect to websocket
      // websocketService.connect(value.data!.id.toString());
      emit(
        SignUpSuccess(isSuccess: true),
      );
    }).onError((error, stackTrace) {
      String errorMessage = 'An unexpected error occurred.';
      if (error is DioException) {
        final errorResp = ResponseError.fromJson(error.response?.data);
        errorMessage = errorResp.detail!;
      }

      emit(
        SignUpFailure(message: errorMessage),
      );
    });
  }
}
