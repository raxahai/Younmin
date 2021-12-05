import 'package:flutter/material.dart';

import '../colors.dart';

final textButtonStyle = ButtonStyle(
  overlayColor: MaterialStateProperty.all<Color>(
    YounminColors.black28,
  ),
  splashFactory: NoSplash.splashFactory,
);

final elevatedButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  backgroundColor:
      MaterialStateProperty.all<Color>(YounminColors.primaryButtonColor),
  minimumSize: MaterialStateProperty.all<Size>(Size(
    250,
    60,
  )),
);
