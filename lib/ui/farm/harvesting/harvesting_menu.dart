import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/ui/farm/harvesting/harvesting_list.dart';
import 'package:plantpulse/ui/farm/harvesting/planting_selection_list.dart';
import 'package:plantpulse/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';

class HarvestMenu extends StatefulWidget {
  @override
  _HarvestMenuState createState() => _HarvestMenuState();
}

class _HarvestMenuState extends State<HarvestMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appTheme.scaffoldBackgroundColor,
      child: Scaffold(
          appBar: CustomAppBar(title: 'Manage Harvesting',color: kBrownClr,),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    GFListTile(
                      titleText: 'Create Harvesting',
                      subTitle: Text('Record a new harvesting activity.'),
                      color: Color(kBrownClr),
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRightWithFade,
                              child: PlantingSelectionList(),
                            ));

                      },

                    ),
                    GFListTile(
                      titleText: 'View Harvesting',
                      subTitle: Text("Take a look at all your previous records."),
                      color: Color(kBrownClr),
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRightWithFade,
                              child: HarvestList(),
                            ));

                      },

                    ),
                    // InkWell(
                    //   onTap: () {
                    //
                    //   },
                    //   child: GFCard(
                    //     boxFit: BoxFit.cover,
                    //     image: Image.asset('assets/images/harvesting_create.jpg'),
                    //     title: GFListTile(
                    //       titleText: 'Create Harvesting',
                    //       subTitle: Text("Record a new harvesting activity."),
                    //       icon: Icon(Icons.arrow_forward),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         PageTransition(
                    //           type: PageTransitionType.leftToRightWithFade,
                    //           child: HarvestList(),
                    //         ));
                    //   },
                    //   child: GFCard(
                    //     boxFit: BoxFit.cover,
                    //     image: Image.asset('assets/images/harvesting_view.jfif'),
                    //     title: GFListTile(
                    //       titleText: 'View Harvesting',
                    //       subTitle: Text("Take a look at all your previous records."),
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
