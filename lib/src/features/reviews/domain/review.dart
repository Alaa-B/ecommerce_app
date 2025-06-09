// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Product review data
class Review extends Equatable {
  const Review({
    required this.score,
    required this.comment,
    required this.date,
  });
  final double score; // from 1 to 5
  final String comment;
  final DateTime date;

  @override
  List<Object?> get props => [score, comment, date];

  @override
  bool get stringify => true;
}
