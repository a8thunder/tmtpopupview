import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tmt_popup/src/tmt_popup.dart';
import 'package:tmt_popup/src/widgets/tmt_popup_overlay_entry.dart';

class TMTPopupMain extends StatefulWidget {
  final Widget? child;

  const TMTPopupMain({
    super.key,
    required this.child,
  }) : assert(child != null);

  @override
  State<TMTPopupMain> createState() => _TMTPopupMainState();
}

class _TMTPopupMainState extends State<TMTPopupMain> {
  late TMTPopupOverlayEntry _tmtPopupOverlayEntry;
  final TMTPopup _popup = TMTPopup.instance;

  @override
  void initState() {
    _tmtPopupOverlayEntry =
        TMTPopupOverlayEntry(builder: (context) => _popup.w ?? Container());
    _popup.overlayEntry = _tmtPopupOverlayEntry;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          TMTPopupOverlayEntry(builder: (context) {
            if (widget.child != null) {
              return widget.child!;
            } else {
              return Container();
            }
          }),
          _tmtPopupOverlayEntry,
        ],
      ),
    );
  }
}
