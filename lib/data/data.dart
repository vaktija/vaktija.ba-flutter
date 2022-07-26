import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

List tabIcons = [
  'assets/icons/home.png',
  'assets/icons/kalendar.png',
  'assets/icons/compass.png',
  'assets/icons/settings.png'
];

List gradovi = [];

var vaktijaData;
var differences;

String podneVakatTakvim = 'Stvarno vrijeme';
String podneVakatAdet = 'Standardno vrijeme (12h/13h)';

String dzumaVakatTakvim = 'Neće biti razlike između postavki za podne i džumu.';
String dzumaVakatAdet = 'Koristit će se posebne postavke za džumu.';

List daniSedmice = ['pon', 'uto', 'sri', 'čet', 'pet', 'sub', 'ned'];

List daniSedmiceFull = ['ponedjeljak', 'utorak', 'srijeda', 'četvrtak', 'petak', 'subota', 'nedjelja'];

List mjeseci = [
  'jan',
  'feb',
  'mar',
  'apr',
  'maj',
  'jun',
  'jul',
  'aug',
  'sep',
  'okt',
  'nov',
  'dec'
];

List mjeseciFullName = [
  'januar',
  'februar',
  'mart',
  'april',
  'maj',
  'juni',
  'juli',
  'august',
  'septembar',
  'oktobar',
  'novembar',
  'decembar'
];

List mjeseciHidz = [
  'muharrem',
  'safer',
  'rebiul-evvel',
  'rebiul-ahir',
  'džumadel-ula',
  'džumadel-uhra',
  'redžeb',
  "ša'ban",
  'ramazan',
  'ševval',
  "zul-ka'de",
  'zul-hidždže'
];

List vaktoviName = [
  'Zora',
  'Izlazak sunca',
  'Podne',
  'Ikindija',
  'Akšam',
  'Jacija'
];

List vaktoviNotifikacija = [
  'Zora',
  'I. sunca',
  'Podne',
  'Ikindija',
  'Akšam',
  'Jacija'
];

var colorBlackBody = Colors.black87;
var colorGreyDark = Colors.grey.shade900;
var colorGreyMedium = Colors.grey.shade600;
var colorGreyLight = Colors.grey.shade400;
var colorWhite = Colors.white;

var colorWarning = Color(0xffff7a00);
var colorBackground = Color(0xffffffff);
var colorErrorColor = Color(0xff0000ff).withOpacity(1.0);
var colorSubtitle = Color(0xffCACACA);
var colorTitle = Color(0xff4a4a4a);
var colorAction = Color(0xff0882fd);
var colorGold = Color(0xffa59573);
const colorSwitchActive = Colors.green;

const iconThemeData = IconThemeData(color: Colors.black87);

const iconThemeDataNegative = IconThemeData(color: Colors.white);


double defaultPadding = 8.0;

String prefsVaktijaSaveDataKey = 'vaktijaData';