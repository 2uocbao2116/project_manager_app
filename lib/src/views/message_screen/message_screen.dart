// import 'package:auto_scroll/auto_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:projectmanager/src/theme/custom_text_style.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:scroll_to_index/scroll_to_index.dart'; // Use this one
import 'package:projectmanager/src/views/message_screen/bloc/message_bloc.dart';
import 'package:projectmanager/src/views/message_screen/bloc/message_event.dart';
import 'package:projectmanager/src/views/message_screen/bloc/message_state.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';
import 'package:projectmanager/src/widgets/custom_text_form_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MessageBloc>(
      create: (context) => MessageBloc(
        MessageState(),
      )..add(MessageInitialEvent()),
      child: const MessageScreen(),
    );
  }

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _autoScrollController = AutoScrollController();

  bool _isFetching = false;

  void _onScroll() {
    if (_isBottom && !_isFetching) {
      _isFetching = true;
      context.read<MessageBloc>().add(FetchMessageEvent());
      Future.delayed(const Duration(seconds: 1), () => _isFetching = false);
    }
  }

  bool get _isBottom {
    if (context.read<MessageBloc>().state.hasMore) return false;
    if (!_autoScrollController.hasClients) return false;
    final maxScroll = _autoScrollController.position.maxScrollExtent;
    final currentScroll = _autoScrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    _autoScrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MessageBloc>().add(FetchMessageEvent());
    return SafeArea(
        child: Scaffold(
      // backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: BlocBuilder<MessageBloc, MessageState>(
                              builder: (context, state) {
                                return Chat(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  scrollController: _autoScrollController,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  showUserNames: true,
                                  disableImageGallery: false,
                                  dateHeaderThreshold: 86400000,
                                  messages: state.messageList.reversed.toList(),
                                  user: state.chatUser,
                                  onSendPressed: (types.PartialText text) {},
                                  customBottomWidget: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(
                                        left: 15.h, bottom: 10.h, right: 15.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BlocSelector<MessageBloc, MessageState,
                                            TextEditingController?>(
                                          selector: (state) =>
                                              state.messageoneController,
                                          builder:
                                              (context, messageoneController) {
                                            return CustomTextFormField(
                                              controller: messageoneController,
                                              hintText: "lbl_text_message".tr,
                                              hintStyle: CustomTextStyles
                                                  .bodyMediumBlack900,
                                              textInputAction:
                                                  TextInputAction.done,
                                              suffix: Container(
                                                padding: EdgeInsets.all(12.h),
                                                child: CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgSave,
                                                  height: 14.h,
                                                  width: 14.h,
                                                  fit: BoxFit.cover,
                                                  onTap: () {
                                                    context
                                                        .read<MessageBloc>()
                                                        .add(
                                                          SendMessageEvent(
                                                              messageoneController!
                                                                  .text),
                                                        );
                                                    _autoScrollController.jumpTo(
                                                        _autoScrollController
                                                            .position
                                                            .maxScrollExtent);
                                                    // _autoScrollController
                                                    //     .animateTo(0,
                                                    //         duration:
                                                    //             const Duration(
                                                    //                 milliseconds:
                                                    //                     300),
                                                    //         curve:
                                                    //             Curves.easeInOut);
                                                    messageoneController
                                                        .clear();
                                                  },
                                                ),
                                              ),
                                              suffixConstraints: BoxConstraints(
                                                maxHeight: 50.h,
                                              ),
                                              fillColor: appTheme.gray700
                                                  .withOpacity(0.2),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  customStatusBuilder: (message,
                                      {required context}) {
                                    return Container();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leading: _buildBackButton(context),
      centerTitle: true,
      title: AppbarTitle(text: PrefUtils().getGroupName()),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return CustomIconButton(
      height: 40.h,
      width: 40.h,
      decoration: IconButtonStyleHelper.none,
      onTap: () {
        NavigatorService.goBack();
        context.read<MessageBloc>().add(UnsubscriberEvent());
      },
      child: CustomImageView(
        imagePath: ImageConstant.back,
      ),
    );
  }
}
