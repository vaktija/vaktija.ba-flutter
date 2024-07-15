import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/vaktija_location_list_field.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/capitalize_letter.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/sort_list_items.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

class LocationSearchScreen extends StatefulWidget {
  final closeFilter;

  const LocationSearchScreen({
    Key? key,
    this.closeFilter,
  }) : super(key: key);

  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _textEditingController;

  // late Timer _timer;

  List listaGradova = [];
  List listaGradovaFiltrirano = [];

  bool showFiltered = false;
  bool showLoader = false;

  @override
  void initState() {
    super.initState();
    // _timer = Timer(Duration(milliseconds: 0), () {});
    _textEditingController = TextEditingController(text: '')
      ..addListener(() {
        // filterGradovi(_textEditingController.text);
      });
    importGradovi();
  }

  void importGradovi() async {
    List gradoviImport = [];
    var gradoviData = jsonDecode(
        await rootBundle.loadString('assets/vaktija/gradovi_9.json'));
    setState(() {
      gradoviImport.addAll(gradoviData);
      listaGradova.addAll(sortGradoviAlphabetically(gradoviImport));
    });
  }

  void filterGradovi(String text) {
    // setState(() {
    //   showLoader = true;
    // });
    // if (_timer != null || _timer.isActive) {
    //   _timer.cancel();
    // }
    // _timer = Timer(Duration(milliseconds: 10), () {
    setState(() {
      showFiltered = true;
      listaGradovaFiltrirano.clear();
    });
    listaGradova.forEach((item) {
      String itemName = stringCapitaliseEachWord(item['IlceAdiEn'].toString());
      if (itemName.contains(stringCapitaliseEachWord(text.trim()))) {
        final index = listaGradova.indexWhere((element) => element == item);
        setState(() {
          listaGradovaFiltrirano.add(listaGradova[index]);
        });
      }
    });
    //   setState(() {
    //     showLoader = false;
    //   });
    //   _timer.cancel();
    // });
  }

  void clearFilterGradovi() {
    setState(() {
      showFiltered = false;
      listaGradovaFiltrirano.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: defaultPadding * 2,
              top: defaultPadding * 2,
              //bottom: defaultPadding// * 2
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _searchInput(isDarkModeOn),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextBodyMedium(
                        text: 'Otkaži',
                        color: AppColors.colorAction,
                      )),
                )
              ],
            ),
          ),
          Expanded(
              child: listaGradova.length < 1
                  ? ScreenLoader()
                  : !showFiltered
                  ? Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding * 2),
                    itemBuilder: (context, index) {
                      int locationIndex = int.parse(
                          listaGradova[index]['IlceID'].toString());
                      var title = listaGradova[index]['IlceAdiEn'];
                      return LocationListField(
                        title: title,
                        index: index,
                        isRadioIcon: false,
                        isChecked: false,
                        length: listaGradova.length,
                        //closeFilter: widget.closeFilter,
                        onTap: () {
                          setVaktijaLocation(context, locationIndex);
                          Navigator.pop(context);
                          widget.closeFilter();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return DividerCustomHorizontal();
                    },
                    itemCount: listaGradova.length),
              )
                  : (showLoader
                  ? ScreenLoader()
                  : listaGradovaFiltrirano.length < 1
                  ? _noData()
                  : ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 2,
                      vertical: defaultPadding * 2),
                  itemBuilder: (context, index) {
                    var locationIndex = int.parse(
                        listaGradovaFiltrirano[index]
                        ['IlceID']);
                    var title = listaGradovaFiltrirano[index]
                    ['IlceAdiEn'];
                    return LocationListField(
                      title: title,
                      index: index,
                      length: listaGradovaFiltrirano.length,
                      isChecked: false,
                      //closeFilter: widget.closeFilter,
                      isRadioIcon: false,
                      onTap: () {
                        setVaktijaLocation(
                            context, locationIndex);
                        Navigator.pop(context);
                        widget.closeFilter();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return DividerCustomHorizontal();
                  },
                  itemCount: listaGradovaFiltrirano.length)))
        ],
      ),
    );
  }

  Widget _searchInput(isDarkModeOn) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .bodyLarge!;
    return Container(
      decoration: BoxDecoration(
          color: isDarkModeOn ? AppColors.colorGreyDark : Colors.white,
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
              width: 1,
              color: AppColors.colorGreyLight,
              style: BorderStyle.solid)),
      padding: EdgeInsets.only(
        //vertical: defaultPadding,
          left: defaultPadding * 2),
      child: TextFormField(
        autofocus: true,
        controller: _textEditingController,
        textInputAction: TextInputAction.search,
        style: textStyle.copyWith(
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Unesi ime grada...',
          suffixIcon: _textEditingController.text.isEmpty
              ? Container(
            width: 0,
          )
              : IconButton(
            splashRadius: 15,
            icon: Icon(
              Icons.close,
              color: Theme
                  .of(context)
                  .iconTheme
                  .color!
                  .withOpacity(0.9),
            ),
            onPressed: () {
              _textEditingController.clear();
              clearFilterGradovi();
            },
          ),
          hintStyle: textStyle.copyWith(
              color: textStyle.color!.withOpacity(0.8),
              decoration: TextDecoration.none
          )

        //   TextStyle(
        //   fontFamily: 'raleway',
        //   fontSize: 18,
        //   //height: isMobile ? _heightMobile : _height,
        //   fontWeight: FontWeight.w500,
        //   color: colorGreyLight,
        //   decoration: TextDecoration.none,
        // ),
      ),
      onChanged: (text) {
        filterGradovi(text);
      },
    ),);
  }

  Widget _noData() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          TextBodyMedium(
            text: 'Žao nam je',
            bold: true,
            //color: colorGrey6,
          ),
          VerticalListSeparator(
            height: 2,
          ),
          TextBodyMedium(
            text: 'Trenutno nemamo namaska \nvremena za traženu lokaciju',
            bold: false,
          )
        ],
      ),
    );
  }
}
