import 'package:flutter/material.dart';
import 'package:projectmanager/src/utils/size_utils.dart';
import 'package:projectmanager/src/views/messages_screen/models/imagelist_item_model.dart';
import 'package:projectmanager/src/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class ImagelistItemWidget extends StatelessWidget {
  ImagelistItemWidget(this.imagelistItemModelObj,
      {super.key, this.onTapImgFrame});

  ImagelistItemModel imagelistItemModelObj;

  VoidCallback? onTapImgFrame;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.h,
      child: CustomImageView(
        height: 40.h,
        width: 40.h,
        imagePath: imagelistItemModelObj.frame!,
        onTap: () {
          onTapImgFrame?.call();
        },
      ),
    );
  }
}
