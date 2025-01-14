import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/option_logout_dialog/bloc/option_logout_bloc.dart';
import 'package:projectmanager/src/views/option_logout_dialog/bloc/option_logout_event.dart';
import 'package:projectmanager/src/views/option_logout_dialog/bloc/option_logout_state.dart';
import 'package:projectmanager/src/views/option_logout_dialog/models/option_logout_model.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';

class OptionLogoutDialog extends StatelessWidget {
  const OptionLogoutDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<OptionLogoutBloc>(
      create: (context) => OptionLogoutBloc(
        OptionLogoutState(
          optionLogoutModelObj: OptionLogoutModel(),
        ),
      )..add(OptionLogoutInitialEvent()),
      child: const OptionLogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 150.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
            borderRadius: BorderRadiusStyle.rounderBorder10,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.h, right: 10.h),
                child: Column(
                  children: [
                    Text(
                      "msg_logout_sure".tr,
                      style: theme.textTheme.bodyLarge,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: "lbl_log_out".tr,
                height: 30.h,
                buttonTextStyle: CustomTextStyles.titleLargeInter,
                onPressed: () {
                  context.read<OptionLogoutBloc>().add(LogoutEvent());
                  NavigatorService.pushNamedAndRemoveUntil(
                      AppRoutes.signInScreen);
                },
              ),
              CustomElevatedButton(
                // width: 145.h,
                height: 30.h,
                text: "lbl_cancel".tr,

                buttonTextStyle: CustomTextStyles.titleLargeInter,
                onPressed: () {
                  NavigatorService.goBack();
                },
              ),
              // SizedBox(
              //   height: 3.h,
              // )
            ],
          ),
        )
      ],
    );
  }
}
