import 'package:flutter/material.dart';
import 'package:projectmanager/src/data/api/websocket_service.dart';
import 'package:projectmanager/src/utils/image_constant.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: constant_identifier_names
enum BottomBarEnum { Home, Messages, Profile }

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  final webSocket = WebSocketService();

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHomeGrey,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLinkedin,
      activeIcon: ImageConstant.messagesGray,
      type: BottomBarEnum.Messages,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUserCircleSin,
      activeIcon: ImageConstant.imgUserCircleSinGrey,
      type: BottomBarEnum.Profile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          bool isMessages =
              bottomMenuList[index].type == BottomBarEnum.Messages;
          bool isSelected = selectedIndex == index;
          return BottomNavigationBarItem(
            icon: isMessages
                ? Stack(
                    children: [
                      CustomImageView(
                        imagePath: isSelected
                            ? bottomMenuList[index].activeIcon
                            : bottomMenuList[index].icon,
                        height: 20.h,
                        width: 20.h,
                      ),
                      if (webSocket.haveNewMessage >
                          0) // Show badge only if notifications exist
                        Positioned(
                          top: -3.7.h,
                          right: -0.5.h,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 5,
                              minHeight: 5,
                            ),
                            child: Text(
                              webSocket.haveNewMessage > 99
                                  ? '99'
                                  : '${webSocket.haveNewMessage}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  )
                : CustomImageView(
                    imagePath: isSelected
                        ? bottomMenuList[index].activeIcon
                        : bottomMenuList[index].icon,
                    height: 20.h,
                    width: 20.h,
                  ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {
            if (bottomMenuList[index].type == BottomBarEnum.Messages) {
              webSocket.haveNewMessage = 0;
            }
          });
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });
  String icon;
  String activeIcon;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
