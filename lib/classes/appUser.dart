import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '/loginPages/auth_service.dart';
import '/main.dart';

class Appuser extends GetxController {
  String? _email;
  String? get email => _email;
  User? _user;
  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Appuser() {
    handleAuthState();
  }

  Future<void> signIn(User user) async {
    if (user.email == null) {
      _email = user.phoneNumber;
    } else {
      _email = user.email!;
    }
    _user = user;
    print("updated");
    update();
  }

  Future<void> signInEmail(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    signIn(userCredential.user!);
  }

  Future<void> signUpEmail(
      {required String email, required String password}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    signIn(credential.user!);
  }

  Future<void> signInFacebook() async {
    UserCredential user = await Authservice.signInWithFacebook();
    signIn(user.user!);
  }

  Future<void> signInGoogle() async {
    UserCredential user = await Authservice.signInWithGoogle();
    signIn(user.user!);
  }

  Future<void> signOut() async {
    _user = null;
    update();
  }

  Future<void> signInPhone({
    required String phone,
    required void Function(String? errorMessage) verificationFailed,
    required void Function(PhoneVerifier verifier) codeSent,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        verificationFailed(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(PhoneVerifier(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void handleAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signOut();
        print('User is currently signed out!');
      } else {
        signIn(user);
        print('User is signed in!');
      }
    });
  }
}

class PhoneVerifier {
  String verificationID;

  PhoneVerifier(this.verificationID);

  Future<void> verifyOTP(String otpText) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpText);

    await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) {
        stateCurrentUser.signIn(value.user!);
      },
    );
  }
}
