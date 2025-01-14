import 'package:flutter/material.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_item.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class ContactlistItemWidget extends StatelessWidget {
  ContactlistItemWidget(this.contactlistItemModelObj, this.isOfUser,
      {super.key, this.onTapRowName});

  ContactItem contactlistItemModelObj;

  VoidCallback? onTapRowName;

  bool isOfUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapRowName?.call();
      },
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgZ590011109802748x48,
            height: 48.h,
            width: 48.h,
            radius: BorderRadius.circular(24.h),
            alignment: Alignment.bottomCenter,
          ),
          SizedBox(
            width: 12.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactlistItemModelObj.name!,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  contactlistItemModelObj.phoneNumber!,
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
          isOfUser
              ? const SizedBox()
              : Container(
                  margin: EdgeInsets.only(right: 10.h),
                  child: const Icon(Icons.assignment_turned_in_outlined),
                ),
        ],
      ),
    );
  }
}
