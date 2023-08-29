import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/ui/farm/planting/form_storePlanting.dart';
import 'package:plantpulse/ui/farm/planting/planting_list.dart';
import 'package:plantpulse/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';

class PlantingMenu extends StatefulWidget {
  @override
  _PlantingMenuState createState() => _PlantingMenuState();
}

class _PlantingMenuState extends State<PlantingMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appTheme.scaffoldBackgroundColor,
      child: Scaffold(
          appBar: CustomAppBar(title: 'Manage Planting',color: kPastelGreen,),
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    GFListTile(
                      titleText: 'Create Planting',
                      subTitle: Text('Record a new planting activity.'),
                      color: Color(kPastelGreen),
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: FormStorePlanting()));

                      },

                    ),
                    GFListTile(
                      titleText: 'View Planting',
                      subTitle: Text('Take a look at all your previous records.'),
                      color: Color(kPastelGreen),
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: PlantingList()));

                      },

                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         PageTransition(
                    //             type: PageTransitionType.leftToRightWithFade,
                    //             child: FormStorePlanting()));
                    //   },
                    //   child: GFCard(
                    //     boxFit: BoxFit.cover,
                    //     image: Image.asset('assets/images/planting_create.jpg'),
                    //     title: GFListTile(
                    //       titleText: 'Create Planting',
                    //       subTitle: Text("Record a new planting activity."),
                    //       icon: Icon(Icons.arrow_forward),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         PageTransition(
                    //             type: PageTransitionType.leftToRightWithFade,
                    //             child: PlantingList()));
                    //   },
                    //   child: GFCard(
                    //     boxFit: BoxFit.cover,
                    //     image: Image.asset('assets/images/planting_view.jpg'),
                    //     title: GFListTile(
                    //       titleText: 'View Planting',
                    //       subTitle:
                    //           Text("Take a look at all your previous records."),
                    //       icon: Icon(Icons.arrow_forward),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
