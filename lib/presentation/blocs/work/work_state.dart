part of 'work_cubit.dart';

@freezed
class WorkState with _$WorkState {
  const factory WorkState({
    required Profile user,
    required DateTime selectedDate,
    List<Klaim>? klaimList,
    String? klaimError,
    List<Laporan>? laporanList,
    String? laporanError,
  }) = _WorkState;
}
