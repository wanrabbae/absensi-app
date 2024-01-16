import 'package:app/core/enums.dart';
import 'package:app/data/models/klaim/klaim.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  setHomeTab(HomeTab tab) => emit(state.copyWith(tab: tab));

  Future<void> getDataKlaim() async {
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(klaimList: [], klaimError: null));
  }
}
