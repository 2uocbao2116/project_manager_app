import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/views/contact_screen/models/contact_item.dart';

// ignore: must_be_immutable
class ContactListItem extends Equatable {
  ContactListItem({this.contactItem = const []});

  List<ContactItem> contactItem;

  ContactListItem copyWith({List<ContactItem>? contactItem}) {
    return ContactListItem(
      contactItem: contactItem ?? this.contactItem,
    );
  }

  @override
  List<Object?> get props => [contactItem];
}
