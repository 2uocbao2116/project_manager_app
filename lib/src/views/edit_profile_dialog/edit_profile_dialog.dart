import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/bloc/edit_profile_bloc.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/bloc/edit_profile_event.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/bloc/edit_profile_state.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/models/edit_profile_model.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      create: (context) => EditProfileBloc(EditProfileState(
        editProfileModelObj: EditProfileModel(),
      ))
        ..add(EditProfileInitialEvent()),
      child: const EditProfileDialog(),
    );
  }

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController? firstName = TextEditingController();
  final TextEditingController? lastName = TextEditingController();
  final TextEditingController? email = TextEditingController();
  final TextEditingController? phoneNumber = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          NavigatorService.goBack();
        }
        if (state is UpdateProfileFailure) {
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
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                borderRadius: BorderRadiusStyle.customBorderT15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Text(
                              "lbl_edit_profile".tr,
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: appTheme.nearBlack,
                                fontSize: 20.fSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            _buildProfileSection(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildFirstNameInput(context),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  _buildLastNameInput(context),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildEmailInput(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildPhoneNumberInput(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildActionButtonsRow(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgZ5900111098027150x150,
            height: 150.h,
            width: 150.h,
            radius: BorderRadius.circular(
              74.h,
            ),
          ),
          Positioned(
            right: 50,
            bottom: 5,
            child: CustomIconButton(
              decoration: IconButtonStyleHelper.none,
              onTap: () {
                // onTapShowFilter(context);
              },
              child: CustomImageView(
                imagePath: ImageConstant.camereSVG,
                height: 20.h,
                width: 20.h,
              ),
            ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstNameInput(BuildContext context) {
    return Expanded(
        child:
            BlocSelector<EditProfileBloc, EditProfileState, EditProfileState>(
      selector: (state) => state,
      builder: (context, state) {
        firstName?.text = PrefUtils().getUser()!.firstName!;
        return CustomTextFormField(
          controller: firstName,
          hintText: "lbl_first_name".tr,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    ));
  }

  Widget _buildLastNameInput(BuildContext context) {
    return Expanded(
        child:
            BlocSelector<EditProfileBloc, EditProfileState, EditProfileState>(
      selector: (state) => state,
      builder: (context, state) {
        lastName?.text = PrefUtils().getUser()!.lastName!;
        return CustomTextFormField(
          controller: lastName,
          hintText: "lbl_last_name".tr,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    ));
  }

  Widget _buildEmailInput(BuildContext context) {
    return SizedBox(
        child:
            BlocSelector<EditProfileBloc, EditProfileState, EditProfileState>(
      selector: (state) => state,
      builder: (context, state) {
        email?.text = PrefUtils().getUser()!.email!;
        return CustomTextFormField(
          controller: email,
          hintText: "lbl_email".tr,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          validator: (value) {
            if (errorMessage!.isNotEmpty) {
              return errorMessage;
            }
            if (value == null || (!isValidEmail(value, isRequired: true))) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    ));
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return SizedBox(
        child:
            BlocSelector<EditProfileBloc, EditProfileState, EditProfileState>(
      selector: (state) => state,
      builder: (context, state) {
        phoneNumber!.text = PrefUtils().getUser()!.phoneNumber!;
        return CustomTextFormField(
          controller: phoneNumber,
          hintText: "lbl_phonenumber".tr,
          contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
          validator: (value) {
            if (errorMessage == 'phonenumber') {
              return errorMessage;
            }
            if (!isValidPhone(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    ));
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
          context.read<EditProfileBloc>().add(UpdateProfileEvent(
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber,
                email: email,
              ));
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_buildUpdateButton(context), _buildCancelButton(context)],
      ),
    );
  }
}
