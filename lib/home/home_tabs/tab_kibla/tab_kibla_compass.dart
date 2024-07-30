import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/show_full_screen.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla/tab_kibla_calibration_guide.dart';
import 'package:geolocator/geolocator.dart';

class HomeTabKiblaCompass extends StatefulWidget {
  const HomeTabKiblaCompass({Key? key}) : super(key: key);

  @override
  _HomeTabKiblaCompassState createState() => _HomeTabKiblaCompassState();
}

class _HomeTabKiblaCompassState extends State<HomeTabKiblaCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
    showCalibrationGuide();
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  showCalibrationGuide() {
    Future.delayed(const Duration(milliseconds: 100), () {
      showFullscreen(
          context: context,
          child: const TabKiblaCalibrationGuide(),
          dismissible: false);
    });
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool isDarkModeOn = isDarkMode(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/kibla_compass_marker_light.png',
          height: screenSize.width * 0.1,
          color: Theme.of(context).indicatorColor,
        ),
        gap24,
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: screenSize.width * 0.7,
            width: screenSize.width * 0.7,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/kibla_compass_bg_light.png',
                    width: screenSize.width * 0.7,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
                Center(
                  child: StreamBuilder(
                    stream: FlutterQiblah.qiblahStream,
                    builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ScreenLoader();
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error.toString()}"),
                        );
                      }
                      final qiblahDirection = snapshot.data;

                      //print('podaci ${snapshot.data}');
                      return Center(
                          child: Transform.rotate(
                        angle: ((qiblahDirection!.qiblah) * (pi / 180) * -1),
                        alignment: Alignment.center,
                        child: Center(
                            child: Container(
                          height: screenSize.width * 0.56,
                          width: screenSize.width * 0.56,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                                isDarkModeOn
                                    ? 'assets/icons/kibla_needle_dark.png'
                                    : 'assets/icons/kibla_needle_light.png',
                                height: screenSize.width * 0.31),
                          ),
                        )),
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
