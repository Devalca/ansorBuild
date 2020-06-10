import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          "Kontak",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true
                    ? contactsFiltered.length
                    : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true
                      ? contactsFiltered[index]
                      : contacts[index];
                  return ListTile(
                      title: Text(contact.displayName),
                      onTap: () {
                        String noValue = contact.phones.elementAt(0).value;
                        Navigator.pop(context, noValue);
                      },
                      subtitle: contact.phones.isEmpty
                          ? Text("Nomor tidak tersedia",
                              style: TextStyle(color: Colors.red))
                          : Text(contact.phones.elementAt(0).value),
                      leading:
                          (contact.avatar != null && contact.avatar.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar),
                                )
                              : CircleAvatar(child: Text(contact.initials())));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactsPage2 extends StatefulWidget {
  @override
  _ContactsPage2State createState() => _ContactsPage2State();
}

class _ContactsPage2State extends State<ContactsPage2> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          "Kontak",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true
                    ? contactsFiltered.length
                    : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true
                      ? contactsFiltered[index]
                      : contacts[index];
                  return ListTile(
                      title: Text(contact.displayName),
                      onTap: () {
                        String noValue2 = contact.phones.elementAt(0).value;
                        Navigator.pop(context, noValue2);
                      },
                      subtitle: contact.phones.isEmpty
                          ? Text("Nomor tidak tersedia",
                              style: TextStyle(color: Colors.red))
                          : Text(contact.phones.elementAt(0).value),
                      leading:
                          (contact.avatar != null && contact.avatar.length > 0)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar),
                                )
                              : CircleAvatar(child: Text(contact.initials())));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ContactsPage extends StatefulWidget {

//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   Iterable<Contact> _contacts;

//   @override
//   void initState() {
//     getContacts();
//     super.initState();
//   }

//   Future<void> getContacts() async {
//     final Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
//     setState(() {
//       _contacts = contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1,
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pop(context, true);
//             }),
//         backgroundColor: Colors.white,
//         title: Text(
//           "Kontak",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: _contacts != null
//           ? _listKontak()
//           : Center(child: const CircularProgressIndicator()),
//     );
//   }

//   Widget _listKontak() {
//     return ListView.builder(
//       itemCount: _contacts?.length ?? 0,
//       itemBuilder: (BuildContext context, int index) {
//         Contact contact = _contacts?.elementAt(index);
//         return Column(
//           children: <Widget>[
//             ListTile(
//               onTap: () {
//                 print(contact.phones);
//               },
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
//               leading: (contact.avatar != null && contact.avatar.isNotEmpty)
//                   ? CircleAvatar(
//                       backgroundImage: MemoryImage(contact.avatar),
//                     )
//                   : CircleAvatar(
//                       child: Text(contact.initials()),
//                       backgroundColor: Theme.of(context).accentColor,
//                     ),
//               title: Text(contact.displayName ?? ''),
//             ),
//             ItemsTile(contact.phones)
//           ],
//         );
//       },
//     );
//   }
// }

// class ItemsTile extends StatelessWidget {
//   ItemsTile(this._items);
//   final Iterable<Item> _items;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Column(
//           children: _items
//               .map(
//                 (i) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ListTile(
//                     onTap: () {
//                       String noValue = i.value;
//                       String noValue2;
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MainPulsa(noValue, noValue2)));
//                     },
//                     title: Text(i.label + "   " + i.value ?? ""),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class ContactsPage2 extends StatefulWidget {

//   @override
//   _ContactsPage2State createState() => _ContactsPage2State();
// }

// class _ContactsPage2State extends State<ContactsPage2> {
//   Iterable<Contact> _contacts;

//   @override
//   void initState() {
//     getContacts();
//     super.initState();
//   }

//   Future<void> getContacts() async {
//     final Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
//     setState(() {
//       _contacts = contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1,
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pop(context, true);
//             }),
//         backgroundColor: Colors.white,
//         title: Text(
//           "Kontak",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: _contacts != null
//           ? _listKontak2()
//           : Center(child: const CircularProgressIndicator()),
//     );
//   }

//   Widget _listKontak2() {
//     return ListView.builder(
//       itemCount: _contacts?.length ?? 0,
//       itemBuilder: (BuildContext context, int index) {
//         Contact contact = _contacts?.elementAt(index);
//         return Column(
//           children: <Widget>[
//             ListTile(
//               onTap: () {
//                 print(contact.phones);
//               },
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
//               leading: (contact.avatar != null && contact.avatar.isNotEmpty)
//                   ? CircleAvatar(
//                       backgroundImage: MemoryImage(contact.avatar),
//                     )
//                   : CircleAvatar(
//                       child: Text(contact.initials()),
//                       backgroundColor: Theme.of(context).accentColor,
//                     ),
//               title: Text(contact.displayName ?? ''),
//             ),
//             ItemsTile2(contact.phones)
//           ],
//         );
//       },
//     );
//   }
// }

// class ItemsTile2 extends StatelessWidget {
//   ItemsTile2(this._items);
//   final Iterable<Item> _items;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Column(
//           children: _items
//               .map(
//                 (i) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ListTile(
//                     onTap: () {
//                       String noValue2 = i.value;
//                       String noValue;
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MainPulsa(noValue, noValue2)));
//                     },
//                     title: Text(i.label + "   " + i.value ?? ""),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }
// }
