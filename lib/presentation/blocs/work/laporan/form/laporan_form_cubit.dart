import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'laporan_form_cubit.freezed.dart';
part 'laporan_form_state.dart';

class LaporanFormCubit extends Cubit<LaporanFormState> {
  LaporanFormCubit({
    required this.api,
    required this.profile,
    required XFile file,
  }) : super(LaporanFormState(file: file)) {
    fetchKaryawanList().then((_) => getCurrentLocation());
  }

  final ApiService api;
  final Profile profile;
  CancelToken? _cancelToken;

  void setFile(XFile file) {
    emit(state.copyWith(file: file));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void setTag(String tag) {
    emit(state.copyWith(tag: tag));
  }

  void cancelSubmit() {
    _cancelToken?.cancel();
  }

  Future<void> fetchKaryawanList() async {
    try {
      final users = await api.getKaryawanList(
        idPerusahaan: profile.perusahaanId!,
      );
      if (isClosed) return;
      emit(state.copyWith(users: users));
    } catch (_) {}
  }

  Future<void> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 5),
    );
    final location = LatLng(position.latitude, position.longitude);
    final places = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    final p = places.isNotEmpty ? places.first : null;
    final address = p != null
        ? '${p.street}, ${p.subLocality}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.postalCode}'
        : '';
    if (isClosed) return;
    emit(state.copyWith(currentLocation: location, address: address));
  }

  Future<void> submit() async {
    final idKaryawan = profile.idkaryawan!;
    final namaKaryawan = profile.name!;
    final keterangan = state.description;
    final idPerusahaan = profile.perusahaanId!;
    final namaPerusahaan = profile.perusahaan!;
    final file = File(state.file.path);
    final latitude = state.currentLocation.latitude.toString();
    final longitude = state.currentLocation.longitude.toString();
    final lokasi = state.address;
    final tag = state.tag;

    emit(state.copyWith(submit: StateSubmit.busy, error: null));

    try {
      _cancelToken = CancelToken();
      await api.submitLaporan(
        idKaryawan: idKaryawan,
        namaKaryawan: namaKaryawan,
        idPerusahaan: idPerusahaan,
        namaPerusahaan: namaPerusahaan,
        file: file,
        keterangan: keterangan,
        latitude: latitude,
        longitude: longitude,
        lokasi: lokasi,
        tag: tag,
        cancelToken: _cancelToken,
      );

      emit(state.copyWith(submit: StateSubmit.succeed));
    } on DioError catch (e) {
      emit(
        state.copyWith(submit: StateSubmit.failed, error: e.message),
      );
    }
  }
}
