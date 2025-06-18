// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Simple class representing the user UID and email.
class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.email,
    this.isVerified = false,
  });
  final String uid;
  final String? email;
  final bool isVerified;
  Future<void> sendEmailVerification() async {
    // no-op - implemented by subclasses
  }
  @override
  List<Object> get props => [uid, isVerified];

  @override
  bool get stringify => true;
}
