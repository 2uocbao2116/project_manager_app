import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/api/api.dart';
import 'package:projectmanager/src/data/models/response_list_data.dart';
import 'package:projectmanager/src/data/models/user/user_data.dart';
import 'package:projectmanager/src/localization/app_localization.dart';
import 'package:projectmanager/src/routes/app_routes.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/logger.dart';
import 'package:projectmanager/src/utils/navigator_service.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/contact_screen/bloc/contact_bloc.dart';
import 'package:projectmanager/src/views/contact_screen/bloc/contact_event.dart';
import 'package:projectmanager/src/views/contact_screen/bloc/contact_state.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_list_item.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_item.dart';
import 'package:projectmanager/src/views/contact_screen/widgets/contactlist_item_widget.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_title.dart';
import 'package:projectmanager/src/widgets/app_bar/appbar_trailing_image.dart';
import 'package:projectmanager/src/widgets/app_bar/custom_app_bar.dart';
import 'package:projectmanager/src/widgets/custom_icon_button.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(ContactState(
        contactModelObj: ContactListItem(),
      ))
        ..add(ContactInitialEvent()),
      child: const ContactScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildContactList(context)],
        ),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leading: CustomIconButton(
        decoration: IconButtonStyleHelper.none,
        onTap: () {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.projectScreen);
        },
        child: CustomImageView(
          imagePath: ImageConstant.back,
        ),
      ),
      title: AppbarTitle(
        text: "lbl_contacts".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMagnifyingGlas,
          height: 20.h,
          width: 20.h,
          margin: EdgeInsets.only(right: 10.h),
          onTap: () {
            showSearch(
              context: context,
              delegate: SearchFriend(),
            );
          },
        )
      ],
    );
  }

  Widget _buildContactList(BuildContext context) {
    String userIdOfCurrentTask = PrefUtils().getListTasks()!.userId!;
    return Expanded(
        child: BlocSelector<ContactBloc, ContactState, ContactListItem?>(
      selector: (state) => state.contactModelObj,
      builder: (context, contactModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 6.h,
            );
          },
          itemCount: contactModelObj?.contactItem.length ?? 0,
          itemBuilder: (context, index) {
            ContactItem model =
                contactModelObj?.contactItem[index] ?? ContactItem();
            return ContactlistItemWidget(
              model,
              userIdOfCurrentTask.contains(model.id!),
              onTapRowName: () {
                onTapRowName(context, model.id!);
              },
            );
          },
        );
      },
    ));
  }

  onTapRowName(BuildContext context, String toUserId) {
    context.read<ContactBloc>().add(AssignTaskEvent(toUserId));
  }
}

class SearchFriend extends SearchDelegate<ContactItem> {
  final Dio dio = Dio();

  onTapRowName(BuildContext context, String toUserId) {
    context.read<ContactBloc>().add(AssignTaskEvent(toUserId));
  }

  Future<List<ContactItem>> _fetchSearchResults(String query) async {
    try {
      final response = await dio.get(
        '${Api().url}/users/${PrefUtils().getUser()!.id!}/find',
        queryParameters: <String, dynamic>{'search': query},
        options: Options(headers: <String, dynamic>{
          'Authorization': 'Bearer ${PrefUtils().getUser()!.token!}',
        }),
      );
      List<ContactItem> userData =
          ResponseListData.fromJson(response.data, UserData.fromJson).data!.map(
        (user) {
          return ContactItem(
            id: user.id,
            name: user.firstName! + user.lastName!,
            phoneNumber: user.phoneNumber,
          );
        },
      ).toList();
      return userData;
    } catch (e) {
      return [];
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
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
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String userIdOfCurrentTask = PrefUtils().getListTasks()!.userId!;
    return FutureBuilder(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) Logger.log('Search error: ${snapshot.error}');

        if (snapshot.hasData) {
          final searchResults = snapshot.data as List<ContactItem>;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ContactlistItemWidget(
                searchResults[index],
                userIdOfCurrentTask.contains(searchResults[index].id!),
                onTapRowName: () {
                  onTapRowName(context, searchResults[index].id!);
                },
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
    String userIdOfCurrentTask = PrefUtils().getListTasks()!.userId!;
    return FutureBuilder(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) Logger.log('Search error: ${snapshot.error}');

        if (snapshot.hasData) {
          final searchResults = snapshot.data as List<ContactItem>;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ContactlistItemWidget(
                searchResults[index],
                userIdOfCurrentTask.contains(searchResults[index].id!),
                onTapRowName: () {
                  onTapRowName(context, searchResults[index].id!);
                },
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
