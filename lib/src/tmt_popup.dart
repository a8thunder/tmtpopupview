import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmt_popup/main.dart';
import 'package:tmt_popup/src/enums/tmt_popup_enum.dart';
import 'package:tmt_popup/src/styles/tmt_popup_theme.dart';
import 'package:tmt_popup/src/widgets/tmt_popup_container.dart';
import 'package:tmt_popup/src/widgets/tmt_popup_overlay_entry.dart';

class TMTPopup {
  /// loading style, default [TMTPopupStyle.dark].
  late TMTPopupStyle loadingStyle;

  /// loading mask type, default [TMTPopupMaskType.none].
  late TMTPopupMaskType maskType;

  /// toast position, default [TMTPopupPosition.center].
  late TMTPopupPosition toastPosition;

  /// loading animationStyle, default [TMTPopupAnimationStyle.opacity].
  late TMTPopupAnimationStyle animationStyle;

  /// textAlign of status, default [TextAlign.center].
  late TextAlign textAlign;

  /// radius of loading, default 5.0.
  late double radius;

  /// fontSize of loading, default 15.0.
  late double fontSize;

  /// width of indicator, default 4.0, only used for [TMTPopupIndicatorType.ring, TMTPopupIndicatorType.dualRing].
  late double lineWidth;

  /// display duration of [showSuccess] [showError] [showInfo] [showToast], default 2000ms.
  late Duration displayDuration;

  /// animation duration of indicator, default 200ms.
  late Duration animationDuration;

  /// textStyle of status, default null.
  TextStyle? textStyle;

  /// content padding of popup.
  late EdgeInsets contentPadding;

  /// padding of [status].
  late EdgeInsets textPadding;

  /// color of popup status, only used for [TMTPopupStyle.custom].
  Color? textColor;

  /// color of popup indicator, only used for [TMTPopupStyle.custom].
  Color? indicatorColor;

  /// progress color of popup, only used for [TMTPopupStyle.custom].
  Color? progressColor;

  /// background color of popup, only used for [TMTPopupStyle.custom].
  Color? backgroundColor;

  /// boxShadow of popup, only used for [TMTPopupStyle.custom].
  List<BoxShadow>? boxShadow;

  /// mask color of popup, only used for [TMTPopupMaskType.custom].
  Color? maskColor;

  /// should allow user interactions while popup is displayed.
  bool? userInteractions;

  /// should dismiss on user tap.
  bool? dismissOnTap;

  /// floater widget of popup
  Widget? floaterWidget;

  Widget? _w;

  Timer? _timer;

  TMTPopupOverlayEntry? overlayEntry;

  factory TMTPopup() => _instance;
  static final TMTPopup _instance = TMTPopup._internal();

  Widget? get w => _w;
  static TMTPopup get instance => _instance;
  static bool get isShow => _instance.w != null;

  TMTPopup._internal() {
    /// set default value
    loadingStyle = TMTPopupStyle.floater;
    maskType = TMTPopupMaskType.none;
    toastPosition = TMTPopupPosition.center;
    animationStyle = TMTPopupAnimationStyle.opacity;
    textAlign = TextAlign.center;
    radius = 5.0;
    fontSize = 15.0;
    lineWidth = 4.0;
    displayDuration = const Duration(milliseconds: 2000);
    animationDuration = const Duration(milliseconds: 200);
    textPadding = const EdgeInsets.only(bottom: 10.0);
    contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    );
  }

  /// init EasyLoading
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, TMTPopupMain(child: child));
      } else {
        return TMTPopupMain(child: child);
      }
    };
  }

  /// dismiss loading
  static Future<void> dismiss({
    bool animation = true,
  }) {
    // cancel timer
    _instance._cancelTimer();
    return _instance._dismiss(animation);
  }

  /// showToast [status] [duration] [toastPosition] [maskType]
  static Future<void> showToast(
    String status, {
    Duration? duration,
    TMTPopupPosition? toastPosition,
    TMTPopupMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return TMTPopup.instance._show(
      status: status,
      duration: duration ?? TMTPopupTheme.displayDuration,
      toastPosition: toastPosition ?? TMTPopupTheme.toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  /// show [status] [duration] [toastPosition] [maskType]
  Future<void> _show({
    Widget? w,
    String? status,
    Duration? duration,
    TMTPopupMaskType? maskType,
    bool? dismissOnTap,
    TMTPopupPosition? toastPosition,
  }) async {
    assert(
      overlayEntry != null,
      'You should call EasyLoading.init() in your MaterialApp',
    );
    maskType ??= _instance.maskType;
    toastPosition ??= TMTPopupPosition.center;
    bool animation = _w == null;

    Completer<void> completer = Completer<void>();
    _w = TMTPopupContainer(
      status: status,
      indicator: w,
      animation: animation,
      toastPosition: toastPosition,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
      completer: completer,
    );

    completer.future.whenComplete(() {
      // _callback(EasyLoadingStatus.show);
      if (duration != null) {
        _cancelTimer();
        _timer = Timer(duration, () async {
          await dismiss();
        });
      }
    });
    _markNeedsBuild();
    return completer.future;
  }

  Future<void> _dismiss(bool animation) async {
    // if (key != null && key?.currentState == null) {
    //   _reset();
    //   return;
    // }

    // return key?.currentState?.dismiss(animation).whenComplete(() {
    //   _reset();
    // });
    _reset();
  }

  void _reset() {
    _w = null;
    // _key = null;
    // _progressKey = null;
    _cancelTimer();
    _markNeedsBuild();
    // _callback(EasyLoadingStatus.dismiss);
  }

  // void _callback(EasyLoadingStatus status) {
  //   for (final EasyLoadingStatusCallback callback in _statusCallbacks) {
  //     callback(status);
  //   }
  // }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}

extension TMTPopupConfig on TMTPopup {}
