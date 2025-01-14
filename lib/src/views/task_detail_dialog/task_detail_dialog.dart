import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/app_decoration.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/task_detail_dialog/bloc/task_detail_bloc.dart';
import 'package:projectmanager/src/views/task_detail_dialog/bloc/task_detail_event.dart';
import 'package:projectmanager/src/views/task_detail_dialog/bloc/task_detail_state.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_elevated_button.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class TaskDetailDialog extends StatefulWidget {
  const TaskDetailDialog({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<TaskDetailBloc>(
      create: (context) => TaskDetailBloc(TaskDetailState(
        taskData: TaskData(),
      ))
        ..add(FetchDetailTask()),
      child: const TaskDetailDialog(),
    );
  }

  @override
  State<TaskDetailDialog> createState() => _TaskDetailDialogState();
}

class _TaskDetailDialogState extends State<TaskDetailDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailBloc, TaskDetailState>(
      listener: (context, state) {
        if (state is FetchDetailTaskFailure) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
      },
      child: BlocSelector<TaskDetailBloc, TaskDetailState, TaskDetailState>(
        selector: (state) => state,
        builder: (context, state) {
          return Column(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildAppBar(context, state.taskData?.name ?? "name"),
                    _buildDatabaseDesignSection(
                        context, state.taskData?.username ?? "username"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lbl_description".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    _buildDescription(
                        context, state.taskData?.description ?? "description"),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTaskStatusAndDateEnd(context, state.taskData),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextInputContent(context,
                        state.taskData?.contentSubmit ?? "Input your report"),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildSubmitButtonSection(context, state),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String name) {
    return CustomAppBar(
      centerTitle: true,
      leading: _buildBackButton(context),
      title: AppbarTitle(text: name),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.goBack();
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }

  Widget _buildDatabaseDesignSection(BuildContext context, String username) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgZ590011109802730x30,
                  height: 30.h,
                  width: 30.h,
                  radius: BorderRadius.circular(14.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    username,
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, String description) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatusAndDateEnd(BuildContext context, TaskData? state) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_due_date".tr,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.h),
                child: Text(
                  state?.dateEnd ?? "null",
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "lbl_status".tr,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                state?.status ?? "null",
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputContent(BuildContext context, String content) {
    return Form(
      key: _formKey,
      child: SizedBox(
        child: CustomTextFormField(
          controller: _textEditingController,
          hintText: content,
          hintStyle: CustomTextStyles.bodyLargeBlack900,
          textInputAction: TextInputAction.done,
          maxLines: 2,
          contentPadding: EdgeInsets.fromLTRB(10.h, 8.h, 10.h, 12.h),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButtonSection(
      BuildContext context, TaskDetailState state) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          CustomElevatedButton(
            text: "lbl_submit".tr,
            buttonTextStyle: CustomTextStyles.grey,
            decoration: BoxDecoration(
              color: appTheme.black900,
              borderRadius: BorderRadiusStyle.rounderBorder10,
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context
                    .read<TaskDetailBloc>()
                    .add(ReportTask(inforReport: _textEditingController.text));
              }
            },
          )
        ],
      ),
    );
  }

  onTapSubmit(BuildContext context) {
    NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
  }
}
