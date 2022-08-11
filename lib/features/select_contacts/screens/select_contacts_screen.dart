import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select_contacts/controllers/select_contacts_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select_contacts';
  const SelectContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(data: (contactList) {
        return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (BuildContext context, int index) {
              final Contact contact = contactList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    ref.read(selectContactControllerProvider).selectContact(
                          context,
                          contact,
                        );
                  },
                  child: ListTile(
                    title: Text(
                      contact.displayName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading: contact.photo == null
                        ? null
                        : CircleAvatar(
                            backgroundImage: MemoryImage(contact.photo!),
                            radius: 30,
                          ),
                  ),
                ),
              );
            });
      }, error: (err, trace) {
        return ErrorScreen(error: err.toString());
      }, loading: () {
        return const LoaderScreen();
      }),
    );
  }
}
