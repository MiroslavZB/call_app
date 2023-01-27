import 'package:call_app/contact.dart';
import 'package:call_app/objectbox.g.dart';

/// Provides access to the ObjectBox Store throughout the app.
class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<Contact> contactsBox;

  ObjectBox._create(this.store) {
    contactsBox = Box<Contact>(store);

    //  _putDemoData();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  // void _putDemoData() {
  //   final demoNotes = [
  //     Contact('Quickly add a note by writing text and pressing Enter'),
  //     Contact('Delete notes by tapping on one'),
  //     Contact('Write a demo app for ObjectBox')
  //   ];
  //   store.runInTransactionAsync(TxMode.write, _putNotesInTx, demoNotes);
  // }

  Stream<List<Contact>> getContacts() {
    // Query for all notes, sorted by their date.
    // https://docs.objectbox.io/queries
    final builder = contactsBox.query().order(Contact_.date, flags: Order.descending);
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return builder
        .watch(triggerImmediately: true)
        // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  static void _putContactsInTx(Store store, List<Contact> contacts) => store.box<Contact>().putMany(contacts);

  /// Add a note within a transaction.
  ///
  /// To avoid frame drops, run ObjectBox operations that take longer than a
  /// few milliseconds, e.g. putting many objects, in an isolate with its
  /// own Store instance.
  /// For this example only a single object is put which would also be fine if
  /// done here directly.
  Future<void> addContact(Contact contact) => store.runInTransactionAsync(TxMode.write, _addContactInTx, contact);

  /// Note: due to [dart-lang/sdk#36983](https://github.com/dart-lang/sdk/issues/36983)
  /// not using a closure as it may capture more objects than expected.
  /// These might not be send-able to an isolate. See Store.runAsync for details.
  static void _addContactInTx(Store store, Contact contact) {
    // Perform ObjectBox operations that take longer than a few milliseconds
    // here. To keep it simple, this example just puts a single object.
    store.box<Contact>().put(contact);
  }
}
