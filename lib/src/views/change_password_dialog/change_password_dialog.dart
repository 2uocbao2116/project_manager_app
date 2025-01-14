import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/change_password_dialog/bloc/change_password_bloc.dart';
import 'package:projectmanager/src/views/change_password_dialog/bloc/change_password_event.dart';
import 'package:projectmanager/src/views/change_password_dialog/bloc/change_password_state.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) => ChangePasswordBloc(
        ChangePasswordState(),
      )..add(ChangePasswordInitialEvent()),
      child: const ChangePasswordDialog(),
    );
  }

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _isObscured = true;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          NavigatorService.goBack();
        }
        if (state is ChangePasswordFailure) {
          oldPassword.clear();
          newPassword.clear();
          confirmPassword.clear();
          setState(() {
            errorMessage = state.message;
          });
          state.message = '';
          _formKey.currentState!.validate();
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
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 8.h,
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
                            Text(
                              "lbl_change_password".tr,
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: appTheme.nearBlack,
                                fontSize: 20.fSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildPasswordInput(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildNewPasswordInput(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildConfirmPasswordInput(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildActionButtonsRow(context),
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

  Widget _buildPasswordInput(BuildContext context) {
    return SizedBox(
      child: BlocSelector<ChangePasswordBloc, ChangePasswordState,
          ChangePasswordState>(
        selector: (state) => state,
        builder: (context, state) {
          return CustomTextFormField(
            controller: oldPassword,
            hintText: "lbl_password".tr,
            textInputType: TextInputType.visiblePassword,
            obscureText: _isObscured,
            suffix: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured; // Toggle the state
                });
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
            validator: (value) {
              if (errorMessage!.isNotEmpty) {
                return errorMessage;
              }
              if (value == null ||
                  (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildNewPasswordInput(BuildContext context) {
    return SizedBox(
      child: BlocSelector<ChangePasswordBloc, ChangePasswordState,
          ChangePasswordState>(
        selector: (state) => state,
        builder: (context, state) {
          return CustomTextFormField(
            controller: newPassword,
            hintText: "lbl_new_password".tr,
            textInputType: TextInputType.visiblePassword,
            obscureText: _isObscured,
            suffix: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured; // Toggle the state
                });
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
            validator: (value) {
              if (value == null ||
                  (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return SizedBox(
      child: BlocSelector<ChangePasswordBloc, ChangePasswordState,
          ChangePasswordState>(
        selector: (state) => state,
        builder: (context, state) {
          return CustomTextFormField(
            controller: confirmPassword,
            hintText: "msg_confirm_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: _isObscured,
            suffix: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured; // Toggle the state
                });
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
            validator: (value) {
              if (value == null ||
                  (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              if (value != state.newPasswordInputController!.text) {
                return "err_msg_password_do_not_match".tr;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_update2".tr,
      width: 100.h,
      buttonTextStyle: CustomTextStyles.grey,
      decoration: BoxDecoration(
        color: appTheme.black900.withOpacity(1),
        borderRadius: BorderRadiusStyle.rounderBorder10,
      ),
      onPressed: () {
        setState(() {
          errorMessage = '';
        });
        if (_formKey.currentState?.validate() ?? false) {
          context.read<ChangePasswordBloc>().add(UpdatePasswordEvent(
              oldPassword: oldPassword, newPassword: newPassword));
        }
      },
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_cancel".tr,
      width: 100.h,
      buttonTextStyle: CustomTextStyles.grey,
      decoration: BoxDecoration(
        color: appTheme.black900.withOpacity(1),
        borderRadius: BorderRadiusStyle.rounderBorder10,
      ),
      onPressed: () {
        NavigatorService.goBack();
      },
    );
  }

  Widget _buildActionButtonsRow(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_buildUpdateButton(context), _buildCancelButton(context)],
      ),
    );
  }
}
