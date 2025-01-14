import 'package:flutter/material.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/messages_screen/models/userlist_item_model.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class UserlistItemWidget extends StatelessWidget {
  UserlistItemWidget(this.userlistItemModelObj, {super.key, this.onTapRowName});

  UserlistItemModel userlistItemModelObj;

  VoidCallback? onTapRowName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () {
                onTapRowName?.call();
              },
              child: Row(
                children: [
                  CustomImageView(
                    margin: EdgeInsets.only(left: 20.h),
                    imagePath: ImageConstant.imgUserCircleSin,
                    height: 40.h,
                    width: 40.h,
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userlistItemModelObj.name!,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: appTheme.nearBlack,
                          fontSize: 20.fSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userlistItemModelObj.message!,
                              style: CustomTextStyles.bodySmall12,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              userlistItemModelObj.time!,
                              style: CustomTextStyles.bodySmall12,
                            )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
