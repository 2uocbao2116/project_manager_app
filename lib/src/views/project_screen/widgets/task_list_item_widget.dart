import 'package:flutter/material.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/option_task_dialog/option_task_dialog.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class TaskListItemWidget extends StatelessWidget {
  TaskListItemWidget(this.listTaskItem, {super.key, this.onTapRowName});

  TaskData listTaskItem;

  VoidCallback? onTapRowName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapRowName?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18.h,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.black900.withOpacity(0.1),
          borderRadius: BorderRadiusStyle.rounderBorder10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listTaskItem.name!,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 2.h),
                    child: Row(
                      children: [
                        Text(
                          listTaskItem.dateEnd!,
                          style: theme.textTheme.bodySmall,
                        ),
                        Container(
                          height: 32.h,
                          width: 50.h,
                          margin: EdgeInsets.only(left: 42.h),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              PrefUtils()
                                      .getUser()!
                                      .id!
                                      .contains(listTaskItem.userId!)
                                  ? const SizedBox()
                                  : CustomImageView(
                                      imagePath:
                                          ImageConstant.imgZ5900111098027,
                                      height: 32.h,
                                      width: 34.h,
                                      radius: BorderRadius.circular(
                                        16.h,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      onTap: () {
                                        // To admin can see and assign to another user
                                        PrefUtils().getUser()!.id!.contains(
                                                PrefUtils()
                                                    .getProject()!
                                                    .userId!)
                                            ? (
                                                NavigatorService.pushNamed(
                                                    AppRoutes.contactScreen),
                                                PrefUtils()
                                                    .setListTasks(listTaskItem)
                                              )
                                            : null;
                                      },
                                    ),
                              PrefUtils().getUser()!.id!.contains(
                                          PrefUtils().getProject()!.userId!) &&
                                      PrefUtils()
                                          .getUser()!
                                          .id!
                                          .contains(listTaskItem.userId!)
                                  ? CustomImageView(
                                      imagePath:
                                          ImageConstant.imgAddCircleButBlack900,
                                      height: 32.h,
                                      width: 34.h,
                                      onTap: () {
                                        PrefUtils().setListTasks(listTaskItem);
                                        PrefUtils()
                                            .setCurrentTaskId(listTaskItem.id!);
                                        NavigatorService.pushNamed(
                                            AppRoutes.contactScreen);
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            PrefUtils()
                    .getUser()!
                    .id!
                    .contains(PrefUtils().getProject()!.userId!)
                ? CustomImageView(
                    imagePath: ImageConstant.imgFrame36,
                    height: 42.h,
                    width: 20.h,
                    onTap: () {
                      onTapOptionTaskDialog(context);
                      PrefUtils().setListTasks(listTaskItem);
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  onTapOptionTaskDialog(BuildContext context) {
    showDialog(
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        content: OptionTaskDialog.builder(
            NavigatorService.navigatorKey.currentContext!),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
      ),
    );
  }
}
