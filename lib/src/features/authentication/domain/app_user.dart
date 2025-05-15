// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Simple class representing the user UID and email.
class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    this.email,
  });
  final String uid;
  final String? email;

  @override
  List<Object> get props => [
        uid,
      ];

  @override
  bool get stringify => true;
}
