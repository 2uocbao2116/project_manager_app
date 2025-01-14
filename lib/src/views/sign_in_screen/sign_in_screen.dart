import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/utils/validation_functions.dart';
import 'package:projectmanager/src/views/sign_in_screen/bloc/sign_in_state.dart';
import 'package:projectmanager/src/views/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:projectmanager/src/views/sign_in_screen/bloc/sign_in_event.dart';
import 'package:projectmanager/src/views/sign_in_screen/models/sign_in_model.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(SignInState(
        signInModelObj: SignInModel(),
      )),
      child: const SignInScreen(),
    );
  }

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          _usernameController.clear();
          _passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
          state.error = "";
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 20.h,
                    right: 14.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "lbl_welcome_back".tr,
                        style: theme.textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 28.h),
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
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(horizontal: 14.h),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.h),
                                      child: Text(
                                        "lbl_sign_in".tr,
                                        style: theme.textTheme.displayMedium,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  BlocSelector<SignInBloc, SignInState,
                                      TextEditingController?>(
                                    selector: (state) =>
                                        state.userNameController,
                                    builder: (context, userNameController) {
                                      return CustomTextFormField(
                                        controller: _usernameController,
                                        hintText: "lbl_username".tr,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.h, 4.h, 10.h, 18.h),
                                        validator: (value) {
                                          if (!isValidPhone(value,
                                                  isRequired: true) ||
                                              value == null) {
                                            return "err_msg_please_enter_valid_phone_number"
                                                .tr;
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  BlocSelector<SignInBloc, SignInState,
                                      TextEditingController?>(
                                    selector: (state) =>
                                        state.passwordController,
                                    builder: (context, passwordController) {
                                      return CustomTextFormField(
                                        controller: _passwordController,
                                        hintText: "lbl_password".tr,
                                        textInputAction: TextInputAction.done,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        obscureText: _isObscured,
                                        suffix: IconButton(
                                          icon: Icon(
                                            _isObscured
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured =
                                                  !_isObscured; // Toggle the state
                                            });
                                          },
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.h, 4.h, 10.h, 18.h),
                                        validator: (value) {
                                          if (value == null
                                              ? true
                                              : value.isEmpty) {
                                            return "err_msg_please_enter_valid_password"
                                                .tr;
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text(
                                        "lbl_forgot_password".tr,
                                        style: CustomTextStyles.bodySmallInter,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  CustomElevatedButton(
                                    text: "lbl_sign_in".tr,
                                    buttonTextStyle: CustomTextStyles.grey,
                                    decoration: BoxDecoration(
                                      color: appTheme.black900.withOpacity(1),
                                      borderRadius:
                                          BorderRadiusStyle.rounderBorder10,
                                    ),
                                    onPressed: () {
                                      onTapSignIn(context);
                                    },
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Text(
                                    "lbl_or_sign_in_with".tr,
                                    style: CustomTextStyles.bodySmallInterLight,
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                  SizedBox(
                                    width: 102.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomImageView(
                                          imagePath:
                                              ImageConstant.imgSocialIcons,
                                          height: 30.h,
                                          width: 32.h,
                                          onTap: () {
                                            context
                                                .read<SignInBloc>()
                                                .add(SignInByFaceBook());
                                          },
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant
                                              .imgSocialIconsRed500,
                                          height: 30.h,
                                          width: 32.h,
                                          onTap: () {
                                            // context
                                            //     .read<SignInBloc>()
                                            //     .add(SignInByGoogle());
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      onTapTxtConfirmation(context);
                                    },
                                    child: Text(
                                      "msg_don_t_have_an_account".tr,
                                      style:
                                          CustomTextStyles.bodySmallInterLight,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
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

  onTapSignIn(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignInBloc>().add(
            SignInSubmitted(
                username: _usernameController.text,
                password: _passwordController.text),
          );
    }
  }

  onTapTxtConfirmation(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.signUpScreen,
    );
  }
}
