import 'error_message_widget.dart';
import '../constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    // TODO: add shimmering effect 'shimmer package'
    return value.when(
      data: data,
      error: (error, st) => Center(child: ErrorMessageWidget(error.toString())),
      loading: () => Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
