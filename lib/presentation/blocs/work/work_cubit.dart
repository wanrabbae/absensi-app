import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/data/models/laporan/laporan.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_state.dart';

part 'work_cubit.freezed.dart';

class WorkCubit extends Cubit<WorkState> {
  WorkCubit(this.api, Profile user)
      : super(WorkState(user: user, selectedDate: DateTime.now()));

  final ApiService api;

  selectDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
    getReimbursement();
    getLaporan();
  }

  Future<void> getReimbursement() async {
    final String idPerusahaan = state.user.perusahaanId!;
    emit(state.copyWith(klaimError: null, klaimList: null));
    final DateTime d = state.selectedDate;
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
        error = e.message ?? 'Failed to get reimbursement data';
      }
      emit(state.copyWith(klaimError: error));
    }
  }

  Future<void> getLaporan() async {
    final String idPerusahaan = state.user.perusahaanId!;
    emit(state.copyWith(laporanError: null, laporanList: null));
    final DateTime d = state.selectedDate;
    DateTime start = DateTime(d.year, d.month, d.day);
    DateTime end = DateTime(d.year, d.month, d.day, 23, 59, 59);
    try {
      final results = await api.getLaporan(
        idPerusahaan: idPerusahaan,
        start: start.toUtc().toIso8601String(),
        end: end.toUtc().toIso8601String(),
      );
      emit(state.copyWith(laporanList: results));
    } catch (e) {
      String error = e.toString();
      if (e is DioError) {
        error = e.message ?? 'Failed to get laporan data';
      }
      emit(state.copyWith(laporanError: error));
    }
  }
}
