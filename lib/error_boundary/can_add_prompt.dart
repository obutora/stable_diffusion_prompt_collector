enum CanAddPrompt {
  init,
  noImg,
  noParentImg,
  noPrompt,
  ok,
}

extension Error on CanAddPrompt {
  String get errorText {
    switch (this) {
      case CanAddPrompt.init:
        return '';
      case CanAddPrompt.noImg:
        return 'No Image has been set yet';
      case CanAddPrompt.noParentImg:
        return 'No Parent Image has been set yet';
      case CanAddPrompt.noPrompt:
        return 'No Prompt has been set yet';
      default:
        return '';
    }
  }
}
