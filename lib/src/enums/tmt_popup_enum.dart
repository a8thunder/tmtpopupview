/// popup style
enum TMTPopupStyle {
  floater,
  toast,
  popup,
  sheet,
}

/// popup position
enum TMTPopupPosition {
  top,
  center,
  bottom,
}

/// popup mask type
/// [none] default mask type, allow user interactions while popup is displayed
/// [clear] don't allow user interactions while popup is displayed
/// [black] don't allow user interactions while popup is displayed
/// [custom] while mask type is custom, maskColor should not be null
enum TMTPopupMaskType {
  none,
  clear,
  black,
  custom,
}

/// popup animation
enum TMTPopupAnimationStyle {
  opacity,
  offset,
  scale,
  custom,
}

/// popup status
enum EasyLoadingStatus {
  show,
  dismiss,
}
