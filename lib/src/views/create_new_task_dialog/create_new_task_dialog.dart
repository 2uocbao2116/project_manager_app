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
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/bloc/create_new_task_bloc.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/bloc/create_task_event.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/bloc/create_new_task_state.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/models/create_new_task_model.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class CreateNewTaskDialog extends StatelessWidget {
  CreateNewTaskDialog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewTaskBloc>(
      create: (context) => CreateNewTaskBloc(CreateNewTaskState(
        createNewTaskModelObj: CreateNewTaskModel(),
      ))
        ..add(CreateNewTaskInitialEvent()),
      child: CreateNewTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNewTaskBloc, CreateNewTaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccessState) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
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
                  _buildAppBar(context),
                  _buildTaskNameInput(context),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "lbl_due_date2".tr,
                      style: CustomTextStyles.bodyLargeInter,
                    ),
                  ),
                  _buildDueDateInput(context),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "lbl_description".tr,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  _buildProjectDescriptionInput(context),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildCreateButtonSection(context),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: "lbl_create_new_task".tr),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      height: 30.h,
      width: 30.h,
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.projectScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildTaskNameInput(BuildContext context) {
    return BlocSelector<CreateNewTaskBloc, CreateNewTaskState,
        TextEditingController?>(
      selector: (state) => state.taskNameInputController,
      builder: (context, taskNameInputController) {
        return CustomTextFormField(
          controller: taskNameInputController,
          hintText: "lbl_name_task".tr,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
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

  Widget _buildProjectDescriptionInput(BuildContext context) {
    return BlocSelector<CreateNewTaskBloc, CreateNewTaskState,
        TextEditingController?>(
      selector: (state) => state.taskDescriptionInputController,
      builder: (context, taskDescriptionInputController) {
        return CustomTextFormField(
          controller: taskDescriptionInputController,
          hintText: "msg_input_description".tr,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          textInputAction: TextInputAction.done,
          maxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
        );
      },
    );
  }

  Widget _buildDueDateInput(BuildContext context) {
    return BlocSelector<CreateNewTaskBloc, CreateNewTaskState,
        TextEditingController?>(
      selector: (state) => state.dueDateInputController,
      builder: (context, dueDateInputController) {
        dueDateInputController?.text = DateTime.now().format(pattern: D_M_Y);
        return CustomTextFormField(
          readOnly: true,
          width: 150.h,
          controller: dueDateInputController,
          alignment: Alignment.centerLeft,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          onTap: () {
            onTapDueDateInput(context);
          },
        );
      },
    );
  }

  Widget _buildCreateButtonSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          CustomElevatedButton(
            text: "lbl_create".tr,
            buttonTextStyle: CustomTextStyles.grey,
            decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(1),
              borderRadius: BorderRadiusStyle.rounderBorder10,
            ),
            onPressed: () {
              onTapCreate(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> onTapDueDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<CreateNewTaskBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 2));
    if (dateTime != null) {
      TimeOfDay? timeOfDay = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );
      if (timeOfDay != null) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
        );
        // ignore: use_build_context_synchronously
        context.read<CreateNewTaskBloc>().add(ChangeDateEvent(date: dateTime));
        initialState.dueDateInputController?.text =
            dateTime.format(pattern: D_M_Y);
      }
    }
  }

  onTapCreate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CreateNewTaskBloc>().add(
            CreateNewTaskEvent(),
          );
    }
  }
}
