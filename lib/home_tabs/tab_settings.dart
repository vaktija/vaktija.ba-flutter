import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaktijaba_fl/components/horizontal_separator.dart';
import 'package:vaktijaba_fl/components/text_styles/text_subtitle.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/toggle_switch.dart';
import 'package:vaktijaba_fl/components/vertical_divider.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
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
    var vaktijaProvider = vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    bool podneVrijeme = vaktijaProvider.podneStvarnoVrijeme;
    bool dzumaVrijemeAdet = vaktijaProvider.dzumaVrijemeAdet;

    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const TextTitle(
          text: 'Postavke',
          bold: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: Container(),
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        shrinkWrap: true,
        children: [
          const TextTitle(
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
                  TextTitle(
                    text: gradovi[grad],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: isDarkModeOn ? Colors.white : colorGreyDark,
                  )
                ],
              ),
            ),
          ),
          const VerticalListSeparator(height: 2),
          const VerticalListDivider(),
          const VerticalListSeparator(height: 2),
          const TextTitle(
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
                      const TextTitle(
                        text: 'Vrijeme Podne-namaza',
                        bold: false,
                        //color: colorLightShade,
                      ),
                      const VerticalListSeparator(
                        height: 0.5,
                      ),
                      TextSubtitle(
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
          const VerticalListSeparator(height: 2),
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
                      const TextTitle(
                        text: 'Posebne postavke za džumu',
                        bold: false,
                        //color: colorLightShade,
                      ),
                      const VerticalListSeparator(
                        height: 0.5,
                      ),
                      TextSubtitle(
                        text: !dzumaVrijemeAdet
                            ? dzumaVakatTakvim
                            : dzumaVakatAdet,
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
          ),
          const VerticalListSeparator(height: 2),
          const VerticalListDivider(),
          const VerticalListSeparator(height: 2),
          InkWell(
            onTap: () {
              Share.share('http://vaktija.ba');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextTitle(
                  text: 'Social',
                  bold: true,
                ),
                VerticalListSeparator(
                  height: 1,
                ),
                TextTitle(
                  text: 'Podijeli',
                  bold: false,
                ),
                VerticalListSeparator(
                  height: 0.5,
                ),
                TextSubtitle(
                  text: 'Email, SMS, chat...',
                  italic: false,
                ),
              ],
            ),
          ),
          const VerticalListSeparator(height: 2),
          const VerticalListDivider(),
          const VerticalListSeparator(height: 2),
          InkWell(
            enableFeedback: false,
            onTap: () {
              prijaviBug();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextTitle(
                  text: 'Aplikacija',
                  bold: true,
                ),
                VerticalListSeparator(
                  height: 1,
                ),
                TextTitle(
                  text: 'Kontakt',
                  bold: false,
                ),
                VerticalListSeparator(
                  height: 0.5,
                ),
                TextSubtitle(
                  text: 'Pošalji prijedlog, prijavi bug...',
                  italic: false,
                ),
              ],
            ),
          ),
          const VerticalListSeparator(
            height: 2,
          ),
          const TextTitle(
            text: 'Aplikacija',
            bold: false,
          ),
          const VerticalListSeparator(
            height: 0.5,
          ),
          const TextSubtitle(
            text: 'Verzija 1.0.0',
            italic: false,
          ),
          const VerticalListSeparator(height: 2),
          const VerticalListDivider(),
          const VerticalListSeparator(height: 4),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: screenSize.width * 0.6,
              child: Image.asset(
                'assets/icons/logo_iz.png',
                color: isDarkModeOn ? colorGreyLight : null,
                fit: BoxFit.fitWidth,
              ),
            ),
          )
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
