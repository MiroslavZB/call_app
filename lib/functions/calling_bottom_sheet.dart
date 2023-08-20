import 'package:call_app/components/calling/calling_backspace_button.dart';
import 'package:call_app/components/calling/calling_call_button.dart';
import 'package:call_app/components/calling/calling_number_button_widget.dart';
import 'package:call_app/resources/constants.dart';
import 'package:call_app/router/paths.dart';

void showNumbersField(BuildContext context, TextEditingController callController) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: lightAccentColor,
          boxShadow: [
            BoxShadow(
              color: darkAccentColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: callController,
                readOnly: true,
                style: styleH1,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IgnorePointer(
                    child: Opacity(
                      opacity: 0,
                      child: backspaceButton(callController),
                    ),
                  ),
                  suffixIcon: backspaceButton(callController),
                ),
              ),
            ),
            ...List.generate(
              4,
              (i) => Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                child: Row(
                  children: List.generate(
                    3,
                    (j) => numberButton(
                      i * 3 + j + 1, // this is a formula for getting all of the numbers from 1 to 9
                      callController,
                    ),
                  ),
                ),
              ),
            ),
            callingCallButton(context, callController),
          ],
        ),
      );
    },
  );
}
