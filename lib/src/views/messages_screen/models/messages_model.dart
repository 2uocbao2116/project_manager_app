import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/messages_screen/models/imagelist_item_model.dart';
import 'package:projectmanager/src/views/messages_screen/models/userlist_item_model.dart';

// ignore: must_be_immutable
class MessagesModel extends Equatable {
  MessagesModel(
      {this.imagelistItemList = const [], this.userlistItemList = const []});

  List<ImagelistItemModel> imagelistItemList;

  List<UserlistItemModel> userlistItemList;

  MessagesModel copyWith({
    List<ImagelistItemModel>? imagelistItemList,
    List<UserlistItemModel>? userlistItemList,
  }) {
    return MessagesModel(
      imagelistItemList: imagelistItemList ?? this.imagelistItemList,
      userlistItemList: userlistItemList ?? this.userlistItemList,
    );
  }

  @override
  List<Object?> get props => [imagelistItemList, userlistItemList];
}
