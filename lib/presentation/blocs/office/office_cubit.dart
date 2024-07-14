import 'package:app/data/models/absence.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/models/report/report.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_state.dart';

part 'office_cubit.freezed.dart';

part 'office_cubit.g.dart';

class OfficeCubit extends Cubit<OfficeState> {
  OfficeCubit(
    this.api, {
    required Profile user,
    required Company company,
  }) : super(OfficeState(
          user: user,
          company: company,
          selectedDate: DateTime.now().copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          ),
        ));

  final ApiService api;

  void selectDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
    reloadData();
  }

  Future<void> reloadData() {
    return reloadAttendance().then((_) {
      return getCurrentLeaveList();
    }).then((_) {
      return getCurrentPermitList();
    }).then((_) {
      return getCurrentSickList();
    });
  }

  Future<void> reloadAttendance() {
    return getCurrentAttendance().then((_) {
      return getCurrentAttendanceList();
    });
  }

  Future<void> getCurrentAttendance() async {
    final user = state.user;
    final idkaryawan = user.idkaryawan;
    if (idkaryawan == null) return;

    final DateTime date = state.selectedDate;
    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getAttendance(idkaryawan: idkaryawan, start: start, end: end)
        .then((attendances) {
      if (attendances.isEmpty) {
        emit(state.copyWith(attendance: const OfficeAttendance()));
        return;
      }

      emit(state.copyWith(
        attendance: OfficeAttendance(currentAttendance: attendances.first),
      ));
    }, onError: (_, __) {
      emit(state.copyWith(attendance: const OfficeAttendance()));
    });
  }

  Future<void> getCurrentAttendanceList() async {
    final user = state.user;
    final idKaryawan = user.idkaryawan;

    final company = state.company;
    final idperusahaan = company.id;

    final DateTime date = state.selectedDate;

    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getAttendanceList(idperusahaan: idperusahaan, start: start, end: end)
        .then((attendances) {
      final current = state.attendance.currentAttendance ??
          attendances.firstWhereOrNull((a) => a.idKaryawan == idKaryawan);
      if (isClosed) return;
      emit(state.copyWith(
        attendance: state.attendance.copyWith(
          currentAttendance: current,
          listAttendance: attendances,
          error: null,
        ),
      ));
    }, onError: (e, __) {
      if (isClosed) return;
      emit(state.copyWith(
        attendance: state.attendance.copyWith(
          listAttendance: null,
          error: e is DioError ? e.message ?? 'Error' : 'Data not found',
        ),
      ));
    });
  }

  Future<void> getCurrentLeaveList() async {
    final company = state.company;
    final idperusahaan = company.id;

    final DateTime date = state.selectedDate;

    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getLeaveList(idperusahaan: idperusahaan, start: start, end: end)
        .then((leaves) {
      if (isClosed) return;
      emit(state.copyWith(
        leave: state.leave.copyWith(
          listLeave: leaves,
          error: null,
        ),
      ));
    }, onError: (e, __) {
      if (isClosed) return;
      emit(state.copyWith(
        leave: state.leave.copyWith(
          listLeave: null,
          error: e is DioError ? e.message ?? 'Error' : 'Data not found',
        ),
      ));
    });
  }

  Future<void> getCurrentPermitList() async {
    final company = state.company;
    final idperusahaan = company.id;

    final DateTime date = state.selectedDate;

    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getPermitList(idperusahaan: idperusahaan, start: start, end: end)
        .then((permits) {
      if (isClosed) return;
      emit(state.copyWith(
        permit: state.permit.copyWith(
          listPermit: permits,
          error: null,
        ),
      ));
    }, onError: (e, __) {
      if (isClosed) return;
      emit(state.copyWith(
        permit: state.permit.copyWith(
          listPermit: null,
          error: e is DioError ? e.message ?? 'Error' : 'Data not found',
        ),
      ));
    });
  }

  Future<void> getCurrentSickList() async {
    final company = state.company;
    final idperusahaan = company.id;

    final DateTime date = state.selectedDate;

    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getSickList(idperusahaan: idperusahaan, start: start, end: end)
        .then((sicks) {
      if (isClosed) return;
      emit(state.copyWith(
        sick: state.sick.copyWith(
          listSick: sicks,
          error: null,
        ),
      ));
    }, onError: (e, __) {
      if (isClosed) return;
      emit(state.copyWith(
        sick: state.sick.copyWith(
          listSick: null,
          error: e is DioError ? e.message ?? 'Error' : 'Data not found',
        ),
      ));
    });
  }
}
