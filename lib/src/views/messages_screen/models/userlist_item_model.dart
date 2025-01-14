import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserlistItemModel extends Equatable {
  UserlistItemModel({this.name, this.message, this.time, this.id});

  String? name;

  String? message;

  String? time;

  String? id;

  UserlistItemModel copyWith({
    String? name,
    String? message,
    String? time,
    String? id,
  }) {
    return UserlistItemModel(
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [name, message, time, id];
}
