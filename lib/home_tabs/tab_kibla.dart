import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class HomeTabKibla extends StatefulWidget {
  const HomeTabKibla({Key? key}) : super(key: key);

  @override
  _HomeTabKiblaState createState() => _HomeTabKiblaState();
}

class _HomeTabKiblaState extends State<HomeTabKibla> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        title: TextTitle(
          text: 'Kibla kompas',
          bold: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: Container(),
        actions: [],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/kibla_compass_marker_light.png',
            height: screenSize.width * 0.1,
            color: isDarkModeOn ? Colors.white : colorGreyDark,
          ),
          VerticalListSeparator(
            height: 3,
          ),
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
                      color: isDarkModeOn ? Colors.white : colorGreyDark,
                    ),
                  ),
                  Center(
                    child: StreamBuilder(
                      stream: FlutterQiblah.qiblahStream,
                      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ScreenLoader();
                        }
                        ;
                        final qiblahDirection = snapshot.data;
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
                                  isDarkModeOn ? 'assets/icons/kibla_needle_dark.png':
                                  'assets/icons/kibla_needle_light.png',
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
      ),
    );
  }
}
