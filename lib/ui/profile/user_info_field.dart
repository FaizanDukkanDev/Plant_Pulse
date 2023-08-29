import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/user/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoField extends StatelessWidget {
  const UserInfoField({
    Key? key,
    required this.name,
    required this.icon,
    required this.field,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Container(
          width: 300.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  name,
                  style: AppTheme.appTheme.textTheme.labelLarge!,
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.appTheme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                      child: Icon(icon),
                    ),
                    Expanded(child: _buildFieldValue(context, field)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildFieldValue(BuildContext context, String field) {
    if (field == 'displayName') {
      return Text(
        RepositoryProvider.of<UserRepository>(
          context,
          listen: false,
        ).displayName,
        style: AppTheme.appTheme.textTheme.bodyMedium!,
      );
    } else {
      return Text(
        RepositoryProvider.of<UserRepository>(
          context,
          listen: false,
        ).email,
        style: AppTheme.appTheme.textTheme.bodyMedium!,
      );
    }
  }
}
