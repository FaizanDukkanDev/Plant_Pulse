import 'package:plantpulse/ui/IoT/IoT_monitoring_page.dart';
import 'package:plantpulse/ui/devices/cubit/devices_provider.dart';
import 'package:plantpulse/ui/devices/screen/add_device_Screen.dart';
import 'package:plantpulse/ui/widgets/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../app_theme.dart';

class DevicesScreen extends TabPage {
  DevicesScreen({required super.key, required super.pageTitle});

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends TabPageState<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DevicesProvider>().loadDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Scaffold(
            appBar: AppBar(title: Text(widget.pageTitle,style: TextStyle(color: Colors.black),),toolbarHeight: 50, elevation: 0,backgroundColor: Colors.white,),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BLESCR()));
              },
            ),
            body: Consumer<DevicesProvider>(builder: (context, provider, _) {
              if (provider.loadingDevices) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.devicesData?.isEmpty ?? true) {
                return Center(
                  child: Text(
                    'No Devices',
                    style: TextStyle(),
                  ),
                );
              }
              final devices = provider.devicesData;
              // print('devices!.length ${devices!.length}');
              return ListView.separated(
                // padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                itemCount: devices!.length,
                separatorBuilder: (_, i) => SizedBox(height: 10),
                itemBuilder: (_, index) {
                  return  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          top: 10.h,
                          bottom: 18.h,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: getColorFromMoisture(devices[index].moisture),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(68.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppTheme.appTheme.colorScheme.background.withOpacity(0.6),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => IoTMonitoringPage(
                                        pageTitle: 'IoT Monitoring',
                                      ),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => DeviceDataScreen(deviceData: devices[index]),
                                  //   ),
                                  // );
                                },
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sensor'.padRight(15) + ' : ' + (devices[index].sensor ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      style: AppTheme.appTheme.textTheme.titleLarge!.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      'Moisture'.padRight(14) + ' : ' + (devices[index].moisture ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      style: AppTheme.appTheme.textTheme.titleLarge!.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      'Location'.padRight(14) + ' : ' + (devices[index].location ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      style: AppTheme.appTheme.textTheme.titleLarge!.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      'Updated At'.padRight(12) + ' : ' + DateFormat("dd,MMM yyyy").format(DateTime.parse(devices[index].updatedAt!)),
                                      textAlign: TextAlign.left,
                                      style: AppTheme.appTheme.textTheme.titleLarge!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 5.0,
                        height: 80,
                        // width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (devices[index].moisture != null && devices[index].moisture != 0)
                            Image.asset('assets/images/soil_moisture.png',  width: 28,  // Adjust the width as needed
                              height: 28, ),
                            if (devices[index].temperature != null && devices[index].temperature != 0)
                              Image.asset('assets/images/air_temperature.png',
                                width: 28,  // Adjust the width as needed
                                height: 28, ),
                            if (devices[index].humidity != null && devices[index].humidity != 0)
                              Image.asset('assets/images/air_humidity.png',
                                width: 28,  // Adjust the width as needed
                                height: 28, ),
                          ],
                        ),
                      ),
                    ],
                  );


                  //   ListTile(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   tileColor: getColorFromMoisture(devices[index].moisture),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) =>
                  //             DeviceDataScreen(deviceData: devices[index]),
                  //       ),
                  //     );
                  //   },
                  //   trailing: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [getBatteryIcon(devices[index].batt)],
                  //   ),
                  //   title: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //           'Sensor'.padRight(15) +
                  //               ' : ' +
                  //               (devices[index].sensor ?? 0).toString(),
                  //           textAlign: TextAlign.left,
                  //           style: AppTheme.appTheme.textTheme.titleLarge!
                  //               .copyWith(color: Colors.white)),
                  //       Text(
                  //           'Moisture'.padRight(14) +
                  //               ' : ' +
                  //               (devices[index].moisture ?? 0).toString(),
                  //           textAlign: TextAlign.left,
                  //           style: AppTheme.appTheme.textTheme.titleLarge!
                  //               .copyWith(color: Colors.white)),
                  //       Text(
                  //           'Location'.padRight(14) +
                  //               ' : ' +
                  //               (devices[index].location ?? 0).toString(),
                  //           textAlign: TextAlign.left,
                  //           style: AppTheme.appTheme.textTheme.titleLarge!
                  //               .copyWith(color: Colors.white)),
                  //       Text(
                  //           'Updated At'.padRight(12) +
                  //               ' : ' +
                  //               DateFormat("dd,MMM yyyy").format(
                  //                   DateTime.parse(devices[index].updatedAt!)),
                  //           textAlign: TextAlign.left,
                  //           style: AppTheme.appTheme.textTheme.titleLarge!
                  //               .copyWith(color: Colors.white)),
                  //     ],
                  //   ),
                  // );

                  //   ListView.separated(
                  //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //   itemCount: 4,
                  //   separatorBuilder: (_, i) => SizedBox(height: 10),
                  //   itemBuilder: (_, index) {
                  //     return ListTile(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //       tileColor:
                  //           getColorFromMoisture(50), // Hardcoded moisture value (50)
                  //       onTap: () {
                  //         // Navigator.push(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //     builder: (_) =>
                  //         //         DeviceDataScreen(deviceData: devices[index]),
                  //         //   ),
                  //         // );
                  //       },
                  //       trailing: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           getBatteryIcon(80)
                  //         ], // Hardcoded battery value (80)
                  //       ),
                  //       title: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Sensor'.padRight(15) +
                  //                 ' : ' +
                  //                 '123', // Hardcoded sensor value ('123')
                  //             textAlign: TextAlign.left,
                  //             style: AppTheme.appTheme.textTheme.titleLarge!
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //           Text(
                  //             'Moisture'.padRight(14) +
                  //                 ' : ' +
                  //                 '50', // Hardcoded moisture value ('50')
                  //             textAlign: TextAlign.left,
                  //             style: AppTheme.appTheme.textTheme.titleLarge!
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //           Text(
                  //             'Location'.padRight(14) +
                  //                 ' : ' +
                  //                 'New York', // Hardcoded location value ('New York')
                  //             textAlign: TextAlign.left,
                  //             style: AppTheme.appTheme.textTheme.titleLarge!
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //           Text(
                  //             'Updated At'.padRight(12) +
                  //                 ' : ' +
                  //                 'Jun 24, 2023', // Hardcoded updated date value ('Jun 24, 2023')
                  //             textAlign: TextAlign.left,
                  //             style: AppTheme.appTheme.textTheme.titleLarge!
                  //                 .copyWith(color: Colors.white),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );

                  // return Card(
                  //   child: ListTile(
                  //     onTap: () {
                  //       context.read<DevicesProvider>().getDeviceData(devices[index]);
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => DeviceDataScreen(),
                  //           ));
                  //     },
                  //     leading: Icon(Icons.devices),
                  //     title: Text(devices[index].id.toString()),
                  //     subtitle: Text(devices[index].hostname.toString()),
                  //     trailing: Text(devices[index].createdAt.toString()),
                  //   ),
                  // );
                },
              );
            })));
  }

  LinearGradient getColorFromMoisture(num? moisture) {
    if (moisture == null) {
      return LinearGradient(
        colors: [Colors.green, Colors.orangeAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (moisture > 70) {
      return LinearGradient(
        colors: [Color(0xFF006400), Color(0xFF1FDF39)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (moisture > 40) {
      return LinearGradient(
        colors: [Color(0xFF800000), Color(0xFFD2691E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: [Colors.yellow, Colors.orangeAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }


  Widget getBatteryIcon(num? batt) {
    if (batt == null) {
      return SizedBox.shrink();
    } else if (batt > 70) {
      return SvgPicture.asset('assets/svg/battery3.svg');
    } else if (batt > 40) {
      return SvgPicture.asset('assets/svg/battery2.svg');
    } else {
      return SvgPicture.asset('assets/svg/battery1.svg');
    }
  }
}
