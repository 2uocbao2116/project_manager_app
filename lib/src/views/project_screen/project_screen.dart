import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:projectmanager/src/data/models/task/task_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/gdp_data.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/create_new_task_dialog/create_new_task_dialog.dart';
import 'package:projectmanager/src/views/filter_task_dialog/filter_task_dialog.dart';
import 'package:projectmanager/src/views/home_screen/home_screen.dart';
import 'package:projectmanager/src/views/option_project_dialog/option_project_dialog.dart';
import 'package:projectmanager/src/views/project_screen/bloc/project_bloc.dart';
import 'package:projectmanager/src/views/project_screen/bloc/project_event.dart';
import 'package:projectmanager/src/views/project_screen/bloc/project_state.dart';
import 'package:projectmanager/src/views/project_screen/models/list_task_item.dart';
import 'package:projectmanager/src/views/project_screen/models/project_model.dart';
import 'package:projectmanager/src/views/project_screen/models/task_gdp.dart';
import 'package:projectmanager/src/views/project_screen/widgets/task_list_item_widget.dart';
import 'package:projectmanager/src/views/task_detail_dialog/task_detail_dialog.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ProjectBloc>(
      create: (context) => ProjectBloc(
        ProjectState(
          listTaskItem: ListTaskItem(),
          gdpTask: TaskGdp(),
          projectModel: ProjectModel(),
        ),
      )..add(FetchProjectEvent()),
      child: const ProjectScreen(),
    );
  }

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<ProjectBloc>().add(FetchTasksEvent());
    }
  }

  bool get _isBottom {
    if (context.read<ProjectBloc>().state.hasMore) {
      return false;
    }
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProjectBloc>().add(FetchTasksEvent());
    return BlocBuilder<ProjectBloc, ProjectState?>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context, state?.projectModel),
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildTaskSummary(
                      context, state?.gdpTask, state?.projectModel),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildTaskList(context, state!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ProjectModel? projectModel) {
    return CustomAppBar(
      centerTitle: true,
      leading: CustomIconButton(
        decoration: IconButtonStyleHelper.none,
        onTap: () {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
        },
        child: CustomImageView(
          imagePath: ImageConstant.back,
        ),
      ),
      title: AppbarTitle(text: projectModel?.name ?? "Name Project"),
      actions: [
        PrefUtils().getUser()!.id!.contains(PrefUtils().getProject()!.userId!)
            ? CustomImageView(
                imagePath: ImageConstant.threeDots,
                height: 40.h,
                width: 20.h,
                onTap: () {
                  _buildOptionButton(context);
                },
              )
            : const SizedBox(),
      ],
      styleType: Style.bgFillOnPrimaryContainer,
    );
  }

  Widget _buildTaskSummary(
      BuildContext context, TaskGdp? taskGdp, ProjectModel? projectModel) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150.h,
            child: PageView(
              children: [
                _buildCircularChartTask(taskGdp),
                _buildDetailProjectInSumary(projectModel),
              ],
            ),
          ),
          _buildCreateAndFilter(context)
        ],
      ),
    );
  }

  Widget _buildCreateAndFilter(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Row(
                  children: [
                    Text(
                      "lbl_all_projects".tr,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.h, right: 10.h),
                      child: CustomIconButton(
                        decoration: IconButtonStyleHelper.none,
                        onTap: () {
                          onTapToCreateTaskDialog(context);
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgAddCircleBut,
                          height: 15.h,
                          width: 15.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomIconButton(
            decoration: IconButtonStyleHelper.none,
            onTap: () {
              onTapToFilterDialog(context);
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgVerticalSlider,
              height: 15.h,
              width: 15.h,
            ),
          ),
          SizedBox(
            width: 20.h,
          )
        ],
      ),
    );
  }

  Widget _buildCircularChartTask(TaskGdp? taskGdp) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150.h,
      child: Row(children: [
        SfCircularChart(
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          series: <CircularSeries>[
            PieSeries<GDPData, String>(
              dataSource: taskGdp?.listGDPData,
              xValueMapper: (GDPData data, _) => data.continent,
              yValueMapper: (GDPData data, _) => data.gdp,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ]),
    );
  }

  Widget _buildDetailProjectInSumary(ProjectModel? projectModel) {
    return Container(
      height: 150.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "lbl_description".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                _buildDescription(
                    context, projectModel?.description ?? "description"),
                _buildTaskStatusAndDateEnd(context, projectModel),
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

  Widget _buildTaskStatusAndDateEnd(
      BuildContext context, ProjectModel? projectModel) {
    DateTime dateTime = DateTime.parse(
        projectModel?.createdAt ?? "2024-11-22T15:20:48.000+00:00");
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_due_date".tr,
                        style: CustomTextStyles.bodySmallInter,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          projectModel?.dueDate ?? "null",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Text(
                          "lbl_createdAt".tr,
                          style: CustomTextStyles.bodySmallInter,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(dateTime),
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "lbl_status".tr,
                style: theme.textTheme.bodySmall,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  projectModel?.status ?? "null",
                  style: CustomTextStyles.bodySmallInter,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, ProjectState state) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 18.h,
            );
          },
          controller: _scrollController,
          itemCount: state.hasMore
              ? state.listTaskItem!.listTasksItem.length
              : state.listTaskItem!.listTasksItem.length + 1,
          itemBuilder: (context, index) {
            if (state.hasMore && state.listTaskItem!.listTasksItem.isEmpty) {
              return const Center();
            }
            if (index < state.listTaskItem!.listTasksItem.length) {
              TaskData model = state.listTaskItem!.listTasksItem[index];
              return TaskListItemWidget(
                model,
                onTapRowName: () {
                  PrefUtils().setCurrentTaskId(model.id!);
                  onTapToTaskDetailDialog(context);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _buildOptionButton(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: OptionProjectDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapBtnback(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: HomeScreen.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapToCreateTaskDialog(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: CreateNewTaskDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapToFilterDialog(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: FilterTaskDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }

  onTapToTaskDetailDialog(BuildContext context) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
              content: TaskDetailDialog.builder(
                  NavigatorService.navigatorKey.currentContext!),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
            ));
  }
}
