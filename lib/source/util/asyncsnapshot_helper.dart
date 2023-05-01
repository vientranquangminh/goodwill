import 'package:flutter/material.dart';

class AsyncSnapshotHelper {
  static Widget handleAsyncSnapshot<T>(
    BuildContext context,
    AsyncSnapshot<T> snapshot, {
    Widget loadingWidget = const CircularProgressIndicator(),
    Widget? errorWidget,
    required Widget Function(T) onFinishFetchingData,
  }) {
    if (snapshot.hasError) {
      debugPrint("Error ${snapshot.error.toString()}");
      return ErrorWidget(snapshot.error.toString());
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loadingWidget;
    }
    return onFinishFetchingData(snapshot.data as T);
  }
}
