enum HomeTab {
  hadir('Hadir'),
  izin('Izin'),
  klaim('Klaim');

  const HomeTab(this.tab);

  final String tab;

  bool get isHadir => this == HomeTab.hadir;

  bool get isIzin => this == HomeTab.izin;

  bool get isKlaim => this == HomeTab.klaim;
}
