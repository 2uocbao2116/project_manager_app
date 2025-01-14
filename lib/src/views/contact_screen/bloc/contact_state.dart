import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_list_item.dart';

// ignore: must_be_immutable
class ContactState extends Equatable {
  ContactState({this.contactModelObj});

  ContactListItem? contactModelObj;

  @override
  List<Object?> get props => [contactModelObj];
  ContactState copyWith({ContactListItem? contactModelObj}) {
    return ContactState(
      contactModelObj: contactModelObj ?? this.contactModelObj,
    );
  }
}
