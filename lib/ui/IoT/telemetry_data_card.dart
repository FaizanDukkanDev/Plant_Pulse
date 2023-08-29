import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/IoT/models/telemetry_data.dart';
import 'package:plantpulse/data/IoT/repositories/telemetry_data_repository.dart';
import 'package:plantpulse/ui/IoT/reload_time.dart';
import 'package:plantpulse/ui/IoT/telemetry_data_card_item.dart';
import 'package:plantpulse/ui/IoT/telemetry_data_chart.dart';
import 'package:plantpulse/ui/IoT/telemetry_data_reading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelemetryDataCard extends StatelessWidget {
  const TelemetryDataCard({Key? key, required this.cardItem, required this.reloadTime})
      : super(key: key);

  final TelemetryDataCardItem cardItem;
  final ReloadTime reloadTime;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TelemetryData>(
      initialData: TelemetryData(
        timestamp: DateTime.now(),
        value: '0',
      ),
      create: (context) => context.read<TelemetryDataRepository>().readData(cardItem.data),
      builder: (context, _) {
        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 16.0,
                bottom: 18.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cardItem.color1,
                      cardItem.color2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.appTheme.canvasColor.withOpacity(0.6),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cardItem.title,
                        textAlign: TextAlign.left,
                        style: AppTheme.appTheme.textTheme.labelLarge!
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Text(
                            cardItem.description,
                            textAlign: TextAlign.left,
                            style: AppTheme.appTheme.textTheme.labelLarge!
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TelemetryDataReading(
                                data: cardItem.data,
                                reloadTime: reloadTime,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                cardItem.unit,
                                textAlign: TextAlign.left,
                                style: AppTheme.appTheme.textTheme.labelLarge!
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AspectRatio(
                          aspectRatio: 1.7,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppTheme.appTheme.scaffoldBackgroundColor.withOpacity(0.4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 32.0,
                                left: 32.0,
                                top: 24,
                                bottom: 12,
                              ),
                              child: TelemetryDataChart(
                                data: cardItem.data,
                                numData: 6,
                                cardItem: cardItem,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4.0,
              right: 20.0,
              height: 80,
              width: 80,
              child: Image.asset(cardItem.imagePath),
            ),
          ],
        );
      },
    );
  }
}
