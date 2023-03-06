import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../services/user_service.dart';

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  final result =
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

  if (result.additionalUserInfo!.isNewUser) {
    await result.user?.updatePhotoURL(
        "${result.user!.photoURL}?height=500&access_token=${result.credential!.accessToken}");
    await UserService().insertUser(result.user);
  }
  return result;
}
