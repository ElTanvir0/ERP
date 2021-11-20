import 'package:contacts_service/contacts_service.dart';

class Contact {
// Name
  String displayName, givenName, middleName, prefix, suffix, familyName;

// // Company  String company, jobTitle;

  //Email addresses
  List<Item> emails = [];

// Phone numbers
  List<Item> phones = [];

// // Post addresses
  List<PostalAddress> postalAddresses = [];

// // Contact avatar/thumbnail
//  Uint8List avatar;

  Contact({
    required this.displayName,
    required this.givenName,
    required this.middleName,
    required this.prefix,
    required this.suffix,
    required this.familyName,
    required this.emails,
    required this.phones,
  });
}
