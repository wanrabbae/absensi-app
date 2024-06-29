part of 'report_cubit.dart';

enum ReportStateSubmit { busy, failed, succeed, canceled }

@freezed
class ReportState with _$ReportState {
  const factory ReportState({
    required XFile image,
    required ReportType type,
    @Default('') String description,
    ReportStateSubmit? submit,
  }) = _ReportState;
}
