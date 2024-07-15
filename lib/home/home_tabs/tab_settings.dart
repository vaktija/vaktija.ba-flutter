import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaktijaba_fl/app_theme/theme_settings_switch.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/horizontal_separator.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/location_screen/location_screen.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

class HomeTabSettings extends StatefulWidget {
  const HomeTabSettings({Key? key}) : super(key: key);

  @override
  _HomeTabSettingsState createState() => _HomeTabSettingsState();
}

class _HomeTabSettingsState extends State<HomeTabSettings> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool isDarkModeOn = isDarkMode(context);
    VaktijaDateTimeProvider vaktijaProvider =
        Provider.of<VaktijaDateTimeProvider>(context);
    //vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    bool podneVrijeme = vaktijaProvider.podneStvarnoVrijeme;
    bool dnevnaVaktija = vaktijaProvider.showDailyVaktija;
    bool dzumaVrijemeAdet = vaktijaProvider.dzumaVrijemeAdet;

    return Scaffold(
      //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const TextBodyMedium(
          text: 'Postavke',
          bold: true,
        ),
        // backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   shadowColor: Colors.transparent,
        centerTitle: true,
        leading: Container(),
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        shrinkWrap: true,
        children: [
          const TextBodyMedium(
            text: 'Tema',
            bold: true,
          ),
          ThemeSettingsSwitch(),
          const DividerCustomHorizontal(
            height: defPadding * 3,
          ),
          const TextBodyMedium(
            text: 'Lokacija',
            bold: true,
          ),
          InkWell(
            onTap: () {
              openNewScreen(context, const LocationScreen(), 'lokacija');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBodyMedium(
                    text: gradovi[grad],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).iconTheme.color,
                  )
                ],
              ),
            ),
          ),
          gap16,
          const DividerCustomHorizontal(),
          gap16,
          const TextBodyMedium(
            text: 'Dnevna vaktija u notifikaciji',
            bold: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: const TextBodyMedium(
                    text: 'Prikaži dnevnu vaktiju',
                    bold: false,
                    //color: colorLightShade,
                  ),
                ),
                const HorizontalListSeparator(
                  width: 1,
                ),
                ToggleSwitch(
                  isToggle: dnevnaVaktija,
                  onTap: () {
                    Provider.of<VaktijaDateTimeProvider>(context, listen: false)
                        .setDnevnaVaktijaNotification(!dnevnaVaktija);
                  },
                )
              ],
            ),
          ),
          gap16,
          const DividerCustomHorizontal(),
          gap16,
          const TextBodyMedium(
            text: 'Podne-namaz',
            bold: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextBodyMedium(
                        text: 'Vrijeme Podne-namaza',
                        bold: false,
                        //color: colorLightShade,
                      ),
                      const VerticalListSeparator(
                        height: 0.5,
                      ),
                      TextBodySmall(
                        text: podneVrijeme ? podneVakatTakvim : podneVakatAdet,
                        italic: false,
                      )
                    ],
                  ),
                ),
                const HorizontalListSeparator(
                  width: 1,
                ),
                ToggleSwitch(
                  isToggle: !podneVrijeme,
                  onTap: () {
                    setVaktijaPodneVrijeme(context, !podneVrijeme);
                  },
                )
              ],
            ),
          ),
          gap16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextBodyMedium(
                      text: 'Posebne postavke za džumu',
                      bold: false,
                      //color: colorLightShade,
                    ),
                    const VerticalListSeparator(
                      height: 0.5,
                    ),
                    TextBodySmall(
                      text:
                          !dzumaVrijemeAdet ? dzumaVakatTakvim : dzumaVakatAdet,
                      italic: false,
                    )
                  ],
                ),
              ),
              const HorizontalListSeparator(
                width: 1,
              ),
              ToggleSwitch(
                isToggle: dzumaVrijemeAdet,
                onTap: () {
                  setVaktijaDzumaVrijeme(context, !dzumaVrijemeAdet);
                },
              )
            ],
          ),
          const VerticalListSeparator(height: 2),
          const DividerCustomHorizontal(),
          const VerticalListSeparator(height: 2),
          InkWell(
            onTap: () {
              Share.share('http://vaktija.ba');
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextBodyMedium(
                  text: 'Social',
                  bold: true,
                ),
                VerticalListSeparator(
                  height: 1,
                ),
                TextBodyMedium(
                  text: 'Podijeli',
                  bold: false,
                ),
                VerticalListSeparator(
                  height: 0.5,
                ),
                TextBodySmall(
                  text: 'Email, SMS, chat...',
                  italic: false,
                ),
              ],
            ),
          ),
          const VerticalListSeparator(height: 2),
          const DividerCustomHorizontal(),
          const VerticalListSeparator(height: 2),
          InkWell(
            enableFeedback: false,
            onTap: () {
              prijaviBug();
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextBodyMedium(
                  text: 'Aplikacija',
                  bold: true,
                ),
                VerticalListSeparator(
                  height: 1,
                ),
                TextBodyMedium(
                  text: 'Kontakt',
                  bold: false,
                ),
                VerticalListSeparator(
                  height: 0.5,
                ),
                TextBodySmall(
                  text: 'Pošalji prijedlog, prijavi bug...',
                  italic: false,
                ),
              ],
            ),
          ),
          const VerticalListSeparator(
            height: 2,
          ),
          const TextBodyMedium(
            text: 'Aplikacija',
            bold: false,
          ),
          const VerticalListSeparator(
            height: 0.5,
          ),
          TextBodySmall(
            text: 'Verzija ${AppSettings.APP_VERSION}',
            italic: false,
          ),
          const VerticalListSeparator(height: 2),
          const DividerCustomHorizontal(),
          const VerticalListSeparator(height: 4),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: screenSize.width * 0.6,
              child: Image.asset(
                'assets/icons/logo_iz.png',
                // color: isDarkModeOn ? AppColors.colorGreyLight : null,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          gap32,
        ],
      ),
    );
  }

  prijaviBug() async {
    final mailtoLink = Mailto(
      to: ['info@vaktija.ba'],
      subject: 'Prijedlog iOS',
      body: 'Vaš prijedlog: ',
    );
    await launchUrl(Uri.parse('$mailtoLink'));
  }
}
