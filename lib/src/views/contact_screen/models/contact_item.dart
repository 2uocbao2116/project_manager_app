import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ContactItem extends Equatable {
  ContactItem({this.name, this.phoneNumber, this.id});

  String? name;
  String? phoneNumber;
  String? id;

  ContactItem copyWith({
    String? name,
    String? phoneNumber,
    String? id,
  }) {
    return ContactItem(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [name, phoneNumber, id];
}
