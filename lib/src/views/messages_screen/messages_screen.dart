import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/api/api.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/logger.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/messages_screen/bloc/messages_bloc.dart';
import 'package:projectmanager/src/views/messages_screen/bloc/messages_event.dart';
import 'package:projectmanager/src/views/messages_screen/bloc/messages_state.dart';
import 'package:projectmanager/src/views/messages_screen/models/imagelist_item_model.dart';
import 'package:projectmanager/src/views/messages_screen/models/messages_model.dart';
import 'package:projectmanager/src/views/messages_screen/models/userlist_item_model.dart';
import 'package:projectmanager/src/views/messages_screen/widgets/imagelist_item_widget.dart';
import 'package:projectmanager/src/views/messages_screen/widgets/userlist_item_widget.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MessagesBloc>(
      create: (context) => MessagesBloc(MessagesState(
        messagesModelObj: MessagesModel(),
      ))
        ..add(MessagesInitialEvent()),
      child: const MessagesScreen(),
    );
  }

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<MessagesBloc>().add(FetchMessagesEvent());
    }
  }

  bool get _isBottom {
    if (context.read<MessagesBloc>().state.hasMore) {
      return false;
    }
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
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
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildImageList(context),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    _buildUserList(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_messages".tr),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchUser(),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildImageList(BuildContext context) {
    return BlocSelector<MessagesBloc, MessagesState, MessagesModel?>(
      selector: (state) => state.messagesModelObj,
      builder: (context, messagesModelObj) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10.h,
            children: List.generate(
                messagesModelObj?.imagelistItemList.length ?? 0, (index) {
              ImagelistItemModel model =
                  messagesModelObj?.imagelistItemList[index] ??
                      ImagelistItemModel();
              return ImagelistItemWidget(
                model,
                onTapImgFrame: () {
                  onTapImgFrame(context);
                },
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildUserList(BuildContext context) {
    return BlocSelector<MessagesBloc, MessagesState, MessagesModel?>(
      selector: (state) => state.messagesModelObj,
      builder: (context, messagesModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: messagesModelObj?.userlistItemList.length ?? 0,
          itemBuilder: (context, index) {
            UserlistItemModel model =
                messagesModelObj?.userlistItemList[index] ??
                    UserlistItemModel();
            return UserlistItemWidget(model, onTapRowName: () {
              PrefUtils().setGroupId(model.id!);
              PrefUtils().setGroupName(model.name!);
              onTapRowName(context);
            });
          },
        );
      },
    );
  }

  onTapImgFrame(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.messageScreen,
    );
  }

  onTapRowName(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.messageScreen,
    );
  }
}

class SearchUser extends SearchDelegate<UserData> {
  final Dio dio = Dio();

  final WebSocketService webSocketService = WebSocketService();

  void _sendRequest(String receiver) {
    var message = <String, String>{
      'sender': PrefUtils().getUser()!.id!,
      'receiver': receiver,
      'type': 'FRIEND',
    };
    webSocketService.sendMessage('/app/notifi', message);
  }

  Future<List<UserData>> _fetchSearchResults(String query) async {
    try {
      final response = await dio.get(
        '${Api().url}/users/${PrefUtils().getUser()!.id!}/search',
        queryParameters: <String, dynamic>{'search': query},
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer ${PrefUtils().getUser()!.token!}',
        }),
      );
      List<UserData> userData =
          ResponseListData.fromJson(response.data, UserData.fromJson).data!;
      return userData;
    } catch (e) {
      return [];
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) Logger.log('Search error: ${snapshot.error}');

        if (snapshot.hasData) {
          final searchResults = snapshot.data as List<UserData>;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.h),
                          child: Text(searchResults[index].firstName!),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.h),
                          child: Text(searchResults[index].email!),
                        ),
                      ],
                    ),
                    CustomIconButton(
                      decoration: IconButtonStyleHelper.none,
                      onTap: () {
                        _sendRequest(searchResults[index].id!);
                      },
                      child: CustomImageView(
                        imagePath: ImageConstant.imgAddCircleBut,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) print('Search error: ${snapshot.error}');

        if (snapshot.hasData) {
          final suggestionList = snapshot.data as List<UserData>;
          return ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.h),
                          child: Text(suggestionList[index].firstName!),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.h),
                          child: Text(suggestionList[index].email!),
                        ),
                      ],
                    ),
                    CustomIconButton(
                      decoration: IconButtonStyleHelper.none,
                      onTap: () {
                        _sendRequest(suggestionList[index].id!);
                      },
                      child: CustomImageView(
                        imagePath: ImageConstant.imgAddCircleBut,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
