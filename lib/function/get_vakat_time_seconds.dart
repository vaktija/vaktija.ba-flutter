import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/models/vaktija_settings_model.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';

int getVakatTimeSeconds({
  required int vakatIndex,
  required List<VakatSettingsModel> vaktovi,
  required VaktijaSettingsModel vaktijaSettingsModel,
}) {
  VakatSettingsModel vakatSettingsModel = vaktovi[vakatIndex];
  DateTime now = DateTime.now();
  int podneDefaultTime = 43200;
  bool dzuma = now.weekday == 5;
  int dan = now.day - 1;
  int mjesec = now.month - 1;
  int dstAddonTime = checkDST(now) ? 3600 : 0;
  bool specialDzuma = vaktijaSettingsModel.dzumaSpecial!;
  int grad = vaktijaSettingsModel.currentCity!;
  if (vakatIndex == 2 && dzuma && specialDzuma) {
    vakatSettingsModel = vaktovi[6];
  }
  bool podneVrijemeFixed = vakatSettingsModel.fixedTime ?? false;

  int vakatTimeSeconds = vakatIndex == 2 && podneVrijemeFixed
      ? podneDefaultTime + dstAddonTime
      : vaktijaData['months'][mjesec]['days'][dan]['vakat'][vakatIndex] +
          differences[grad]['months'][mjesec]['vakat'][vakatIndex] +
          dstAddonTime;
  return vakatTimeSeconds;
}
