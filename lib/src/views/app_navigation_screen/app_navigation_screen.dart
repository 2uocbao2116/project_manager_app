import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/app_navigation_screen/bloc/app_navigation_bloc.dart';
import 'package:projectmanager/src/views/app_navigation_screen/bloc/app_navigation_event.dart';
import 'package:projectmanager/src/views/app_navigation_screen/bloc/app_navigation_state.dart';
import 'package:projectmanager/src/views/app_navigation_screen/models/app_navigation_model.dart';
import 'package:projectmanager/src/views/change_password_dialog/change_password_dialog.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/create_new_project_dialog.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/create_new_task_dialog.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/edit_profile_dialog.dart';
import 'package:projectmanager/src/views/filter_project_dialog/filter_project_dialog.dart';
import 'package:projectmanager/src/views/filter_task_dialog/filter_task_dialog.dart';
import 'package:projectmanager/src/views/task_detail_dialog/task_detail_dialog.dart';
import 'package:projectmanager/src/views/update_project_dialog/update_project_dialog.dart';
import 'package:projectmanager/src/views/update_task_dialog/update_task_dialog.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<AppNavigationBloc>(
      create: (context) => AppNavigationBloc(AppNavigationState(
        appNavigationModelObj: AppNavigationModel(),
      ))
        ..add(AppNavigationInitialEvent()),
      child: const AppNavigationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavigationBloc, AppNavigationState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: const Color(0XFFFFFFFF),
          body: SizedBox(
            width: 375.h,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0XFFFFFFFF),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Text(
                          "App Navigation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0XFFFFFFFF),
                            fontSize: 20.fSize,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Text(
                          "Check your app's UI from the below demo screens of your app",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0XFFFFFFFF),
                            fontSize: 16.fSize,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(
                        height: 1.h,
                        thickness: 1.h,
                        color: const Color(0XFF000000),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                            AppRoutes.notificationsScreen,
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Filter task",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, FilterTaskDialog.builder(context)),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Contact",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.contactScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Create new task",
                          onTapScreenTitle: () => onTapDialogTitle(
                            context,
                            CreateNewTaskDialog.builder(context),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign In",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.homeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.projectScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Project",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.projectScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.signUpScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Task Detail",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, TaskDetailDialog.builder(context)),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Update task",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, UpdateTaskDialog.builder(context)),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Create new project",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, CreateNewProjectDialog.builder(context)),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Filter project",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, FilterProjectDialog.builder(context)),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Update project",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, UpdateProjectDialog.builder(context)),
                        ),
                        _buildScreenTitle(context,
                            screenTitle: "Edit profile",
                            onTapScreenTitle: () => onTapDialogTitle(
                                context, EditProfileDialog.builder(context))),
                        _buildScreenTitle(context,
                            screenTitle: "Messages",
                            onTapScreenTitle: () =>
                                onTapScreenTitle(AppRoutes.messagesScreen)),
                        _buildScreenTitle(context,
                            screenTitle: "Message",
                            onTapScreenTitle: () =>
                                onTapScreenTitle(AppRoutes.messageScreen)),
                        _buildScreenTitle(context,
                            screenTitle: "Chang password",
                            onTapScreenTitle: () => onTapDialogTitle(
                                context, ChangePasswordDialog.builder(context)))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
      },
    );
  }

  void onTapDialogTitle(
    BuildContext context,
    Widget className,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: className,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFFFFFFFF),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: const Color(0XFFFFFFFF),
            )
          ],
        ),
      ),
    );
  }

  void onTapScreenTitle(String routeName) {
    NavigatorService.pushNamed(routeName);
  }
}
