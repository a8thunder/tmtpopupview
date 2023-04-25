import 'package:tmt_popup/src/enums/tmt_popup_enum.dart';
import 'package:tmt_popup/src/tmt_popup.dart';

class TMTPopupTheme {
  /// display duration
  static Duration get displayDuration => TMTPopup.instance.displayDuration;

  /// display duration
  static TMTPopupPosition get toastPosition => TMTPopup.instance.toastPosition;
}
