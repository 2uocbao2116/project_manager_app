import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/notifi/notification_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/date_time_utils.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_bloc.dart';
import 'package:projectmanager/src/views/notifications_screen/bloc/notifications_event.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class NotificationslistItemWidget extends StatelessWidget {
  NotificationslistItemWidget(this.notificationslistItemModelObj, {super.key});

  NotificationData notificationslistItemModelObj;

  @override
  Widget build(BuildContext context) {
    if (notificationslistItemModelObj.type == 'PROJECT') {
      return SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 14.h,
            ),
            Text(
              notificationslistItemModelObj.message!,
              style: CustomTextStyles.bodySmall11,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              'You have a new task from the ${notificationslistItemModelObj.message}',
              style: CustomTextStyles.bodySmall11,
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgZ5900111098027,
                    height: 32.h,
                    width: 32.h,
                    radius: BorderRadius.circular(
                      16.h,
                    ),
                    margin: EdgeInsets.only(top: 2.h),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'You have new friend request from ${notificationslistItemModelObj.message!}',
                            style: CustomTextStyles.bodySmall11,
                          ),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: 30.h,
                                    width: 60.h,
                                    child: CustomElevatedButton(
                                      text: "lbl_accept".tr,
                                      decoration: BoxDecoration(
                                        color: appTheme.blueA700.withOpacity(1),
                                        borderRadius:
                                            BorderRadiusStyle.rounderBorder10,
                                      ),
                                      onPressed: () {
                                        context.read<NotificationsBloc>().add(
                                              ConfirmFriendEvent(
                                                notificationslistItemModelObj
                                                    .senderId!,
                                                notificationslistItemModelObj
                                                    .id!,
                                              ),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                  width: 60.h,
                                  child: CustomElevatedButton(
                                    text: "lbl_dismiss".tr,
                                    decoration: BoxDecoration(
                                      color: appTheme.black900.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadiusStyle.rounderBorder10,
                                    ),
                                    onPressed: () {
                                      context.read<NotificationsBloc>().add(
                                            DeleteNotificationEvent(
                                              notificationslistItemModelObj.id!,
                                            ),
                                          );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Text(
                    DateTime.now()
                        .hasBeen(date: notificationslistItemModelObj.date!),
                    style: CustomTextStyles.bodySmall11,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
