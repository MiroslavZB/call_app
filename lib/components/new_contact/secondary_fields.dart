import 'package:call_app/components/new_contact/field_card.dart';
import 'package:call_app/components/new_contact/more_fields_button.dart';
import 'package:call_app/state/shared_bool_state.dart';
import 'package:flutter/material.dart';

Widget secondaryFields() {
  return BlocProvider(
    create: (_) => SharedBoolState(),
    child: BlocBuilder<SharedBoolState, bool>(
      builder: (context, moreFieldsState) => Column(
        children: [
          if (moreFieldsState) ...[
            sharedField(hint: 'Phonetic last name'),
            sharedField(hint: 'Phonetic middle name'),
            sharedField(hint: 'Phonetic first name'),
            sharedField(hint: 'Nickname'),
            sharedField(hint: 'File as'),
          ],
          sharedField(leading: Icons.factory_outlined, hint: 'Company'),
          if (moreFieldsState) ...[
            sharedField(hint: 'Department'),
            sharedField(hint: 'Title'),
          ],
          sharedField(leading: Icons.phone_outlined, hint: 'Phone'),
          // unfinished label
          sharedField(leading: Icons.email_outlined, hint: 'Email'),
          // unfinished email label
          if (moreFieldsState) ...[
            sharedField(hint: 'Address'),
            // unfinished address label
            sharedField(hint: 'Website'),
          ],
          // unfinished significant date
          // unfinished birthday
          if (moreFieldsState) ...[
            sharedField(hint: 'SIP'),
            // unfinished relationship
            sharedField(hint: 'Notes'),
            // unfinished label
          ],
          moreFieldsButton(context, moreFieldsState),
        ],
      ),
    ),
  );
}
