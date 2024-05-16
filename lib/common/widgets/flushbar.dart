import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum FlushbarStatus {
  success,
  error,
  common,
}

void showSnackBar(BuildContext context, {FlushbarStatus status = FlushbarStatus.common, String? message}) {
  switch (status) {
    case FlushbarStatus.success:
      successFlushBar(
        context,
        message: message,
      ).show(context);

    case FlushbarStatus.error:
      errorFlushbar(
        context,
        message: message,
      ).show(context);

    case FlushbarStatus.common:
      commonFlushBar(
        context,
        message: message,
      ).show(context);
  }
}

Flushbar errorFlushbar(BuildContext context, {String? message}) {
  return Flushbar(
    title: 'Error',
    titleColor: Theme.of(context).colorScheme.error,
    messageColor: Theme.of(context).colorScheme.outline,
    message: message ?? 'Something went wrong',
    margin: const EdgeInsets.all(16.0),
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(8.0),
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    duration: const Duration(seconds: 7),
  );
}

Flushbar successFlushBar(BuildContext context, {String? message}) {
  return Flushbar(
    title: 'Success',
    titleColor: Theme.of(context).colorScheme.tertiaryContainer,
    message: message,
    messageColor: Theme.of(context).colorScheme.outline,
    margin: const EdgeInsets.all(16.0),
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(8.0),
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    duration: const Duration(seconds: 7),
  );
}

Flushbar commonFlushBar(BuildContext context, {String? message}) {
  return Flushbar(
    title: 'Info',
    titleColor: Theme.of(context).colorScheme.primary,
    message: message,
    messageColor: Theme.of(context).colorScheme.outline,
    margin: const EdgeInsets.all(16.0),
    flushbarPosition: FlushbarPosition.TOP,
    borderColor: Colors.grey,
    borderRadius: BorderRadius.circular(8.0),
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    duration: const Duration(seconds: 7),
  );
}
