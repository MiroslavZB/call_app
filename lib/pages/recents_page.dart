import 'package:call_app/components/empty_view_text.dart';
import 'package:call_app/components/recent_card.dart';
import 'package:call_app/functions/fields_match_filters.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/recent_contact.dart';
import 'package:call_app/state/search_filters_state.dart';
import 'package:flutter/material.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BlocBuilder<FiltersBloc, Filters>(builder: (context, state) {
            return Expanded(
              child: StreamBuilder<List<RecentContact>>(
                  stream: objectBox.getRecents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final List<RecentContact> recentsList = snapshot.data!
                          .where((e) => fieldsMatchFilters(
                                name: e.contact.target?.name,
                                phone: e.phone,
                                filters: state,
                              ))
                          .toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                        itemBuilder: (context, index) {
                          return recentCard(
                            context,
                            contact: recentsList[index].contact.target,
                            occurrence: recentsList[index].occurrenceDate,
                            id: recentsList[index].id,
                            flag: recentsList[index].status,
                            phone: recentsList[index].phone,
                          );
                        },
                      );
                    }
                    return emptyViewText('No recent calls yet!');
                  }),
            );
          }),
        ],
      ),
    );
  }
}
