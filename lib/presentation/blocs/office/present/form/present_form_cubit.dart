import 'package:app/data/models/absence.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'present_form_state.dart';

part 'present_form_cubit.freezed.dart';

class PresentFormCubit extends Cubit<PresentFormState> {
  PresentFormCubit({
    required this.api,
    Absence? currentAttendance,
  }) : super(PresentFormState(currentAttendance: currentAttendance));

  final ApiService api;
}
