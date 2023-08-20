import 'package:call_app/components/new_contact/field_card.dart';
import 'package:call_app/state/shared_bool_state.dart';
import 'package:flutter/material.dart';

Widget primaryFields() {
  return BlocProvider(
    create: (_) => SharedBoolState(),
    child: BlocBuilder<SharedBoolState, bool>(
      builder: (context, moreNameFieldsState) => Column(
        children: [
          if (moreNameFieldsState) sharedField(hint: 'Name prefix'),
          sharedField(
            leading: Icons.person_outline_rounded,
            hint: 'First name',
            showArrowDown: true,
            context: context,
            state: moreNameFieldsState,
          ),
          if (moreNameFieldsState) sharedField(hint: 'Middle name'),
          sharedField(hint: 'Last name'),
          if (moreNameFieldsState) sharedField(hint: 'Name suffix'),
        ],
      ),
    ),
  );
}
