import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/bloc/theme_bloc.dart';
import 'package:projectmanager/src/theme/bloc/theme_state.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

var globaleMessagerKey = GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

Future<void> saveToken(String token) async {
  await storage.write(key: 'authToken', value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: 'authToken');
}

Future<void> clearToken() async {
  await storage.delete(key: 'authToken');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Hiển thị hộp thoại để yêu cầu quyền
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().initialize(
    // Set the icon for notifications (res/drawable path in Android)
    'resource://drawable/team_management',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );
  Future<bool> isUserLoggedIn() async {
    String? token = await getToken();
    return token != null;
  }

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) async {
    PrefUtils().init();
    PrefUtils().reload();
    bool logged = await isUserLoggedIn();
    runApp(MyApp(
      loggedIn: logged,
    ));
  });
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PrefUtils().init();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeBloc(
            ThemeState(
              themeType: PrefUtils().getThemeData(),
            ),
          ),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: theme,
                title: 'Project Manager',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale(
                    'en',
                    'VN',
                  )
                ],
                // initialRoute: AppRoutes.initialRoute,
                initialRoute:
                    loggedIn ? AppRoutes.homeScreen : AppRoutes.initialRoute,
              );
            },
          ),
        );
      },
    );
  }
}
