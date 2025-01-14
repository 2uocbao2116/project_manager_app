import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/utils/image_constant.dart';

// ignore: must_be_immutable
class ImagelistItemModel extends Equatable {
  ImagelistItemModel({this.frame, this.id}) {
    frame = frame ?? ImageConstant.imgFrame29;

    id = id ?? "";
  }

  String? frame;

  String? id;

  ImagelistItemModel copyWith({
    String? frame,
    String? id,
  }) {
    return ImagelistItemModel(
      frame: frame ?? this.frame,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [frame, id];
}
