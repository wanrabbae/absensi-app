import 'dart:io';

import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'klaim_form_cubit.freezed.dart';

part 'klaim_form_state.dart';

class KlaimFormCubit extends Cubit<KlaimFormState> {
  KlaimFormCubit({
    required this.api,
    required XFile file,
  }) : super(KlaimFormState(file: file));

  final ApiService api;
  CancelToken? _cancelToken;

  void setFile(XFile file) {
    emit(state.copyWith(file: file));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void cancelSubmit() {
    _cancelToken?.cancel();
  }

  Future<void> submit(Profile profile) async {
    final idKaryawan = profile.idkaryawan!;
    final namaKaryawan = profile.name!;
    final keterangan = state.description;
    final idPerusahaan = profile.perusahaanId!;
    final namaPerusahaan = profile.perusahaan!;
    final file = File(state.file.path);

    emit(state.copyWith(submit: ReimburseStateSubmit.busy, error: null));

    try {
      _cancelToken = CancelToken();
      await api.submitReimburse(
        idKaryawan: idKaryawan,
        namaKaryawan: namaKaryawan,
        keterangan: keterangan,
        idPerusahaan: idPerusahaan,
        namaPerusahaan: namaPerusahaan,
        file: file,
        cancelToken: _cancelToken,
      );

      emit(state.copyWith(submit: ReimburseStateSubmit.succeed));
    } on DioError catch (e) {
      emit(
        state.copyWith(submit: ReimburseStateSubmit.failed, error: e.message),
      );
    }
  }
}
