import 'package:app/data/models/absence.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'present_detail_cubit.freezed.dart';
part 'present_detail_state.dart';

class PresentDetailCubit extends Cubit<PresentDetailState> {
  PresentDetailCubit(
    this.api,
    this.firebase, {
    required Absence data,
  }) : super(PresentDetailState(data: data));

  final ApiService api;
  final FirebaseService firebase;
}
