import 'package:flutter/material.dart';

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

List daniSedmiceShort = ['pon', 'uto', 'sri', 'čet', 'pet', 'sub', 'ned'];

List daniSedmiceFull = [
  'ponedjeljak',
  'utorak',
  'srijeda',
  'četvrtak',
  'petak',
  'subota',
  'nedjelja'
];

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

double defaultPadding = 8.0;

//String prefsVaktijaSaveDataKey = 'vaktijaData';
