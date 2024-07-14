enum HomeTab {
  hadir('present'),
  izin('permit'),
  klaim('claim');

  const HomeTab(this.tab);

  final String tab;

  bool get isHadir => this == HomeTab.hadir;

  bool get isIzin => this == HomeTab.izin;

  bool get isKlaim => this == HomeTab.klaim;
}

enum PageStatus {
  idle,
  busy,
  canceled,
  succeed,
  failed;

  bool get isBusy => this == PageStatus.busy;

  bool get isCanceled => this == PageStatus.canceled;

  bool get isSucceed => this == PageStatus.succeed;

  bool get isFailed => this == PageStatus.failed;
}
