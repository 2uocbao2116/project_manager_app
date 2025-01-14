import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/date_time_utils.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/update_task_dialog/bloc/update_task_bloc.dart';
import 'package:projectmanager/src/views/update_task_dialog/bloc/update_task_event.dart';
import 'package:projectmanager/src/views/update_task_dialog/bloc/update_task_state.dart';
import 'package:projectmanager/src/views/update_task_dialog/models/update_task_model.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class UpdateTaskDialog extends StatelessWidget {
  UpdateTaskDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<UpdateTaskBloc>(
      create: (context) => UpdateTaskBloc(UpdateTaskState(
        updateTaskModelObj: UpdateTaskModel(),
      ))
        ..add(FetchTaskDetail()),
      child: UpdateTaskDialog(),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTaskBloc, UpdateTaskState>(
      listener: (context, state) {
        if (state is UpdateTaskSuccess) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10.h),
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: _buildNameInput(context),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "lbl_due_date2".tr,
                                  style: CustomTextStyles.bodyLargeInter,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: _buildDueDateInput(context),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "lbl_description".tr,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: _buildDescriptionInput(context),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: _buildUpdateButtonSection(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return BlocSelector<UpdateTaskBloc, UpdateTaskState,
        TextEditingController?>(
      selector: (state) => state.taskNameInputController,
      builder: (context, state) {
        return CustomTextFormField(
          controller: state,
          hintText: PrefUtils().getListTasks()!.name,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildDueDateInput(BuildContext context) {
    return BlocSelector<UpdateTaskBloc, UpdateTaskState,
        TextEditingController?>(
      selector: (state) => state.dueDateInputController,
      builder: (context, state) {
        state?.text = PrefUtils().getListTasks()!.dateEnd!;
        return CustomTextFormField(
          readOnly: true,
          width: 150.h,
          controller: state,
          alignment: Alignment.centerLeft,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          onTap: () {
            onTapDueDateInput(context);
          },
        );
      },
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    return BlocSelector<UpdateTaskBloc, UpdateTaskState,
        TextEditingController?>(
      selector: (state) => state.taskDescriptionInputController,
      builder: (context, state) {
        return CustomTextFormField(
          controller: state,
          hintText: PrefUtils().getListTasks()!.description!,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          maxLines: 2,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Future<void> onTapDueDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<UpdateTaskBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
    );
    if (dateTime != null) {
      // ignore: use_build_context_synchronously
      context.read<UpdateTaskBloc>().add(ChangeDateEvent(date: dateTime));
      initialState.dueDateInputController?.text =
          dateTime.format(pattern: D_M_Y);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: "lbl_update_task".tr),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildUpdateButtonSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          CustomElevatedButton(
            text: "lbl_update".tr,
            buttonTextStyle: CustomTextStyles.grey,
            decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(1),
              borderRadius: BorderRadiusStyle.rounderBorder10,
            ),
            onPressed: () {
              onTapUpdate(context);
            },
          )
        ],
      ),
    );
  }

  onTapUpdate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateTaskBloc>().add(UpdateTask());
    }
  }
}
