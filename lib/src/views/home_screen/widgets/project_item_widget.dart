import 'package:flutter/material.dart';
import 'package:projectmanager/src/data/models/project/project_data.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

// ignore: must_be_immutable
class ProjectItemWidget extends StatelessWidget {
  ProjectItemWidget(this._projectItem, {super.key, this.onTapToProject});

  final ProjectData _projectItem;

  VoidCallback? onTapToProject;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapToProject?.call();
      },
      child: Container(
        height: 110.h,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.black900.withOpacity(0.1),
          borderRadius: BorderRadiusStyle.rounderBorder10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 96.h,
              child: Text(
                _projectItem.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(right: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "24 active task",
                            style: theme.textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              _projectItem.dateEnd!,
                              style: CustomTextStyles.aBeeZeeBlack900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 34.h,
                      width: 34.h,
                      child: CircularProgressIndicator(
                        value: _projectItem.tasksComplete,
                        backgroundColor:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        color: appTheme.blueA700,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
