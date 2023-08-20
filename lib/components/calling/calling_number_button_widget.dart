import 'package:call_app/resources/constants.dart';
import 'package:flutter/material.dart';

Widget numberButton(int num, TextEditingController callController) {
  String text = '';
  if (num >= 0 && num <= 9) {
    text = num.toString();
  } else if (num == 10) {
    text = '*';
  } else if (num == 11) {
    text = '0';
  } else if (num == 12) {
    text = '#';
  }
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => callController.text = callController.text + text,
      onLongPress: text == '0' ? () => callController.text = '${callController.text}+' : null,
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: styleH1.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            if (text == '0')
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text('+', style: styleH4),
              )
          ],
        ),
      ),
    ),
  );
}
