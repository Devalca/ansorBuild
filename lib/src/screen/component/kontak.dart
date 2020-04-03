import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: _contacts != null
          ? _listKontak()
          : Center(child: const CircularProgressIndicator()),
    );
  }

  Widget _listKontak() {
    return ListView.builder(
      itemCount: _contacts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = _contacts?.elementAt(index);
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                print(contact.phones);
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar),
                    )
                  : CircleAvatar(
                      child: Text(contact.initials()),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
              title: Text(contact.displayName ?? ''),
            ),
            ItemsTile(contact.phones)
          ],
        );
      },
    );
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._items);
  final Iterable<Item> _items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: _items
              .map(
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    onTap: () {
                      String noValue = i.value;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPulsa(noValue)));
                    },
                    title: Text(i.label + "   " + i.value ?? ""),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
