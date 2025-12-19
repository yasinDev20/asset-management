import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthEventListener {
  void firebaseAuthEventListener(void Function(AuthEvent) add); 
  void googleSignInEventListener(void Function(AuthEvent) add);
}

class AuthEventListenerImpl implements AuthEventListener {
  @override
  void firebaseAuthEventListener(void Function(AuthEvent) add) {
    final firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        add(AuthLoggedOutEvent());
      } else {
        add(AuthLoggedInEvent(userId: user.uid));
      }
    });
  }

  @override
  void googleSignInEventListener(void Function(AuthEvent p1) add) {
    final googleSignInPackage = GoogleSignIn.instance;
    googleSignInPackage.authenticationEvents.listen((event) async {
      final user = switch (event) {
        GoogleSignInAuthenticationEventSignIn(:final user) => user,
        GoogleSignInAuthenticationEventSignOut() => null,
      };

      if (user != null) {
        add(GoogleSignInEvent(googleSignInAccaount: user));
      }
    });
  }
}
