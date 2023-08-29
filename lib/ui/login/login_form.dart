import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/bloc/login/login_cubit.dart';
import 'package:plantpulse/ui/login/phone_login.dart';
import 'package:plantpulse/ui/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/plant_pulse.png',
                height: 120.h,
              ),

              SizedBox(height: 18.h),
              _EmailInput(),
              _PasswordInput(),

              _LoginButton(),
              SizedBox(height: 12.h),
              _SignUpButton(),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Or SignIn with',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: socialLoginButtons(
                            context: context,
                            imagePath: 'assets/images/google.png',
                            text: 'Google',
                            onTap: () {
                              context.read<LoginCubit>().logInWithGoogle();
                            }),
                      ),
                      TableCell(
                        child: socialLoginButtons(
                            context: context,
                            imagePath: 'assets/images/facebook.png',
                            text: 'Facebook',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Not Available',
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10.w),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: socialLoginButtons(
                              context: context,
                              imagePath: 'assets/images/apple.png',
                              text: 'Apple',
                              onTap: () {
                                context.read<LoginCubit>().appleLogin();
                              }),
                        ),
                        TableCell(
                          child: socialLoginButtons(
                            context: context,
                            imagePath: 'assets/images/phone_login.png',
                            text: 'Phone',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhoneLogin(),
                                ),
                              );
                            },
                            isHeight: true,

                            // _PhoneLoginButton(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'Invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_rounded),
              labelText: 'Password',
              helperText: '',
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 45.h,
                width: 300.w,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: Text('LOG IN',
                      style: AppTheme.appTheme.textTheme.labelLarge!),
                  onPressed: () =>
                      context.read<LoginCubit>().logInWithCredentials(),
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: 300.w,
      child: ElevatedButton(
        key: const Key('loginForm_createAccount_flatButton'),
        child: Text('SIGN UP',
            style: AppTheme.appTheme.textTheme.labelLarge!),
        onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      ),
    );
  }
}

Widget socialLoginButtons({
  required BuildContext context,
  required String imagePath,
  required String text,
  required void Function() onTap,
  bool isHeight = false,
}) {
  return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            left: isHeight ? 15.h : 10.h,
            top: 10.h,
            right: isHeight ? 0 : 10.w,
            bottom: 10.h),
        child: Container(
          height: 50.h,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(
              width: 1.w,
              color: Colors.black,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath,
                height: isHeight ? 20.h : 30.h,
                width: isHeight ? 20.w : 30.h,
                // scale: 1.65,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
      ));
}

// class _GoogleLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//         onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
//         child: Row(
//           children: [
//             Image.asset(
//               'assets/images/google.png',
//               height: 30,
//               width: 30,
//               scale: 1.65,
//             ),
//             Text(
//               'Google',
//               style: Theme.of(context).textTheme.titleMedium,
//             )
//           ],
//         ));
//   }
// }
//
// class _FacebookLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Not Available',
//               ),
//             ),
//           );
//         },
//         child: Row(
//           children: [
//             Image.asset(
//               height: 30,
//               width: 30,
//               'assets/images/facebook.png',
//               scale: 1.65,
//             ),
//             Text(
//               'Facebook',
//               style: Theme.of(context).textTheme.titleMedium,
//             )
//           ],
//         ));
//     //   SizedBox(
//     //   height: 45,
//     //   width: 200,
//     //   child: TextButton(
//     //     key: const Key('loginForm_facebookLogin_raisedButton'),
//     //     child: Text('Continue with Facebook'),
//     //     onPressed: () {
//     //       ScaffoldMessenger.of(context).showSnackBar(
//     //         SnackBar(
//     //           content: Text(
//     //             'Not Available',
//     //           ),
//     //         ),
//     //       );
//     //     },
//     //   ),
//     // );
//   }
// }
//
// class _AppleLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//         onPressed: () {
//           context.read<LoginCubit>().appleLogin();
//         },
//         child: Row(
//           children: [
//             Image.asset(
//               'assets/images/apple.png',
//               height: 30,
//               width: 30,
//               scale: 1.0,
//             ),
//             Text(
//               'Apple',
//               style: Theme.of(context).textTheme.titleMedium,
//             )
//           ],
//         ));
//     SizedBox(
//       height: 45,
//       width: 200,
//       child: TextButton(
//         key: const Key('loginForm_appleLogin_raisedButton'),
//         child: Text('Continue with Apple'),
//         onPressed: () {
//           context.read<LoginCubit>().appleLogin();
//         },
//       ),
//     );
//   }
// }
//
// class _PhoneLoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 45,
//       width: 200,
//       child: TextButton(
//         key: const Key('loginForm_phoneLogin_raisedButton'),
//         child: Text('Continue with Phone'),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => PhoneLogin(),
//           ),
//         ),
//       ),
//     );
//   }
// }
