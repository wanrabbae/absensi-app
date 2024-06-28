import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/data/models/absence.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_state.dart';

part 'office_cubit.freezed.dart';

part 'office_cubit.g.dart';

class OfficeCubit extends Cubit<OfficeState> {
  OfficeCubit(this.api) : super(const OfficeState());

  final app = $it<AppCubit>();
  final ApiService api;

  void selectDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
    reloadData();
  }

  Future<void> reloadData() {
    if (state.selectedDate == null) {
      emit(state.copyWith(selectedDate: DateTime.now()));
    }

    return reloadAttendance();
  }

  Future<void> reloadAttendance() {
    return getCurrentAttendance().then((_) {
      return getCurrentAttendanceList();
    });
  }

  Future<void> getCurrentAttendance() async {
    final user = app.state.currentUser;
    if (user == null) return;

    final idkaryawan = user.idkaryawan;
    if (idkaryawan == null) return;

    final DateTime date = state.selectedDate!;
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

      if (state.selectedDate == null) {
        emit(state.copyWith(
          selectedDate: date,
          attendance: OfficeAttendance(currentAttendance: attendances.first),
        ));
      } else {
        emit(state.copyWith(
          attendance: OfficeAttendance(currentAttendance: attendances.first),
        ));
      }
    }, onError: (_, __) {
      emit(state.copyWith(attendance: const OfficeAttendance()));
    });
  }

  Future<void> getCurrentAttendanceList() async {
    final company = app.state.company;
    final idperusahaan = company.id;

    final DateTime date = state.selectedDate!;

    final tglStart = DateTime(date.year, date.month, date.day).toUtc();
    final start = kQueryRangeDateFormat.format(tglStart);

    final tglEnd =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    final end = kQueryRangeDateFormat.format(tglEnd);

    return api
        .getAttendanceList(idperusahaan: idperusahaan, start: start, end: end)
        .then((attendances) {
      emit(state.copyWith(
        attendance: state.attendance.copyWith(
          listAttendance: attendances,
          error: null,
        ),
      ));
    }, onError: (e, __) {
      emit(state.copyWith(
        attendance: state.attendance.copyWith(
          listAttendance: null,
          error: e is DioError ? e.message ?? 'Error' : 'Data not found',
        ),
      ));
    });
  }
}
