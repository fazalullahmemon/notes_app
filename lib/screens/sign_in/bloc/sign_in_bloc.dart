import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:notes_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:notes_app/screens/sign_in/bloc/sign_in_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/utils/frequent_functions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(IdleSignInState()) {
    on<SignInEvent>((event, emit) {
      return switch (event) {
        InitializeAppleSignInEvent() => _initializeSignIn(event, emit),
        InitializeGoogleSignInEvent() => _initializeSignIn(event, emit),
      };
    });
  }

  _initializeSignIn(SignInEvent event, Emitter<SignInState> emit) async {
    if (event is InitializeAppleSignInEvent) {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      // final rawNonce = FrequentFunctions.generateNonce();
      // final nonce = FrequentFunctions.sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      // final appleCredential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   nonce: nonce,
      //   webAuthenticationOptions: WebAuthenticationOptions(
      //     clientId: "com.homeistudent.app.service",
      //     redirectUri: Uri.parse(
      //         "https://homei-student.firebaseapp.com/__/auth/handler"),
      //   ),
      // );

      // Create an `OAuthCredential` from the credential returned by Apple.
      // final oauthCredential = OAuthProvider("apple.com").credential(
      //   idToken: appleCredential.identityToken,
      //   accessToken: appleCredential.authorizationCode,
      //   rawNonce: rawNonce,
      // );

      // var currentUser = FirebaseAuth.instance.currentUser;
      // if (currentUser != null) {
      //   emit(ProceedToHomeScreenState());
      // }
    }
    if (event is InitializeGoogleSignInEvent) {
      User? googleUser = await _signInWithGoogle();
      if (googleUser != null) {
        print(googleUser.email);
        emit(ProceedToHomeScreenState());
      }
    }
    emit(IdleSignInState());
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = userCredential.user;

        if (user != null) {
          await _saveUserToFirestore(user);
          String? token = await user.getIdToken();
        }
        return user;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
    return null;
  }

  Future<void> _saveUserToFirestore(User user) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final userDoc = firestore.collection('Users').doc(user.uid);

      // Check if the user already exists
      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        // Save user data
        await userDoc.set({
          'id': user.uid,
          'email': user.email,
          'username': user.displayName ?? "",
          'signInMethod': user.providerData[0].providerId,
          'createdAt': DateTime.now().toString(),
        });
      }
    } catch (e) {
      print("Error saving user to Firestore: $e");
    }
  }
}
