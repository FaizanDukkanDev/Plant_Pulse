import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/bloc/authentication/authentication.dart';
import 'package:plantpulse/ui/profile/avatar.dart';
import 'package:plantpulse/ui/profile/user_info_field.dart';
import 'package:plantpulse/ui/widgets/tab_page.dart';
import 'package:plantpulse/utils/message_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfilePage extends TabPage {
  const UserProfilePage({required Key key, required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _UserProfilePagePageState createState() => _UserProfilePagePageState();
}

class _UserProfilePagePageState extends TabPageState<UserProfilePage> {
  @override
  void initState() {
    tabListView.add(Avatar());
    tabListView.add(UserInfoField(
      name: 'Name',
      icon: Icons.account_circle,
      field: 'displayName',
    ));
    tabListView.add(UserInfoField(
      name: 'Email',
      icon: Icons.email,
      field: 'email',
    ));
    tabListView.add(_LogOutButton());
    super.initState();
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: SizedBox(
          height: 45.h,
          width: 300.w,
          child: ElevatedButton(
            child:  Text(
              'LOG OUT',
              style: AppTheme.appTheme.textTheme.labelLarge!,
            ),
            onPressed: () async {
              context.read<AuthenticationBloc>().logout();
              await context.read<MessageHandler>().deleteToken();
            },
          ),
        ),
      ),
    );
  }
}
