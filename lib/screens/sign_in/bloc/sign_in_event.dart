sealed class SignInEvent {
  const SignInEvent();
}

class InitializeGoogleSignInEvent extends SignInEvent {
  const InitializeGoogleSignInEvent();
}

class InitializeAppleSignInEvent extends SignInEvent {
  const InitializeAppleSignInEvent();
}
