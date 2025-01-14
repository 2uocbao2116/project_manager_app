import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/option_task_dialog/bloc/option_task_bloc.dart';
import 'package:projectmanager/src/views/option_task_dialog/bloc/option_task_event.dart';
import 'package:projectmanager/src/views/option_task_dialog/bloc/option_task_state.dart';
import 'package:projectmanager/src/views/option_task_dialog/models/option_task_model.dart';
import 'package:projectmanager/src/views/update_task_dialog/update_task_dialog.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';

class OptionTaskDialog extends StatelessWidget {
  const OptionTaskDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<OptionTaskBloc>(
      create: (context) => OptionTaskBloc(
        OptionTaskState(
          optionTaskModelObj: OptionTaskModel(),
        ),
      )..add(OptionTaskInitialEvent()),
      child: const OptionTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 150.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
            borderRadius: BorderRadiusStyle.rounderBorder10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildOptionsColumn(context),
              CustomElevatedButton(
                height: 30.h,
                text: "lbl_edit".tr,
                buttonTextStyle: CustomTextStyles.titleLargeInter,
                onPressed: () {
                  onTapEdit(context);
                },
              ),
              CustomElevatedButton(
                height: 30.h,
                text: "lbl_delete".tr,
                buttonTextStyle: CustomTextStyles.titleLargeInter,
              ),
              CustomElevatedButton(
                height: 30.h,
                text: "lbl_cancel".tr,
                buttonTextStyle: CustomTextStyles.titleLargeInter,
                onPressed: () {
                  onTapCancel(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOptionsColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        children: [
          Text(
            "lbl_options".tr,
            style: theme.textTheme.labelLarge,
          )
        ],
      ),
    );
  }

  onTapEdit(BuildContext context) {
    showDialog(
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        content: UpdateTaskDialog.builder(
            NavigatorService.navigatorKey.currentContext!),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
      ),
    );
  }

  onTapCancel(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.projectScreen);
  }
}
