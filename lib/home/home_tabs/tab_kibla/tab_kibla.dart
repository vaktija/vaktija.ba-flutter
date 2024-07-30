import 'package:flutter/material.dart';
import 'package:flutter_compass_v2/flutter_compass_v2.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/function/show_full_screen.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla/tab_kibla_calibration_guide.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla/tab_kibla_compass.dart';

class HomeTabKibla extends StatefulWidget {
  const HomeTabKibla({super.key});

  @override
  State<HomeTabKibla> createState() => _HomeTabKiblaState();
}

class _HomeTabKiblaState extends State<HomeTabKibla> {
  //final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double calibrationMinimumLvl = 3.0;
    return Scaffold(
      appBar: AppBar(
        title: const TextBodyMedium(
          text: 'Kibla kompas',
          bold: true,
        ),
        centerTitle: true,
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              showFullscreen(
                  context: context,
                  child: const TabKiblaCalibrationGuide(),
                  dismissible: false);
            },
            icon: const Icon(
              Icons.help_outline_outlined,
            ),
          )
        ],
      ),
      body:
      StreamBuilder<CompassEvent>(
            stream: FlutterCompass.events,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ScreenLoader();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data?.heading == null) {
                return _NoSupport();
              }

              CompassEvent? compassEvent = snapshot.data;
              double? heading = compassEvent?.heading;
              double accuracy = compassEvent?.accuracy ?? 0.0;

              print('preciznost $accuracy');
              if (accuracy >= calibrationMinimumLvl) {
                return const HomeTabKiblaCompass();
              }

              return _LowAccuracy(
                current: accuracy,
                needed: calibrationMinimumLvl,
              );
            })

        //   FutureBuilder(
          //   future: _deviceSupport,
          //   builder: (_, AsyncSnapshot<bool?> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const ScreenLoader();
          //     }
          //     if (snapshot.hasError) {
          //       return Center(
          //         child: Text("Greska: ${snapshot.error.toString()}"),
          //       );
          //     }
          //     if (snapshot.data!) {
          //       return const HomeTabKiblaCompass();
          //     } else {
          //       return const _NoSupport(); //QiblahMaps();
          //     }
          //   },
          // ),
    );
  }
}

class _LowAccuracy extends StatelessWidget {
  final double current;
  final double needed;

  const _LowAccuracy({super.key, required this.current, required this.needed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defPadding * 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gap32,
          gap32,
          gap32,
          gap32,
          Icon(
            Icons.compass_calibration_outlined,
            size: defPadding * 3,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
          ),
          gap16,
          const TextBodyMedium(
            text:
                'Preciznost kompasa nije zadovoljavajuća!\n'
                    'Molimo dodatno kalibrirajte uređaj kao u uputstvu\n'
                    '(tipka u gornjem desnom uglu).',
            textAlign: TextAlign.center,
          ),
          Spacer(),
          const TextBodyMedium(
            text: 'Nivo kalibracije:',
            textAlign: TextAlign.start,
          ),
          gap16,
          Row(
            children: [
              const TextBodyMedium(
                text: 'Potrebno:',
                textAlign: TextAlign.start,
              ),
              gap8,
              TextBodyMedium(
                text: needed.toString(),
                bold: true,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          gap8,
          Row(
            children: [
              const TextBodyMedium(
                text: 'Trenutno:',
                textAlign: TextAlign.start,
              ),
              gap8,
              TextBodyMedium(
                text: current.toString(),
                bold: true,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          gap32,
          gap32,
        ],
      ),
    );
  }
}

class _NoSupport extends StatelessWidget {
  const _NoSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defPadding * 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            size: defPadding * 3,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
          ),
          gap16,
          const TextBodyMedium(
            text: 'Žao nam je!\NVaš uređaj ne podržava ovu uslugu.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// class _CompassAccuracyCheck extends StatefulWidget {
//   final Widget child;
//
//   const _CompassAccuracyCheck({
//     super.key,
//     required this.child,
//   });
//
//   @override
//   State<_CompassAccuracyCheck> createState() => _CompassAccuracyCheckState();
// }
//
// class _CompassAccuracyCheckState extends State<_CompassAccuracyCheck> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<CompassEvent>(
//         stream: FlutterCompass.events,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const ScreenLoader();
//           }
//         });
//   }
// }
