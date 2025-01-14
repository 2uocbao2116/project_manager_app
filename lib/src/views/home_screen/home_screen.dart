import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_bloc.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_event.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_state.dart';
import 'package:projectmanager/src/views/home_screen/home_initial_page.dart';
import 'package:projectmanager/src/views/home_screen/models/gdp_initial_model.dart';
import 'package:projectmanager/src/views/home_screen/models/home_initial_model.dart';
import 'package:projectmanager/src/views/messages_screen/messages_screen.dart';
import 'package:projectmanager/src/views/profile_page/profile_page.dart';
import 'package:projectmanager/src/widgets/custom_bottom_bar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        HomeState(
          gdpInitialModel: GdpInitialModel(),
          homeInitialModelObj: HomeInitialModel(),
        ),
      )..add(HomeInitial()),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homeInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: const Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeInitialPage;
      case BottomBarEnum.Messages:
        return AppRoutes.messagesScreen;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homeInitialPage:
        return HomeInitialPage.builder(context);
      case AppRoutes.messagesScreen:
        return MessagesScreen.builder(context);
      case AppRoutes.profilePage:
        return ProfilePage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
