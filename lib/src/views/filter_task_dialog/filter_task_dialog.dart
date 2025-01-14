import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_button_style.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/date_time_utils.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/filter_task_dialog/bloc/filter_task_bloc.dart';
import 'package:projectmanager/src/views/filter_task_dialog/bloc/filter_task_event.dart';
import 'package:projectmanager/src/views/filter_task_dialog/bloc/filter_task_state.dart';
import 'package:projectmanager/src/views/filter_task_dialog/models/filter_task_model.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class FilterTaskDialog extends StatelessWidget {
  const FilterTaskDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<FilterTaskBloc>(
      create: (context) => FilterTaskBloc(FilterTaskState(
        filterTaskModelObj: FilterTaskModel(),
      ))
        ..add(FilterTaskInitialEvent()),
      child: const FilterTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              // vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              borderRadius: BorderRadiusStyle.customBorderT15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildAppbar(context),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lbl_by_status".tr,
                          style: CustomTextStyles.bodyLargeInter,
                        ),
                      ),
                      _buildStatusRow(context),
                      SizedBox(
                        height: 5.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "lbl_by_day".tr,
                          style: CustomTextStyles.bodyLargeInter,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateInput(context),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      _buildApplyButton(context),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: "lbl_filter".tr),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.goBack();
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildAllButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 82.h,
      text: "lbl_done".tr,
      buttonStyle: PrefUtils().getStatusFilterTask() == 'DONE'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterTask('DONE');
      },
    );
  }

  Widget _buildCompletedButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 82.h,
      text: "lbl_pending".tr,
      buttonStyle: PrefUtils().getStatusFilterTask() == 'PENDING'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterTask('PENDING');
      },
    );
  }

  Widget _buildPendingButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 100.h,
      text: "lbl_INPROGRESS".tr,
      buttonStyle: PrefUtils().getStatusFilterTask() == 'INPROGRESS'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterTask('INPROGRESS');
      },
    );
  }

  Widget _buildStatusRow(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadiusStyle.rounderBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAllButton(context),
          _buildPendingButton(context),
          _buildCompletedButton(context),
        ],
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return BlocSelector<FilterTaskBloc, FilterTaskState,
        TextEditingController?>(
      selector: (state) => state.dateInputController,
      builder: (context, dateInputController) {
        dateInputController?.text =
            PrefUtils().getDateFilterTask().substring(0, 10);
        return CustomTextFormField(
          readOnly: true,
          width: 115.h,
          controller: dateInputController,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          onTap: () {
            onTapDateInput(context);
          },
        );
      },
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_apply".tr,
      decoration: BoxDecoration(
        color: appTheme.black900.withOpacity(1),
        borderRadius: BorderRadiusStyle.rounderBorder10,
      ),
      buttonTextStyle: CustomTextStyles.grey,
      onPressed: () {
        onTapApplyButton(context);
      },
    );
  }

  Future<void> onTapDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<FilterTaskBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(PrefUtils().getDateFilterTask()),
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 2));
    if (dateTime != null) {
      // ignore: use_build_context_synchronously
      PrefUtils().setDateFilterTask(dateTime.format(pattern: D_M_Y));
      initialState.dateInputController?.text = dateTime.format(pattern: D_M_Y);
    }
  }

  onTapApplyButton(BuildContext context) {
    NavigatorService.pushNamedAndRemoveUntil(
      AppRoutes.projectScreen,
    );
  }
}
