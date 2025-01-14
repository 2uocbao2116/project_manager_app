import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:projectmanager/main.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/user/sign_in_req.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/sign_in_screen/bloc/sign_in_state.dart';
import 'package:projectmanager/src/views/sign_in_screen/bloc/sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState) {
    on<SignInSubmitted>(_login);
    on<SignInByGoogle>(_signInGoogle);
    on<SignInByFaceBook>(_signInFacebook);
  }

  final _repository = Repository();
  final webSocketService = WebSocketService();

  final String loginUrl =
      'http://localhost:8080/oauth2/authorization/google'; // OAuth2 login URL

  Future<void> _signInFacebook(
    SignInByFaceBook event,
    Emitter<SignInState> emit,
  ) async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      print("ACCESSTOKEN ${result.accessToken!.tokenString}");
    } else {
      print('REULT STATUS ${result.status}');
      print('RESULT MESSAGE ${result.message}');
    }
  }

  Future<void> _signInGoogle(
    SignInByGoogle event,
    Emitter<SignInState> emit,
  ) async {
    // final Uri authorizationUri = Uri.parse(
    //     "https://624f-171-242-184-231.ngrok-free.app/login/oauth2/authorization/google");
    // if (await canLaunchUrl(authorizationUri)) {
    //   bool rei = await launchUrl(authorizationUri);
    //   if (rei == true) {
    //     // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
    //   }
    // } else {
    //   throw 'Could not launch $authorizationUri';
    // }

    // try {
    //   final GoogleSignInAccount? account = await _googleSignIn.signIn();
    //   if (account != null) {
    //     final GoogleSignInAuthentication googleAuth =
    //         await account.authentication;
    //     print('User signed in: ${googleAuth.accessToken}');
    //   } else {
    //     print('User cancelled sign-in.');
    //   }
    // } catch (error) {
    //   print('Error signing in with Google: $error');
    // }
  }

  Future<void> _login(SignInSubmitted event, Emitter<SignInState> emit) async {
    var signInReq = UserLoginReq(
      username: event.username,
      password: event.password,
    );

    await _repository
        .login(requestData: signInReq.toJson())
        .then((value) async {
      _onUserSignInSuccess(value.data, emit);
    }).onError((error, stackTrace) async {
      _onUserSignInError(error, emit);
    });
  }

  void _onUserSignInSuccess(
    UserData? resp,
    Emitter<SignInState> emit,
  ) async {
    await PrefUtils().setUser(resp!);
    saveToken(resp.token!);
    // webSocketService.connect(resp.data!.id);
    NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
  }

  void _onUserSignInError(
    Object? error,
    Emitter<SignInState> emit,
  ) async {
    String errorMessage = 'An unexpected error occurred.';
    if (error is DioException) {
      final errorResp = ResponseError.fromJson(error.response?.data);
      errorMessage = errorResp.detail!;
    }

    emit(
      SignInFailure(error: errorMessage),
    );
  }
}
