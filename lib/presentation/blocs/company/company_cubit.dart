import 'package:app/data/models/company.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'company_cubit.freezed.dart';
part 'company_cubit.g.dart';
part 'company_state.dart';

class CompanyCubit extends HydratedCubit<CompanyState> {
  CompanyCubit(this.api, this.box) : super(const CompanyState());

  final ApiService api;
  final GetStorage box;

  void reset() => emit(const CompanyState());

  Future<void> getCompany() async {
    final user = box.read(Base.dataUser);
    final email = user?['alamatEmail'];
    if (email is String) {
      try {
        final companies = await api.getCompany(email: email);
        if (!isClosed && companies.isNotEmpty) {
          emit(state.copyWith(company: companies.first));
        }
      } catch (_) {}
    }
  }

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
