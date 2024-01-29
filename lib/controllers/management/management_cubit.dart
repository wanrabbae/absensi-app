import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'management_cubit.freezed.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  ManagementCubit(this.api, this.profile)
      : super(const ManagementState.initial());

  final ApiService api;
  final Profile profile;

  Future<void> sendReportAbsensi(
    DateTimeRange range,
    ValueChanged<String> onDone,
  ) async {
    final start = range.start.toUtc().toIso8601String();
    final end = range.end.toUtc().toIso8601String();

    try {
      final response = await api.sendReport(
        idPerusahaan: profile.perusahaanId!,
        start: start,
        end: end,
        email: profile.email!,
      );
      onDone(response);
    } on DioError catch (e) {
      onDone(e.message);
    }
  }

  Future<void> sendReportCuti(
    DateTimeRange range,
    ValueChanged<String> onDone,
  ) => _sendReport(range, onDone, 'Cuti');

  Future<void> sendReportIzin(
    DateTimeRange range,
    ValueChanged<String> onDone,
  ) => _sendReport(range, onDone, 'Izin');

  Future<void> sendReportSakit(
    DateTimeRange range,
    ValueChanged<String> onDone,
  ) => _sendReport(range, onDone, 'Sakit');

  Future<void> _sendReport(
    DateTimeRange range,
    ValueChanged<String> onDone,
    String status,
  ) async {
    final start = range.start.toUtc().toIso8601String();
    final end = range.end.toUtc().toIso8601String();

    try {
      final response = await api.sendReportIzin(
        idPerusahaan: profile.perusahaanId!,
        start: start,
        end: end,
        email: profile.email!,
        status: status,
      );
      onDone(response);
    } on DioError catch (e) {
      onDone(e.message);
    }
  }
}
