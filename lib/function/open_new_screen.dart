

import 'package:flutter/material.dart';

void openNewScreen(context, page, screenName) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: screenName)
  ));
}
