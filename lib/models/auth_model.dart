import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishing_match/models/shared_model.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    UserCredential result =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    SharedModel.saveLoggedIn(true);
    SharedModel.saveUid(user!.uid);
    SharedModel.saveUserEmail(user.email ?? '');

    return user;
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      SharedModel.saveLoggedIn(true);
      SharedModel.saveUid(user!.uid);
      SharedModel.saveUserEmail(user.email ?? '');

      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    await SharedModel.saveLoggedIn(false);
    await SharedModel.saveUserEmail('');
    await SharedModel.saveUid('');
    return await _auth.signOut();
  }
}
