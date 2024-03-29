import 'dart:convert';

import 'package:call_app/models/contact.dart';
import 'package:call_app/models/recent_contact.dart';
// run $ dart run build_runner build -d
import 'package:call_app/objectbox.g.dart';
import 'package:flutter/services.dart';

/// Provides access to the ObjectBox Store throughout the app.
class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of Contacts.
  late final Box<Contact> contactsBox;
  late final Box<RecentContact> recentsBox;

  ObjectBox._create(this.store) {
    contactsBox = Box<Contact>(store);
    recentsBox = Box<RecentContact>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  Stream<List<Contact>> getContacts() {
    // Query for all Contacts, sorted by their name.
    // https://docs.objectbox.io/queries
    final builder = contactsBox.query().order(Contact_.firstName);
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return builder
        .watch(triggerImmediately: true)
        // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Stream<List<RecentContact>> getRecents() {
    final builder = recentsBox.query().order(
          RecentContact_.occurrenceDate,
          flags: Order.descending,
        );
    return builder
        .watch(triggerImmediately: true)
        // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Future<void> putContact(Contact contact) => store.runInTransactionAsync(TxMode.write, _addContactInTx, contact);

  static void _addContactInTx(Store store, Contact contact) => store.box<Contact>().put(contact);

  static void _addRecentContactInTx(Store store, RecentContact recentContact) =>
      store.box<RecentContact>().put(recentContact);

  Future<void> addRecent({
    required Contact? contact,
    required DateTime occurrence,
    required String phone,
    required int state,
  }) async {
    final RecentContact recentContact = RecentContact(
      status: state,
      phone: phone,
      occurrenceDate: occurrence,
    );

    recentContact.contact.target = contact;

    store.runInTransactionAsync(TxMode.write, _addRecentContactInTx, recentContact);
  }

  Future<void> putRecent(RecentContact recentContact) =>
      store.runInTransactionAsync(TxMode.write, _addRecentContactInTx, recentContact);

  Future<void> addStartingContacts() async {
    // for clearing all of the contacts
    // for (var e in contactsBox.getAll()) {
    //   contactsBox.remove(e.id);
    // }

    if (contactsBox.getAll().isNotEmpty) return;
    final String response = await rootBundle.loadString('assets/contacts.json');
    final data = await json.decode(response);
    if (data is! List) return;

    for (Map<String, dynamic> e in data) {
      final Contact? contact = Contact.fromJson(e);
      if (contact == null) return;
      putContact(contact);
    }
  }
}
