import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:projectmanager/src/views/sign_up_screen/bloc/sign_up_event.dart';
import 'package:projectmanager/src/views/sign_up_screen/bloc/sign_up_state.dart';
import 'package:projectmanager/src/views/sign_up_screen/models/sign_up_model.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(SignUpState(
        signUpModelObj: SignUpModel(),
      ))
        ..add(SignUpInitialEvent()),
      child: const SignUpScreen(),
    );
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController? firstName = TextEditingController();
  final TextEditingController? lastName = TextEditingController();
  final TextEditingController? phoneNumber = TextEditingController();
  final TextEditingController? email = TextEditingController();
  final TextEditingController? password = TextEditingController();
  final TextEditingController? confirmPassword = TextEditingController();
  bool _isObscured = true;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
        }
        if (state is SignUpFailure) {
          phoneNumber!.clear();
          email!.clear();
          password!.clear();
          confirmPassword!.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
          state.message = "";
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 18.h,
                    right: 14.h,
                  ),
                  child: Column(
                    children: [
                      _buildSignupTitle(context),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(14.h),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(1),
                          borderRadius: BorderRadiusStyle.customBorderTL50,
                          boxShadow: [
                            BoxShadow(
                              color: appTheme.black900.withOpacity(0.4),
                              spreadRadius: 0.h,
                              blurRadius: 70.h,
                              offset: const Offset(
                                0,
                                0,
                              ),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 28.h,
                            ),
                            _buildNameInputRow(context),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildEmailInput(context),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildPhoneNumberInput(context),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildPasswordInput(context),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildConfirmPasswordInput(context),
                            SizedBox(
                              height: 40.h,
                            ),
                            _buildSignupButton(context),
                            SizedBox(
                              height: 48.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                onTapTxtConfirmation(context);
                              },
                              child: Text(
                                "msg_already_have_an".tr,
                                style: CustomTextStyles.bodySmallInterLight,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupTitle(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "lbl_sign_up".tr,
            style: theme.textTheme.displayMedium,
          )
        ],
      ),
    );
  }

  Widget _buildFirstNameInput(BuildContext context) {
    return Expanded(
        child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
      selector: (state) => state.firstNameInputController,
      builder: (context, firstNameInputController) {
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
      child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
        selector: (state) => state.lastNameInputController,
        builder: (context, lastNameInputController) {
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
      ),
    );
  }

  Widget _buildNameInputRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      width: double.maxFinite,
      child: Row(
        children: [
          _buildFirstNameInput(context),
          SizedBox(
            width: 10.h,
          ),
          _buildLastNameInput(context),
        ],
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
        selector: (state) => state.emailInputController,
        builder: (context, emailInputController) {
          return CustomTextFormField(
            controller: email,
            hintText: "lbl_email".tr,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
            validator: (value) {
              if (value == null || (!isValidEmail(value, isRequired: true))) {
                return "err_msg_please_enter_valid_email".tr;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
        selector: (state) => state.phoneNumberInputController,
        builder: (context, phoneNumberInputController) {
          return CustomTextFormField(
            controller: phoneNumber,
            hintText: "lbl_phonenumber".tr,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.fromLTRB(10.h, 4.h, 10.h, 14.h),
            validator: (value) {
              if (!isValidPhone(value, isRequired: true)) {
                return "err_msg_please_enter_valid_phone_number".tr;
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
        selector: (state) => state.passwordInputController,
        builder: (context, passwordInputController) {
          return CustomTextFormField(
            controller: password,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: BlocSelector<SignUpBloc, SignUpState, TextEditingController?>(
        selector: (state) => state.confirmPasswordInputController,
        builder: (context, confirmPasswordInputController) {
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
              if (value != password!.text) {
                return "err_msg_password_do_not_match".tr;
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

  Widget _buildSignupButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_sign_up".tr,
      buttonTextStyle: CustomTextStyles.grey,
      decoration: BoxDecoration(
        color: appTheme.black900.withOpacity(1),
        borderRadius: BorderRadiusStyle.rounderBorder10,
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<SignUpBloc>().add(
                SignUp(
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  email: email,
                  password: password,
                ),
              );
        }
      },
    );
  }

  onTapTxtConfirmation(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signInScreen,
    );
  }
}
