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
import 'package:projectmanager/src/views/filter_project_dialog/bloc/filter_project_bloc.dart';
import 'package:projectmanager/src/views/filter_project_dialog/bloc/filter_project_event.dart';
import 'package:projectmanager/src/views/filter_project_dialog/bloc/filter_project_state.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class FilterProjectDialog extends StatelessWidget {
  const FilterProjectDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<FilterProjectBloc>(
      create: (context) => FilterProjectBloc(FilterProjectState())
        ..add(FilterProjectInitialEvent()),
      child: const FilterProjectDialog(),
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
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        _buildAppBar(context),
                        _buildFilterOptions(context),
                        _buildStatusRow(context),
                        _buildDateFilter(context),
                        _buildApplyButton(context),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
        NavigatorService.pushNamed(AppRoutes.homeScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildFilterOptions(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            "lbl_by_status".tr,
            style: theme.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  Widget _buildAllButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 82.h,
      text: "lbl_done".tr,
      buttonStyle: PrefUtils().getStatusFilterProject() == 'DONE'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterProject('DONE');
      },
    );
  }

  Widget _buildPendingButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 82.h,
      text: "lbl_pending".tr,
      buttonStyle: PrefUtils().getStatusFilterProject() == 'PENDING'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterProject('PENDING');
      },
    );
  }

  Widget _buildCompletedButton(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 100.h,
      text: "lbl_INPROGRESS".tr,
      buttonStyle: PrefUtils().getStatusFilterProject() == 'INPROGRESS'
          ? CustomButtonStyles.fillBlack
          : CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      onPressed: () {
        PrefUtils().setStatusFilterProject('INPROGRESS');
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
          _buildCompletedButton(context),
          _buildPendingButton(context),
        ],
      ),
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

  Widget _buildDateFilter(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_by_day".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStartDateInput(context),
              _buildEndDateInput(context),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }

  Widget _buildStartDateInput(BuildContext context) {
    return BlocSelector<FilterProjectBloc, FilterProjectState,
        TextEditingController?>(
      selector: (state) => state.startDateInputController,
      builder: (context, dateInputController) {
        dateInputController?.text =
            PrefUtils().getStartDateFilterProject().substring(0, 10);
        return CustomTextFormField(
          readOnly: true,
          width: 115.h,
          controller: dateInputController,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          onTap: () {
            onTapStartDateInput(context);
          },
        );
      },
    );
  }

  Future<void> onTapStartDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<FilterProjectBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(PrefUtils().getStartDateFilterProject()),
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (dateTime != null) {
      PrefUtils().setStartDateFilterProject(dateTime.format(pattern: D_M_Y));
      initialState.startDateInputController?.text =
          dateTime.format(pattern: D_M_Y);
    }
  }

  Widget _buildEndDateInput(BuildContext context) {
    return BlocSelector<FilterProjectBloc, FilterProjectState,
        TextEditingController?>(
      selector: (state) => state.endDateInputController,
      builder: (context, dateInputController) {
        dateInputController?.text =
            PrefUtils().getEndDateFilterProject().substring(0, 10);
        return CustomTextFormField(
          readOnly: true,
          width: 115.h,
          controller: dateInputController,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          onTap: () {
            onTapEndDateInput(context);
          },
        );
      },
    );
  }

  Future<void> onTapEndDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<FilterProjectBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: DateTime.tryParse(PrefUtils().getEndDateFilterProject()),
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (dateTime != null) {
      PrefUtils().setEndDateFilterProject(dateTime.format(pattern: D_M_Y));
      initialState.endDateInputController?.text =
          dateTime.format(pattern: D_M_Y);
    }
  }

  onTapApplyButton(BuildContext context) {
    NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
  }
}
