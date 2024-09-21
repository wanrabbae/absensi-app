import 'package:app/data/models/agenda/agenda.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_form_state.dart';

part 'agenda_form_cubit.freezed.dart';

class AgendaFormCubit extends Cubit<AgendaFormState> {
  AgendaFormCubit({
    required this.api,
    required this.profile,
  }) : super(const AgendaFormState());

  final ApiService api;
  final Profile profile;
  CancelToken? _cancelToken;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void setAutoValidateMode(AutovalidateMode autoValidateMode) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }

  void cancelSubmit() {
    _cancelToken?.cancel();
  }

  Future<void> submit() async {
    final idKaryawan = profile.idkaryawan!;
    final namaKaryawan = profile.name;
    final idPerusahaan = profile.perusahaanId!;
    final namaPerusahaan = profile.perusahaan!;
    final tanggal = DateTime.now().toIso8601String().substring(0, 10);
    final title = titleController.text;
    final description = descriptionController.text;

    emit(state.copyWith(submit: StateSubmit.busy, error: null));

    try {
      _cancelToken = CancelToken();
      final request = AgendaMutable(
        namaKaryawan: namaKaryawan,
        keterangan: description,
        tanggal: tanggal,
        namaPerusahaan: namaPerusahaan,
        idperusahaan: idPerusahaan,
        judul: title,
      );
      final response = await api.submitAgenda(
        idKaryawan: idKaryawan,
        request: request,
        cancelToken: _cancelToken,
      );

      if (response.data.toString() == 'Hanya bisa di akses oleh Admin') {
        emit(
          state.copyWith(
            submit: StateSubmit.failed,
            error: tr('agenda_bottom_sheet_info_message_failed_admin'),
          ),
        );
        return;
      }

      emit(state.copyWith(submit: StateSubmit.succeed));
    } on DioError catch (e) {
      emit(
        state.copyWith(submit: StateSubmit.failed, error: e.message),
      );
    }
  }
}
