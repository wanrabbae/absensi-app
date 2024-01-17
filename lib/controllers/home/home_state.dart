part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    String? idPerusahaan,
    @Default(HomeTab.hadir) HomeTab tab,
    required DateTime dateTime,
    List<Klaim>? klaimList,
    String? klaimError,
  }) = _HomeState;
}
