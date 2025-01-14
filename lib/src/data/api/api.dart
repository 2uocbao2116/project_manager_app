import 'package:dio/dio.dart';
import 'package:projectmanager/main.dart';
import 'package:projectmanager/src/data/api/network_interceptor.dart';
import 'package:projectmanager/src/data/models/group/group_data.dart';
import 'package:projectmanager/src/data/models/message/message_data.dart';
import 'package:projectmanager/src/data/models/notifi/notification_data.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/utils/logger.dart';
import 'package:projectmanager/src/utils/network/netword_info.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/progress_dialog_utils.dart';

class Api {
  factory Api() {
    return _api;
  }

  Api._internal();

  // var url = "https://projectmanager-i5nz.onrender.com";
  var url = "https://ca60-171-242-184-231.ngrok-free.app";
  // var url = "http://localhost:9091";
  // var onrenderUrl = "https://projectmanager-i5nz.onrender.com";

  static final Api _api = Api._internal();

  final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
  ))
    ..interceptors.add(NetworkInterceptor());

  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  // is `true` when the repsonse status code is between 200 and 500
  bool _isSuccessCall(Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 300;
    }
    return false;
  }

  // User
  Future<ResponseData<UserData>> userLogin({Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.get(
        '$url/users/login',
        data: requestData,
        options: Options(),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, UserData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseListData<UserData>> getFriends(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      Response response = await _dio.get(
        '$url/users/$userId/find',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, UserData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<UserData>> userRegister(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.post(
        '$url/users/register',
        data: requestData,
        options: Options(),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, UserData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<UserData>> updateUser(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      Response response = await _dio.put(
        '$url/users/$userId',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, UserData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseData<String>> updatePassword(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      await isNetworkConnected();
      Response response = await _dio.patch(
        '$url/users/updatePassword',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson2(response.data);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<List<UserData>> searchUserData({String query = ''}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      await isNetworkConnected();
      Response response = await _dio.get(
        '$url/users',
        queryParameters: <String, dynamic>{'search': query},
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, UserData.fromJson)
            .data!;
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseData<UserData>> loginByOauth() async {
    ProgressDialogUtils.showProgressDialog();
    try {
      isNetworkConnected();
      Response response = await _dio.get('$url/secured', options: Options());
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, UserData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Project
  Future<ResponseListData<ProjectData>> getProjects(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      Response response = await _dio.get(
        '$url/users/$userId/projects',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<ProjectData>> getDetailProject(String? projectId) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/users/$userId/projects/$projectId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<ProjectData>> createNewProject(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/users/$userId/projects',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseData.fromJson(response.data, ProjectData.fromJson)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<ProjectData>> getGDPProject(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/users/$userId/projects/GDP_Project_status',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<ProjectData>> updateProject(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      String projectId = PrefUtils().getProject()!.id!;
      await isNetworkConnected();
      var response = await _dio.put(
        '$url/users/$userId/projects/$projectId',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<ProjectData>> deleteProject() async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String? token = await getToken();
      String userId = PrefUtils().getUser()!.id!;
      String projectId = PrefUtils().getProject()!.id!;
      var response = await _dio.delete(
        '$url/users/$userId/projects/$projectId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, ProjectData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  //Task
  Future<ResponseData<TaskData>> createNewTask(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String? token = await getToken();
      String projectId = PrefUtils().getProject()!.id!;
      var response = await _dio.post(
        '$url/projects/$projectId/tasks',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseData<TaskData>> getDetailTask(String taskId) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String? token = await getToken();
      String projectId = PrefUtils().getProject()!.id!;
      var response = await _dio.get(
        '$url/projects/$projectId/tasks/$taskId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<TaskData>> updateTask(
      {Map requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String? token = await getToken();
      String projectId = PrefUtils().getProject()!.id!;
      String userId = PrefUtils().getUser()!.id!;
      String taskId = PrefUtils().getCurrentTaskId();
      var response = await _dio.put(
        '$url/projects/$projectId/users/$userId/tasks/$taskId',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseListData<TaskData>> getTasksData(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String projectId = PrefUtils().getProject()!.id!;
      String userId = PrefUtils().getUser()!.id!;
      await isNetworkConnected();
      String? token = await getToken();
      var response = await _dio.get(
        '$url/projects/$projectId/users/$userId/tasks',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<TaskData>> getGDPTask() async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String userId = PrefUtils().getUser()!.id!;
      String projectId = PrefUtils().getProject()!.id!;
      await isNetworkConnected();
      String? token = await getToken();
      var response = await _dio.get(
        '$url/projects/$projectId/users/$userId/tasks/GDP_task_status',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<TaskData>> assignTask(
      {required String taskId, required String toUserId}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      String projectId = PrefUtils().getProject()!.id!;
      String? token = await getToken();
      var response = await _dio.put(
        '$url/projects/$projectId/users/$userId/tasks/$taskId/toUser/$toUserId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<ResponseData<TaskData>> updateReport(
      {Map<String, dynamic> requestData = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String projectId = PrefUtils().getProject()!.id!;
      String taskId = PrefUtils().getCurrentTaskId();
      String? token = await getToken();
      Response response = await _dio.put(
        '$url/projects/$projectId/tasks/$taskId/commit_content',
        data: requestData,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, TaskData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  //Group
  Future<ResponseData<GroupData>> createGroup(
      {Map<String, dynamic> requestParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      String? token = await getToken();
      Response response = await _dio.post(
        '$url/users/$userId/groups',
        queryParameters: requestParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, GroupData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseListData<GroupData>> getGroups(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      String? token = await getToken();
      Response response = await _dio.get(
        '$url/users/$userId/groups',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, GroupData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseData<GroupData>> addMember(
      {Map<String, dynamic> requestParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      String groupId = PrefUtils().getGroupId();
      String? token = await getToken();
      Response response = await _dio.post(
        '$url/users/$userId/groups/$groupId/add',
        queryParameters: requestParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, GroupData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  //Message
  Future<ResponseListData<MessageData>> getMessage(
      {Map<String, dynamic> requestParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String groupId = PrefUtils().getGroupId();
      String? token = await getToken();
      Response response = await _dio.get(
        '$url/message/$groupId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
        queryParameters: requestParams,
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(response.data, MessageData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  //Notifications
  Future<ResponseListData<NotificationData>> getNotifi(
      {Map<String, dynamic> queryParams = const {}}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      String userId = PrefUtils().getUser()!.id!;
      String? token = await getToken();
      Response response = await _dio.get(
        '$url/users/$userId/notifications',
        queryParameters: queryParams,
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseListData.fromJson(
            response.data, NotificationData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ResponseData<NotificationData>> deleteNotification(
      {String? notificationId}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      String userId = PrefUtils().getUser()!.id!;
      String? token = await getToken();
      await isNetworkConnected();
      Response response = await _dio.delete(
        '$url/users/$userId/notifications/$notificationId',
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer $token',
        }),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (_isSuccessCall(response)) {
        return ResponseData.fromJson(response.data, NotificationData.fromJson);
      } else {
        throw response.data != null
            ? ResponseError.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
