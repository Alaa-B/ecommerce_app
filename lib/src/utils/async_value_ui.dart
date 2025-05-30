import '../common_widgets/alert_dialogs.dart';
import '../localization/string_hardcoded.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogOnError(BuildContext ctx) {
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
          context: ctx, title: 'Error happen'.hardcoded, exception: error);
    }
  }
}
