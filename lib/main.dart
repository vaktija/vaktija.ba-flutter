import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/home/home_screen.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

import 'init_screen/init_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await NotificationService().requestIOSPermissions();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const VaktijaApp());
}

class VaktijaApp extends StatelessWidget {
  const VaktijaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VaktijaDateTimeProvider()),
        ChangeNotifierProvider(create: (_) => CalendarPickerStateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: InitScreen(),
      ),
    );
  }
}
