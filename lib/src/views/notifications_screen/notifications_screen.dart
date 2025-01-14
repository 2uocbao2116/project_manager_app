import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/notifi/notification_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_bloc.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_event.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_state.dart';
import 'package:projectmanager/src/views/notifications_screen/models/notifications_model.dart';
import 'package:projectmanager/src/views/notifications_screen/widgets/notificationslist_item_widget.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => NotificationsBloc(NotificationsState(
        notificationsModelObj: NotificationsModel(),
      ))
        ..add(NotificationsInitialEvent()),
      child: const NotificationsScreen(),
    );
  }

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _scrollController = ScrollController();

  bool _isFetching = false;

  void _onScroll() {
    if (_isBottom && !_isFetching) {
      _isFetching = true;
      context.read<NotificationsBloc>().add(FetchNotificationEvent());
      Future.delayed(const Duration(seconds: 1), () => _isFetching = false);
    }
  }

  bool get _isBottom {
    if (context.read<NotificationsBloc>().state.hasMore) return false;
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 298.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNotificationsList(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_notifications".tr),
      leading: _buildBackButton(context),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.homeScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildNotificationsList(BuildContext context) {
    return BlocSelector<NotificationsBloc, NotificationsState,
        NotificationsModel?>(
      selector: (state) => state.notificationsModelObj,
      builder: (context, notificationsModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.h,
            );
          },
          itemCount:
              notificationsModelObj?.notificationslistItemList.length ?? 0,
          itemBuilder: (context, index) {
            NotificationData model =
                notificationsModelObj!.notificationslistItemList[index];
            return NotificationslistItemWidget(
              model,
            );
          },
        );
      },
    );
  }
}
