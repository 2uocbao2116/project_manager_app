import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/create_new_project_dialog.dart';
import 'package:projectmanager/src/views/filter_project_dialog/filter_project_dialog.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_bloc.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_event.dart';
import 'package:projectmanager/src/views/home_screen/bloc/home_state.dart';
import 'package:projectmanager/src/views/home_screen/models/gdp_initial_model.dart';
import 'package:projectmanager/src/views/home_screen/models/home_initial_model.dart';
import 'package:projectmanager/src/views/home_screen/widgets/project_item_widget.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class HomeInitialPage extends StatefulWidget {
  const HomeInitialPage({super.key});

  @override
  HomeInitialPageState createState() => HomeInitialPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        HomeState(
          gdpInitialModel: GdpInitialModel(),
          homeInitialModelObj: HomeInitialModel(),
        ),
      )..add(FetchDataEvent()),
      child: const HomeInitialPage(),
    );
  }
}

class HomeInitialPageState extends State<HomeInitialPage> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(FetchDataEvent());
    }
  }

  bool get _isBottom {
    if (context.read<HomeBloc>().state.hasMore) {
      return false;
    }
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: _buildAppBar(context),
          ),
          _buildMainContent(context),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(
                      width: 290.h,
                      child: _buildProjectGrid(context),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_dashboard".tr,
      ),
      actions: [
        Stack(
          children: [
            CustomIconButton(
              child: const Icon(Icons.notifications_none),
              onTap: () {
                context.read<HomeBloc>().webSocket.haveNewNotification = 0;
                onTapNotifications(context);
              },
            ),
            if (context.read<HomeBloc>().webSocket.haveNewNotification >
                0) // Show only if there are notifications
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '${context.read<HomeBloc>().webSocket.haveNewNotification}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        )
      ],
      styleType: Style.bgFillOnPrimaryContainer,
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, GdpInitialModel?>(
        selector: (state) => state.gdpInitialModel,
        builder: (context, state) {
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Row(
                              children: [
                                Text(
                                  "lbl_all_projects".tr,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.h, right: 10.h),
                                  child: CustomIconButton(
                                    decoration: IconButtonStyleHelper.none,
                                    onTap: () {
                                      onTapCreateNewProject(context);
                                    },
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgAddCircleBut,
                                      height: 15.h,
                                      width: 15.h,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomIconButton(
                        decoration: IconButtonStyleHelper.none,
                        onTap: () {
                          onTapShowFilter(context);
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgVerticalSlider,
                          height: 15.h,
                          width: 15.h,
                        ),
                      ),
                      SizedBox(
                        width: 20.h,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _buildProjectGrid(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, HomeState>(
      selector: (state) => state,
      builder: (context, state) {
        return ResponsiveGridListBuilder(
          minItemWidth: 2,
          minItemsPerRow: 1,
          maxItemsPerRow: 2,
          horizontalGridSpacing: 10.h,
          verticalGridSpacing: 10.h,
          builder: (context, items) => ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: items,
          ),
          gridItems: List.generate(
            state.hasMore
                ? state.homeInitialModelObj.projectgridItemList.length
                : state.homeInitialModelObj.projectgridItemList.length + 1,
            (index) {
              if (state.hasMore &&
                  state.homeInitialModelObj.projectgridItemList.isEmpty) {
                return const Center();
              }
              if (index <
                  state.homeInitialModelObj.projectgridItemList.length) {
                ProjectData model =
                    state.homeInitialModelObj.projectgridItemList[index];
                return ProjectItemWidget(
                  model,
                  onTapToProject: () {
                    onTapToProject(
                      context,
                      state.homeInitialModelObj.projectgridItemList[index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }

  onTapNotifications(BuildContext context) {
    showBasicNotification();
    NavigatorService.pushNamed(
      AppRoutes.notificationsScreen,
    );
  }

  void showBasicNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Hello!',
        body: 'This is a basic notification',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  onTapToProject(BuildContext context, ProjectData project) {
    PrefUtils().setProject(project);
    NavigatorService.pushNamed(AppRoutes.projectScreen);
  }

  onTapCreateNewProject(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: CreateNewProjectDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapShowFilter(BuildContext context) {
    showDialog(
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        content: FilterProjectDialog.builder(
            NavigatorService.navigatorKey.currentContext!),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
      ),
    );
  }
}
