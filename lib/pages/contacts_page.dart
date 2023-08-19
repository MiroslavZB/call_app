import 'package:call_app/components/contact_card.dart';
import 'package:call_app/components/create_new_contact_widget.dart';
import 'package:call_app/components/empty_view_text.dart';
import 'package:call_app/functions/fieldsMatchFilters.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:call_app/state/search_filters_state.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onPressed: () {
          // TODO
        },
        child: const Icon(Icons.dialpad_outlined, size: regularIconSize),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          createNewContactWidget(context),
          BlocBuilder<FiltersBloc, Filters>(builder: (context, state) {
            return Expanded(
              child: StreamBuilder<List<Contact>>(
                  stream: objectBox.getContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Contact> listContacts = state.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where((e) => fieldsMatchFilters(
                                    name: e.name,
                                    phone: e.phone,
                                    filters: state,
                                  ))
                              .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: listContacts.length,
                        itemBuilder: (context, index) => contactCard(
                            context,
                            contact: listContacts[index],
                            phoneFilter: state.phone,
                            nameFilter: state.name,
                            currentIniital:
                                listContacts[index].name.isEmpty ? '' : listContacts[index].name.substring(0, 1),
                            previousInitial: index < 1 || listContacts[index - 1].name.isEmpty
                                ? ''
                                : listContacts[index - 1].name.substring(0, 1),
                          ),
                      );
                    }
                    return emptyViewText('No Contacts yet!');
                  }),
            );
          }),
        ],
      ),
    );
  }
}
