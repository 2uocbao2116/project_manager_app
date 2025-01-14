import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/app_navigation_screen/app_navigation_screen.dart';
import 'package:projectmanager/src/views/contact_screen/contact_screen.dart';
import 'package:projectmanager/src/views/home_screen/home_screen.dart';
import 'package:projectmanager/src/views/message_screen/message_screen.dart';
import 'package:projectmanager/src/views/messages_screen/messages_screen.dart';
import 'package:projectmanager/src/views/notifications_screen/notifications_screen.dart';
import 'package:projectmanager/src/views/profile_page/profile_page.dart';
import 'package:projectmanager/src/views/project_screen/project_screen.dart';
import 'package:projectmanager/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:projectmanager/src/views/sign_up_screen/sign_up_screen.dart';

class AppRoutes {
  static const String signUpScreen = '/sign_up_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String homeScreen = '/home_screen';
  static const String homeInitialPage = '/home_initial_page';
  static const String projectScreen = '/project_screen';
  static const String messagesScreen = '/messages_screen';
  static const String messageScreen = '/message_screen';
  static const String profilePage = '/profile_page';
  static const String notificationsScreen = '/notifications_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String contactScreen = '/contact_screen';

  static Map<String, WidgetBuilder> get routes => {
        notificationsScreen: NotificationsScreen.builder,
        contactScreen: ContactScreen.builder,
        homeScreen: HomeScreen.builder,
        projectScreen: ProjectScreen.builder,
        signUpScreen: SignUpScreen.builder,
        messagesScreen: MessagesScreen.builder,
        messageScreen: MessageScreen.builder,
        profilePage: ProfilePage.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        signInScreen: SignInScreen.builder,
        initialRoute: SignInScreen.builder
      };
}
