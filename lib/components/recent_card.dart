import 'package:call_app/components/contact_image.dart';
import 'package:call_app/components/icon_button_widget.dart';
import 'package:call_app/main.dart';
import 'package:call_app/models/contact.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';
import 'package:call_app/state/shared_bool_state.dart';

Widget recentCard(
  BuildContext context, {
  required Contact? contact,
  required DateTime occurrence,
  required String phone,
  required int flag,
  required int id,
}) {
  return BlocProvider(
    create: (_) => SharedBoolState(),
    child: BlocBuilder<SharedBoolState, bool>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          onTap: () => BlocProvider.of<SharedBoolState>(context).flip(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mediumBorderRadius),
              color: state ? lightAccentColor.withOpacity(0.1) : Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                          Paths.contactInfo,
                          queryParams: {'phone': phone, 'id': id.toString()},
                          extra: contact,
                        );
                      },
                      child: contactImage(
                        name: contact?.name,
                        fillColorHex: contact?.hexColor,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact == null ? phone : contact.name,
                              style: styleH3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  flag == 0
                                      ? Icons.call_missed
                                      : flag == 1
                                          ? Icons.call_made
                                          : Icons.call_received,
                                ),
                                Text(
                                  worldTime.format(dateTime: occurrence, formatter: formatter),
                                ),
                              ],
                            ),
                            Text(countriesFromPhoneCountryCode[phone.substring(0, 2)] ??
                                countriesFromPhoneCountryCode[phone.substring(0, 3)] ??
                                'Unknown'),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: phone.length < 3
                          ? null
                          : () async {
                              await objectBox.addRecent(
                                contact: contact,
                                phone: phone,
                                occurrence: DateTime.now(),
                                state: 1,
                              );
                            },
                      icon: const Icon(
                        Icons.call_outlined,
                        size: regularIconSize,
                      ),
                    ),
                  ],
                ),
                if (state) ...[
                  const Divider(height: 20),
                  Opacity(
                    opacity: 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        iconButtonWidget(
                            icon: Icons.videocam_outlined,
                            text: 'Video',
                            onPressed: () {
                              // unfinished
                            }),
                        iconButtonWidget(
                            icon: Icons.message_outlined,
                            text: 'Text',
                            onPressed: () {
                              // unfinished
                            }),
                        iconButtonWidget(
                            icon: Icons.history,
                            text: 'History',
                            onPressed: () {
                              // unfinished
                            }),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
