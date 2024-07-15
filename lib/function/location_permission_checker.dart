import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

/// [LocationPermissionChecker] is a singleton class that provides assess to compass events,
/// check for sensor support in Android
/// Get current  location
/// Get Qiblah direction
class LocationPermissionChecker {
  static const MethodChannel _channel =
      const MethodChannel('ml.medyas.flutter_qiblah');
  static final LocationPermissionChecker _instance =
      LocationPermissionChecker._();

  LocationPermissionChecker._();

  factory LocationPermissionChecker() {
    return _instance;
  }

  /// Check Android device sensor support
  static Future<bool?> androidDeviceSensorSupport() async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod("androidSupportSensor");
    else
      return true;
  }

  /// Request Location permission, return GeolocationStatus object
  static Future<LocationPermission> requestPermissions() async {
    return await Geolocator.requestPermission();
  }

  /// get location status: GPS enabled and the permission status with GeolocationStatus
  static Future<LocationStatusPermission> checkLocationStatus() async {
    final status = await Geolocator.checkPermission();
    final enabled = await Geolocator.isLocationServiceEnabled();
    return LocationStatusPermission(enabled, status);
  }
}

/// Location Status class, contains the GPS status(Enabled or not) and GeolocationStatus
class LocationStatusPermission {
  final bool enabled;
  final LocationPermission status;

  const LocationStatusPermission(this.enabled, this.status);
}
