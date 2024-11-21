import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/common_imports.dart';
import 'package:notes_app/screens/home/home_screen.dart';
import 'package:notes_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:notes_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:notes_app/screens/sign_in/bloc/sign_in_state.dart';
import 'package:notes_app/services/internet_service/internet_service_bloc.dart';
import 'package:notes_app/services/internet_service/internet_service_state.dart';

import 'package:notes_app/utils/relative_sizer.dart';

import 'package:notes_app/widgets/custom_elevated_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityDisconnected) {
          Fluttertoast.showToast(
              msg: noInternetMsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      },
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is ProceedToHomeScreenState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    onTap: () {
                      if (context.read<ConnectivityBloc>().state
                          is ConnectivityConnected) {
                        context
                            .read<SignInBloc>()
                            .add(const InitializeGoogleSignInEvent());
                      } else {
                        Fluttertoast.showToast(
                            msg: noInternetMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                    },
                    text: "Continue with Google",
                    width: context.w * 0.55,
                  ),
                  context.spaceV1,
                  CustomElevatedButton(
                    onTap: () {
                      if (context.read<ConnectivityBloc>().state
                          is ConnectivityConnected) {
                        context
                            .read<SignInBloc>()
                            .add(const InitializeAppleSignInEvent());
                      } else {
                        Fluttertoast.showToast(
                            msg: noInternetMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                    },
                    text: "Continue with Apple",
                    width: context.w * 0.55,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
