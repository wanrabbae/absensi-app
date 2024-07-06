part of 'present_form_cubit.dart';

@freezed
class PresentFormState with _$PresentFormState {
  const factory PresentFormState({
    required Profile user,
    Absence? currentAttendance,
    @Default(LatLng(3.5729021, 98.6292165)) LatLng currentLocation,
    @Default('') String address,
    @Default(true) bool isCheckingIn,
    @Default(PageStatus.idle) PageStatus submitAttendanceStatus,
  }) = _PresentFormState;
}
