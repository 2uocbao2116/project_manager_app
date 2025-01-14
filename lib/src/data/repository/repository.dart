import 'package:projectmanager/src/data/api/api.dart';
import 'package:projectmanager/src/data/models/group/group_data.dart';
import 'package:projectmanager/src/data/models/message/message_data.dart';
import 'package:projectmanager/src/data/models/notifi/notification_data.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/response_data.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';

class Repository {
  final _api = Api();

  //User
  Future<ResponseData<UserData>> login({Map requestData = const {}}) async {
    return await _api.userLogin(requestData: requestData);
  }

  Future<ResponseListData<UserData>> getFriends(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getFriends(queryParams: queryParams);
  }

  Future<ResponseData<UserData>> register({Map requestData = const {}}) async {
    return await _api.userRegister(requestData: requestData);
  }

  Future<ResponseData<UserData>> updateUser(
      {Map requestData = const {}}) async {
    return await _api.updateUser(requestData: requestData);
  }

  Future<ResponseData<String>> updatePassword(
      {Map requestData = const {}}) async {
    return await _api.updatePassword(requestData: requestData);
  }

  Future<List<UserData>> searchUser(String query) async {
    return await _api.searchUserData(query: query);
  }

  Future<ResponseData<UserData>> loginByOauth() async {
    return await _api.loginByOauth();
  }

  //Project
  Future<ResponseListData<ProjectData>> getProjects(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getProjects(queryParams: queryParams);
  }

  Future<ResponseData<ProjectData>> getDetailProject(String projectId) async {
    return await _api.getDetailProject(projectId);
  }

  Future<ResponseData<ProjectData>> createNewProject(
      {Map requestData = const {}}) async {
    return await _api.createNewProject(requestData: requestData);
  }

  Future<ResponseData<ProjectData>> getGDPProject(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getGDPProject(queryParams: queryParams);
  }

  Future<ResponseData<ProjectData>> updateProject(
      {Map requestData = const {}}) async {
    return await _api.updateProject(requestData: requestData);
  }

  //Task
  Future<ResponseData<TaskData>> createNewTask(
      {Map requestData = const {}}) async {
    return await _api.createNewTask(requestData: requestData);
  }

  Future<ResponseData<TaskData>> getDetailTask(String taskId) async {
    return await _api.getDetailTask(taskId);
  }

  Future<ResponseData<TaskData>> updateTask(
      {Map requestData = const {}}) async {
    return await _api.updateTask(requestData: requestData);
  }

  Future<ResponseListData<TaskData>> getTasks(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getTasksData(queryParams: queryParams);
  }

  Future<ResponseData<TaskData>> getGDPTask() async {
    return await _api.getGDPTask();
  }

  Future<ResponseData<TaskData>> assignTask(
      {required String taskId, required String toUserId}) async {
    return await _api.assignTask(taskId: taskId, toUserId: toUserId);
  }

  Future<ResponseData<TaskData>> updateReport(
      {Map<String, dynamic> requestData = const {}}) async {
    return await _api.updateReport(requestData: requestData);
  }

  //Group
  Future<ResponseData<GroupData>> createGroup(
      {Map<String, dynamic> requestParams = const {}}) async {
    return await _api.createGroup(requestParams: requestParams);
  }

  Future<ResponseListData<GroupData>> getGroups(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getGroups(queryParams: queryParams);
  }

  // Message
  Future<ResponseListData<MessageData>> getMessage(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getMessage(requestParams: queryParams);
  }

  // Notification
  Future<ResponseListData<NotificationData>> getNotifications(
      {Map<String, dynamic> queryParams = const {}}) async {
    return await _api.getNotifi(queryParams: queryParams);
  }

  Future<ResponseData<NotificationData>> deleteNotification(
      String notificationId) async {
    return await _api.deleteNotification(notificationId: notificationId);
  }
}
