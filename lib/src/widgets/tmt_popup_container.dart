import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmt_popup/src/enums/tmt_popup_enum.dart';

class TMTPopupContainer extends StatefulWidget {
  final Widget? indicator;
  final String? status;
  final bool? dismissOnTap;
  final TMTPopupPosition? toastPosition;
  final TMTPopupMaskType? maskType;
  final Completer<void>? completer;
  final bool animation;

  const TMTPopupContainer({
    super.key,
    this.indicator,
    this.status,
    this.dismissOnTap,
    this.toastPosition,
    this.maskType,
    this.completer,
    required this.animation,
  });

  @override
  State<TMTPopupContainer> createState() => _TMTPopupContainerState();
}

class _TMTPopupContainerState extends State<TMTPopupContainer> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'HELLO WORLD',
        style: TextStyle(color: Colors.red, fontSize: 30),
      ),
    );
  }
}
