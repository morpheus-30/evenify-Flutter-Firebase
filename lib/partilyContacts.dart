import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'components/contactTray.dart';

class PartilyContacts extends ChangeNotifier {
  List<ContactTray> _contactWidgets = [];
  Future<bool> addContacts(IconData iconData) async {
    List<Contact> contacts = await ContactsService.getContacts();
    for (var i in contacts) {
      _contactWidgets.add(ContactTray(
          name: i.displayName ?? '<NameNotAvailable>', icon: iconData));
    }
    return _contactWidgets == [] ? false : true;
  }

  List<ContactTray> getContactWidgets() {
    return _contactWidgets;
  }
}
