import 'package:app/data/models/company.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/models/report/report.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_state.dart';

part 'report_cubit.freezed.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({
    required XFile image,
    required ReportType type,
    required this.user,
    required this.company,
  }) : super(ReportState(image: image, type: type));

  final ApiService api = $it();
  final Profile user;
  final Company company;
  CancelToken? _cancelToken;

  void setImage(XFile image) {
    emit(state.copyWith(image: image));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> submit() async {
    emit(state.copyWith(submit: ReportStateSubmit.busy));

    try {
      _cancelToken = CancelToken();
      final result = await api.submitReport(
        idKaryawan: user.idkaryawan!,
        namaKaryawan: user.name,
        description: state.description,
        type: state.type.status,
        file: File(state.image.path),
        idPerusahaan: company.id,
        namaPerusahaan: company.name,
        cancelToken: _cancelToken,
      );
      if (result.toString().contains('Request Entity Too Large')) {
        emit(state.copyWith(submit: ReportStateSubmit.failed));
      } else {
        emit(state.copyWith(submit: ReportStateSubmit.succeed));
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.cancel) {
        emit(state.copyWith(submit: ReportStateSubmit.canceled));
      } else {
        emit(state.copyWith(submit: ReportStateSubmit.failed));
      }
    }
  }

  void cancelSubmit() {
    _cancelToken?.cancel();
  }
}
