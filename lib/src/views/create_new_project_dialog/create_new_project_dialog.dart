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
import 'package:projectmanager/src/views/create_new_project_dialog/bloc/create_new_project_bloc.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/bloc/create_new_project_event.dart';
import 'package:projectmanager/src/views/create_new_project_dialog/bloc/create_new_project_state.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class CreateNewProjectDialog extends StatelessWidget {
  CreateNewProjectDialog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewProjectBloc>(
      create: (context) => CreateNewProjectBloc(CreateNewProjectState())
        ..add(
          CreateNewProjectInitialEvent(),
        ),
      child: CreateNewProjectDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNewProjectBloc, CreateNewProjectState>(
      listener: (context, state) {
        if (state is CreateProjectSuccess) {
          NavigatorService.pushNamedAndRemoveUntil(
              AppRoutes.homeScreen); // Close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Project created successfully!")),
          );
        } else if (state is CreateProjectFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
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
                            _buildProjectNameInput(context),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: "msg_create_new_project".tr),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      height: 30.h,
      width: 30.h,
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.homeScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildProjectNameInput(BuildContext context) {
    return BlocSelector<CreateNewProjectBloc, CreateNewProjectState,
        TextEditingController?>(
      selector: (state) => state.projectNameInputController,
      builder: (context, projectNameInputController) {
        return CustomTextFormField(
          controller: projectNameInputController,
          hintText: "lbl_name_project".tr,
          hintStyle: CustomTextStyles.bodyMediumInter,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          validator: (value) {
            if (!isText(value) || value!.isEmpty) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildDueDateInput(BuildContext context) {
    return BlocSelector<CreateNewProjectBloc, CreateNewProjectState,
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

  Widget _buildProjectDescriptionInput(BuildContext context) {
    return BlocSelector<CreateNewProjectBloc, CreateNewProjectState,
        TextEditingController?>(
      selector: (state) => state.projectDescriptionInputController,
      builder: (context, projectDescriptionInputController) {
        return CustomTextFormField(
          controller: projectDescriptionInputController,
          hintText: "msg_input_description".tr,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          textInputAction: TextInputAction.done,
          maxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
        );
      },
    );
  }

  Widget _buildCreateButtonSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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

  onTapCreate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CreateNewProjectBloc>().add(
            CreateProjectEvent(),
          );
    }
  }

  Future<void> onTapDueDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<CreateNewProjectBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (dateTime != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        initialEntryMode: TimePickerEntryMode.input,
      );
      if (pickedTime != null) {
        // ignore: use_build_context_synchronously
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        initialState.dueDateInputController?.text =
            dateTime.format(pattern: D_M_Y);
      }
    }
  }

  onTapCancelButton(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.homeScreen,
    );
  }
}
