import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/sign_in/bloc/sign_in_event.dart';
import 'package:notes_app/sign_in/bloc/sign_in_state.dart';

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
    if (event is InitializeAppleSignInEvent) {}
    if (event is InitializeGoogleSignInEvent) {
      User? googleUser = await signInWithGoogle();
      if (googleUser != null) {
        print(googleUser.uid);
      }
    }
    emit(IdleSignInState());
  }

  Future<User?> signInWithGoogle() async {
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

        return userCredential.user;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
    return null;
  }
}
