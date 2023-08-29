import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/bloc/sign_up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/plant_pulse.png',
                height: 120.h,
              ),
               SizedBox(height: 8.h),
              _NameInput(),
               SizedBox(height: 8.h),
              _EmailInput(),
               SizedBox(height: 8.h),
              _PasswordInput(),
               SizedBox(height: 8.h),
              _ConfirmPasswordInput(),
               SizedBox(height: 8.h),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('signUpForm_nameInput_textField'),
            onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              labelText: 'Name',
              helperText: '',
              errorText: state.name.invalid ? 'Please enter your name' : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_rounded),
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid
                  ? 'Password must contain at least 8 characters, including at least 1 letter and 1 number'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Container(
          width: 300.w,
          child: TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) =>
                context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_rounded),
              labelText: 'Confirm password',
              helperText: '',
              errorText: state.confirmedPassword.invalid ? 'Passwords do not match' : null,
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
          height: 45.h,
          width: 300.w,
                child: ElevatedButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  child:  Text(
                    'SIGN UP',
                    style: AppTheme.appTheme.textTheme.labelLarge!,
                  ),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
                ),
              );
      },
    );
  }
}
