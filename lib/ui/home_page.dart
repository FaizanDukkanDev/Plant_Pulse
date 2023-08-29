import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/user/repositories/user_repository.dart';
import 'package:plantpulse/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:plantpulse/ui/bottom_navigation_bar/tab_icon_data.dart';
import 'package:plantpulse/ui/plant_recognizer/plant_recognizer.dart';
import 'package:plantpulse/ui/devices/screen/devices_screen.dart';
import 'package:plantpulse/ui/farm/farm_management_page.dart';
import 'package:plantpulse/ui/profile/user_profile_page.dart';
import 'package:plantpulse/utils/message_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRepository _userRepository = UserRepository();
  late MessageHandler _messageHandler;
  List<TabIconData> _tabIconsList = TabIconData.tabIconsList;
  List<Widget> _tabList = [
    FarmManagementPage(
      pageTitle: 'Farm Management',
      key: ValueKey(1),
    ),

    DevicesScreen(
      pageTitle: 'Devices',
      key: ValueKey(2),
    ),

    // IoTMonitoringPage(
    //   pageTitle: 'IoT Monitoring',
    //   key: ValueKey(2),
    // ),
    PlantRecognizer(pageTitle: 'Plant Identification',
      key: ValueKey(3),),
    /*DiseaseDetectionPage(
      pageTitle: 'Disease Detection',
      key: ValueKey(3),
    ),*/
    UserProfilePage(
      pageTitle: 'My Profile',
      key: ValueKey(4),
    ),
  ];
  PageController _pageController = PageController();
  void printToken() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
  }
  @override
  void initState() {
    printToken();
    _messageHandler = MessageHandler(_userRepository)..generateToken();
    _tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    _tabIconsList[0].isSelected = true;

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(
          value: _userRepository,
        ),
        RepositoryProvider<MessageHandler>.value(
          value: _messageHandler,
        ),
      ],
      child: Container(
        color: AppTheme.appTheme.scaffoldBackgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _tabList,
              ),
              Column(
                children: <Widget>[
                  const Expanded(
                    child: SizedBox(),
                  ),
                  BottomNavBar(
                    tabIconsList: _tabIconsList,
                    onTap: (int i) {
                      _pageController.jumpToPage(i);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
