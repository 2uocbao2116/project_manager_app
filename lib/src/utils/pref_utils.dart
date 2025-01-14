import 'dart:convert';

import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/utils/date_time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void clearPreferentcesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  Future<void> reload() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'ABeeZee';
    }
  }

  //Projects
  Future<void> setProject(ProjectData data) {
    return _sharedPreferences!.setString('project', jsonEncode(data.toJson()));
  }

  ProjectData? getProject() {
    try {
      String? jsonString = _sharedPreferences?.getString('project');
      if (jsonString == null || jsonString.isEmpty) return null;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return ProjectData.fromJson(jsonMap);
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  Future<void> setStatusFilterProject(String value) {
    return _sharedPreferences!.setString('statusProject', value);
  }

  String getStatusFilterProject() {
    try {
      return _sharedPreferences!.getString('statusProject') ?? 'INPROGRESS';
    } catch (e) {
      return 'INPROGRESS';
    }
  }

  Future<void> setStartDateFilterProject(String date) {
    return _sharedPreferences!.setString('dateStartFilterProject', date);
  }

  String getStartDateFilterProject() {
    try {
      return _sharedPreferences!.getString('dateStartFilterProject') ??
          DateTime.now().format(pattern: D_M_Y);
    } catch (e) {
      return DateTime.now().format(pattern: D_M_Y);
    }
  }

  Future<void> setEndDateFilterProject(String date) {
    return _sharedPreferences!.setString('dateEndFilterProject', date);
  }

  String getEndDateFilterProject() {
    try {
      return _sharedPreferences!.getString('dateEndFilterProject') ??
          DateTime.now().add(const Duration(days: 90)).format(pattern: D_M_Y);
    } catch (e) {
      return DateTime.now()
          .add(const Duration(days: 90))
          .format(pattern: D_M_Y);
    }
  }

  //Task
  Future<void> setListTasks(TaskData value) {
    return _sharedPreferences!.setString('listTasks', jsonEncode(value));
  }

  TaskData? getListTasks() {
    try {
      String? jsonString = _sharedPreferences?.getString('listTasks');
      if (jsonString == null || jsonString.isEmpty) return null;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return TaskData.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<void> setStatusFilterTask(String value) {
    return _sharedPreferences!.setString('statusTask', value);
  }

  String getStatusFilterTask() {
    try {
      return _sharedPreferences!.getString('statusTask') ?? 'INPROGRESS';
    } catch (e) {
      return 'INPROGRESS';
    }
  }

  Future<void> setCurrentTaskId(String taskId) {
    return _sharedPreferences!.setString('currentTask', taskId);
  }

  String getCurrentTaskId() {
    try {
      return _sharedPreferences!.getString('currentTask') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setDateFilterTask(String date) {
    return _sharedPreferences!.setString('dateTaskFilter', date);
  }

  String getDateFilterTask() {
    try {
      return _sharedPreferences!.getString('dateTaskFilter') ??
          DateTime.now().format(pattern: D_M_Y);
    } catch (e) {
      return DateTime.now().format(pattern: D_M_Y);
    }
  }

  // User
  Future<void> setUser(UserData data) {
    return _sharedPreferences!.setString('user', jsonEncode(data.toJson()));
  }

  UserData? getUser() {
    try {
      String? jsonString = _sharedPreferences?.getString('user');
      if (jsonString == null || jsonString.isEmpty) return null;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserData.fromJson(jsonMap);
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  // Group
  Future<void> setGroupId(String groupId) {
    return _sharedPreferences!.setString('groupId', groupId);
  }

  String getGroupId() {
    try {
      return _sharedPreferences!.getString('groupId') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setGroupName(String name) {
    return _sharedPreferences!.setString('groupName', name);
  }

  String getGroupName() {
    try {
      return _sharedPreferences!.getString('groupName') ?? 'Null';
    } catch (e) {
      return 'null';
    }
  }

  //Notifi
  Future<void> setWithUser(String withUser) {
    return _sharedPreferences!.setString('withUser', withUser);
  }

  String getWithUser() {
    try {
      return _sharedPreferences!.getString('withUser') ?? 'null';
    } catch (e) {
      return '';
    }
  }

  Future<void> setNotifiId(String notifiId) {
    return _sharedPreferences!.setString('notifiId', notifiId);
  }

  String getNotifiId() {
    try {
      return _sharedPreferences!.getString('notifiId') ?? '';
    } catch (e) {
      return '';
    }
  }
}
