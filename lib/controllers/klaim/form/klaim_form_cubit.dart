import 'dart:io';

import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
  final keteranganController = TextEditingController();

  Future<void> submit(Profile profile) async {
    final idKaryawan = profile.idkaryawan!;
    final namaKaryawan = profile.name!;
    final keterangan = keteranganController.text;
    final idPerusahaan = profile.perusahaanId!;
    final namaPerusahaan = profile.perusahaan!;
    final file = File(state.file.path);

    emit(state.copyWith(busy: true, error: null));

    try {
      await api.submitReimburse(
        idKaryawan: idKaryawan,
        namaKaryawan: namaKaryawan,
        keterangan: keterangan,
        idPerusahaan: idPerusahaan,
        namaPerusahaan: namaPerusahaan,
        file: file,
      );

      emit(state.copyWith(busy: false));
    } on DioError catch (e) {
      emit(state.copyWith(busy: false, error: e.message));
    }
  }
}
