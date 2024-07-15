import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_calendar.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_kibla_compass.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_settings.dart';
import 'package:vaktijaba_fl/home/home_tabs/tab_vaktija.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/notification_service.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

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
    loadNotifications();
  }

  Future handleLocalNotification(String? payload) async {
   print('notification tapped');
  }

  loadNotifications() async {
    //initLocalNotification() async {
      await NotificationService().init();
   // }
    Future.delayed(Duration(milliseconds: 300),(){
      Provider.of<VaktijaDateTimeProvider>(context, listen: false).startVaktijaTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    Color iconColor = Theme.of(context).indicatorColor;
    List tabs = const [
      HomeTabVaktija(),
      HomeTabCalendar(),
      HomeTabKibla(),
      HomeTabSettings()
    ];
    return Scaffold(
      /// backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
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
          unselectedLabelColor: iconColor.withOpacity(0.3),
          labelColor: iconColor,
          indicatorColor: Colors.transparent,
          tabs: List.generate(
              tabIcons.length,
              (index) => Tab(
                    child: Image.asset(
                      tabIcons[index],
                      height: 24.0,
                      color: currentTab == index
                          ? iconColor
                          : iconColor.withOpacity(0.3),
                    ),
                  )),
        ),
      ),
    );
  }
}
