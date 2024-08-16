part of 'laporan_form_cubit.dart';

@freezed
class LaporanFormState with _$LaporanFormState {
  const factory LaporanFormState({
    required XFile file,
    @Default([]) List<Profile> users,
    @Default('') String description,
    @Default('') String tag,
    @Default(LatLng(3.5729021, 98.6292165)) LatLng currentLocation,
    @Default('') String address,
    String? error,
    StateSubmit? submit,
  }) = _LaporanFormState;
}
