import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/home_tabs/tab_calendar.dart';
import 'package:vaktijaba_fl/home_tabs/tab_kibla.dart';
import 'package:vaktijaba_fl/home_tabs/tab_settings.dart';
import 'package:vaktijaba_fl/home_tabs/tab_vaktija.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          currentTab = _tabController.index;
        });
        setSelectedDate(context, DateTime.now());
      });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);

    List tabs = [
      HomeTabVaktija(),
      HomeTabCalendar(),
      HomeTabKibla(),
      HomeTabSettings()
    ];
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: List.generate(tabs.length, (index) => tabs[index]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: colorWhite,
          labelColor: colorGreyDark,
          indicatorColor: Colors.transparent,
          tabs: List.generate(
              tabIcons.length,
              (index) => Tab(
                    child: Image.asset(
                      tabIcons[index],
                      height: 24.0,
                      color: currentTab == index
                          ? (isDarkModeOn ? Colors.white : colorTitle)
                          : colorSubtitle,
                    ),
                  )),
        ),
      ),
    );
  }
}
