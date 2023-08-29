import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/ui/IoT/reload_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReloadBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Icon(
                Icons.autorenew,
                color: Colors.black,
                size: 28,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildReloadTime(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildReloadTime(BuildContext context) {
    String time = context.watch<ReloadTime>().reloadTime;

    return Text(
      'Last update: $time',
      textAlign: TextAlign.left,
      style: AppTheme.appTheme.textTheme.titleMedium!
    );
  }
}
