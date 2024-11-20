import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:notes_app/sign_in/bloc/sign_in_event.dart';
import 'package:notes_app/sign_in/bloc/sign_in_state.dart';
import 'package:notes_app/utils/relative_sizer.dart';
import 'package:notes_app/widgets.dart/primary_button_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryButtonWidget(
                    onPressed: () {
                      context
                          .read<SignInBloc>()
                          .add(const InitializeGoogleSignInEvent());
                    },
                    text: "Continue with Google",
                    width: context.w * 0.5,
                  ),
                  context.spaceV1,
                  PrimaryButtonWidget(
                    onPressed: () {
                      context
                          .read<SignInBloc>()
                          .add(const InitializeAppleSignInEvent());
                    },
                    text: "Continue with Apple",
                    width: context.w * 0.5,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
