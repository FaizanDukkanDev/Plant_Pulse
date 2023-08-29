import 'package:plantpulse/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.photo}) : super(key: key);

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return

      // CircleAvatar(
      //   radius: 35.r,
      //   backgroundColor: Colors.grey.withOpacity(0.4),
      //   backgroundImage: AssetImage(
      //     AppAssets.defaultPicture,
      //   ),
      // )
      CircleAvatar(
        radius: 48.r,
        backgroundColor: Colors.grey.withOpacity(0.4),
        foregroundColor: Colors.black54,
        backgroundImage: photo != null ? NetworkImage(photo!) : null,
        child: photo == null
            ? Image.asset(
          'assets/images/profile_avatar.png',
          // Add any necessary properties for the AssetImage widget
        )
            : null,
      );
  }
}
