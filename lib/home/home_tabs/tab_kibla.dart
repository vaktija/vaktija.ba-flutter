import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vaktijaba_fl/components/location_error.dart';
import 'package:vaktijaba_fl/function/location_permission_checker.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla_compass.dart';


class HomeTabKibla extends StatefulWidget {
  const HomeTabKibla({super.key});

  @override
  State<HomeTabKibla> createState() => _HomeTabKiblaState();
}

class _HomeTabKiblaState extends State<HomeTabKibla> {

  final _locationStreamController =
  StreamController<LocationStatusPermission>.broadcast();
  get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await LocationPermissionChecker.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await LocationPermissionChecker.requestPermissions();
      final s = await LocationPermissionChecker.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextBodyMedium(
            text: 'Kibla kompas',
            bold: true,
          ),
          centerTitle: true,
          leading: Container(),
          actions: [],
        ),
        body:  StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatusPermission> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ScreenLoader();
            }
            if (snapshot.data!.enabled == true) {
              switch (snapshot.data!.status) {
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return HomeTabKiblaCompass();

                case LocationPermission.denied:
                  return LocationError(
                    error: "Nije odobrena upotreba Lokacije!",
                    callback: _checkLocationStatus,
                  );
                case LocationPermission.deniedForever:
                  return LocationError(
                    error: "Upotreba Lokacije trajno zabranjena!",
                    callback: _checkLocationStatus,
                  );
              // case GeolocationStatus.unknown:
              //   return LocationErrorWidget(
              //     error: "Unknown Location service error",
              //     callback: _checkLocationStatus,
              //   );
                default:
                  return Container();
              }
            } else {
              return LocationError(
                error: "Molimo aktivirajte Lokaciju",
                callback: _checkLocationStatus,
              );
            }
          },
        )
    );
  }
}
