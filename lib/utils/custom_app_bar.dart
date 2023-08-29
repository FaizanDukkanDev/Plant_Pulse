import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, this.showBackButton = true,this.color=0, Key? key}) : super(key: key);

  final String title;
  final int color;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:color==0? Theme.of(context).primaryColor:Color(color),
      automaticallyImplyLeading: false,
      // toolbarHeight:50.h,
      titleSpacing: 0.3,
      leading: showBackButton
          ? GestureDetector(
              onTap: () {
               Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 10.r,
                backgroundColor: Colors.white.withOpacity(0.85),
                child: Icon(Icons.chevron_left_rounded, color: color==0?Theme.of(context).primaryColor:Color(color)),
              ),
            )
          : null,
      title: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white.withOpacity(0.85))),
      actions: [
        // SvgPicture.asset(AppAssets.uremitLogoSvg, width: 75.w),
        SizedBox(width: 22.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
