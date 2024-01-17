import 'package:app/core/enums.dart';
import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeState(dateTime: DateTime.now()));

  final ApiService api;

  setHomeTab(HomeTab tab) => emit(state.copyWith(tab: tab));

  setDateTime(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));
    final idPerusahaan = state.idPerusahaan;
    if (idPerusahaan != null) {
      getDataKlaim(idPerusahaan);
    }
  }

  Future<void> getDataKlaim(String idPerusahaan) async {
    emit(state.copyWith(
      idPerusahaan: idPerusahaan,
      klaimError: null,
      klaimList: null,
    ));
    final DateTime d = state.dateTime;
    DateTime start = DateTime(d.year, d.month, d.day);
    DateTime end = DateTime(d.year, d.month, d.day, 23, 59, 59);
    try {
      final results = await api.getReimburse(
        idPerusahaan: idPerusahaan,
        start: start.toUtc().toIso8601String(),
        end: end.toUtc().toIso8601String(),
      );
      emit(state.copyWith(klaimList: results));
    } catch (e) {
      String error = e.toString();
      if (e is DioError) {
        error = e.message;
      }
      emit(state.copyWith(klaimError: error));
    }
  }
}
