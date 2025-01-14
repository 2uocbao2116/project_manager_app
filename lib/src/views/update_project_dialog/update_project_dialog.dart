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
import 'package:projectmanager/src/views/update_project_dialog/bloc/update_project_bloc.dart';
import 'package:projectmanager/src/views/update_project_dialog/bloc/update_project_event.dart';
import 'package:projectmanager/src/views/update_project_dialog/bloc/update_project_state.dart';
import 'package:projectmanager/src/views/update_project_dialog/models/update_project_model.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class UpdateProjectDialog extends StatelessWidget {
  UpdateProjectDialog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<UpdateProjectBloc>(
      create: (context) => UpdateProjectBloc(UpdateProjectState(
        updateProjectModelObj: UpdateProjectModel(),
      ))
        ..add(UpdateProjectInitialEvent()),
      child: UpdateProjectDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProjectBloc, UpdateProjectState>(
      listener: (context, state) {
        if (state is UpdateProjectSuccess) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Project updated successfully!")),
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
                              child: _buildProjectNameInput(context),
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
                              child: _buildProjectDescriptionInput(context),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: "lbl_update_project".tr),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.projectScreen);
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildProjectNameInput(BuildContext context) {
    return BlocSelector<UpdateProjectBloc, UpdateProjectState,
        TextEditingController?>(
      selector: (state) => state.projectNameInputController,
      builder: (context, projectNameInputController) {
        return CustomTextFormField(
          controller: projectNameInputController,
          hintText: GetProject().project!.name,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          contentPadding: EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 15.h),
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
    return BlocSelector<UpdateProjectBloc, UpdateProjectState,
        TextEditingController?>(
      selector: (state) => state.dueDateInputController,
      builder: (context, dueDateInputController) {
        dueDateInputController?.text = GetProject().project!.dateEnd!;
        return CustomTextFormField(
          readOnly: true,
          width: 150.h,
          controller: dueDateInputController,
          textInputAction: TextInputAction.done,
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
    return BlocSelector<UpdateProjectBloc, UpdateProjectState,
        TextEditingController?>(
      selector: (state) => state.projectDescriptionInputController,
      builder: (context, projectDescriptionInputController) {
        return CustomTextFormField(
          controller: projectDescriptionInputController,
          hintText: GetProject().project!.description,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          textInputAction: TextInputAction.done,
          maxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
        );
      },
    );
  }

  Future<void> onTapDueDateInput(BuildContext context) async {
    var initialState = BlocProvider.of<UpdateProjectBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 2));
    if (dateTime != null) {
      // ignore: use_build_context_synchronously
      context.read<UpdateProjectBloc>().add(ChangeDateEvent(date: dateTime));
      initialState.dueDateInputController?.text =
          dateTime.format(pattern: D_M_Y);
    }
  }

  onTapUpdateButton(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateProjectBloc>().add(
            UpdateProject(),
          );
    }
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
              onTapUpdateButton(context);
            },
          )
        ],
      ),
    );
  }
}
