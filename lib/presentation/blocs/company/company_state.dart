part of 'company_cubit.dart';

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState({
    @Default(Company()) Company company,
  }) = _CompanyState;

  factory CompanyState.fromJson(Map<String, dynamic> json) =>
      _$CompanyStateFromJson(json);
}
