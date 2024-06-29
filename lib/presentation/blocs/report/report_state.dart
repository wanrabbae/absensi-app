part of 'report_cubit.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState({
    required XFile image,
    required ReportType type,
  }) = _ReportState;
}
