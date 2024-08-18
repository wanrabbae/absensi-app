import 'package:app/data/models/company.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'company_cubit.freezed.dart';
part 'company_state.dart';

class CompanyCubit extends HydratedCubit<CompanyState> {
  CompanyCubit(this.apiService) : super(const CompanyState());

  final ApiService apiService;

  @override
  CompanyState? fromJson(Map<String, dynamic> json) {
    try {
      return CompanyState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CompanyState state) {
    return state.toJson();
  }
}
