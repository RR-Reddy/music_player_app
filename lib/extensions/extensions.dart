import 'package:flutter/material.dart';

/// Extension Utilities of [Duration]
extension DurationExtension on Duration {
  /// converting duration to human readable format 
  /// format  hours:minutes:seconds
  String toReadableString() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.inSeconds.remainder(60));

    return this.inHours == 0
        ? "$twoDigitMinutes:$twoDigitSeconds"
        : "${twoDigits(this.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

/// Extension Utilities of [BuildContext]
/// [BuildContextExtension]  are useful in writing short hand code in layouts
extension BuildContextExtension on BuildContext {
  /// returns screen width percentage [of]
  /// [of] param range is 0.0 to 1.0
  double widthOf(double of) => MediaQuery.of(this).size.width * of;

  /// returns current themeData
  ThemeData get themeData => Theme.of(this);
}
