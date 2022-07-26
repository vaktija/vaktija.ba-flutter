import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data.dart';

void saveVaktijaInitData(vaktijaSaveData) async {
  String _vaktijaSaveData = jsonEncode(vaktijaSaveData);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(prefsVaktijaSaveDataKey, _vaktijaSaveData);
}