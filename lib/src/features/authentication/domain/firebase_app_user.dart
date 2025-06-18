import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAppUser implements AppUser {
  FirebaseAppUser(this._user);
  final User _user;

  @override
  String get uid => _user.uid;
  @override
  String? get email => _user.email;

  @override
  bool get isVerified => _user.emailVerified;

  @override
  Future<void> sendEmailVerification() => _user.sendEmailVerification();

  @override
  List<Object> get props => [_user.uid, _user.emailVerified];

  @override
  bool get stringify => true;
}
