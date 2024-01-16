part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeTab.hadir) HomeTab tab,
    List<Klaim>? klaimList,
    String? klaimError,
  }) = _HomeState;
}
