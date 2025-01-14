import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/change_password_dialog/change_password_dialog.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/edit_profile_dialog.dart';
import 'package:projectmanager/src/views/option_logout_dialog/option_logout_dialog.dart';
import 'package:projectmanager/src/views/profile_page/bloc/profile_bloc.dart';
import 'package:projectmanager/src/views/profile_page/bloc/profile_event.dart';
import 'package:projectmanager/src/views/profile_page/bloc/profile_state.dart';
import 'package:projectmanager/src/views/profile_page/models/profile_model.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(ProfileState(
        profileModelObj: ProfileModel(),
      ))
        ..add(ProfileInitialEvent()),
      child: const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          appBar: _buildApp(context),
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 6.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildProfileSection(context),
                SizedBox(
                  height: 5.h,
                ),
                _buildUserInfoStack(context),
                SizedBox(
                  height: 20.h,
                ),
                _buildEditProfileRow(context),
                SizedBox(
                  height: 10.h,
                ),
                _buildLogoutRow(context),
                SizedBox(
                  height: 10.h,
                ),
                _buildChangePasswordRow(context),
              ],
            ),
          ),
        ));
      },
    );
  }

  PreferredSizeWidget _buildApp(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: 'lbl_profile'.tr),
      styleType: Style.bgFillOnPrimaryContainer,
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgZ5900111098027150x150,
            height: 150.h,
            width: 150.h,
            radius: BorderRadius.circular(
              74.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoStack(BuildContext context) {
    return SizedBox(
      height: 32.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 26.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
          ),
          Text(
            PrefUtils().getUser()!.firstName! +
                PrefUtils().getUser()!.lastName!,
            style: theme.textTheme.headlineLarge,
          )
        ],
      ),
    );
  }

  Widget _buildEditProfileRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapEditprofile(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.gray100,
        ),
        width: double.maxFinite,
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.userIdentifierCardSVG,
              height: 14.h,
              width: 14.h,
              onTap: () {
                onTapEditprofile(context);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                  "lbl_edit_profile".tr,
                  style: CustomTextStyles.bodySmall12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapLogout(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.gray100,
        ),
        width: double.maxFinite,
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgMoveRightMoveRightArrows,
              height: 14.h,
              width: 14.h,
              onTap: () {
                onTapLogout(context);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                  "lbl_log_out".tr,
                  style: CustomTextStyles.bodySmall12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapChangePasswordRow(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.gray100,
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUserProtection,
              height: 14.h,
              width: 14.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Text(
                "lbl_change_password".tr,
                style: CustomTextStyles.bodySmall12,
              ),
            )
          ],
        ),
      ),
    );
  }

  onTapEditprofile(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: EditProfileDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapLogout(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: OptionLogoutDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapChangePasswordRow(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: ChangePasswordDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }
}
