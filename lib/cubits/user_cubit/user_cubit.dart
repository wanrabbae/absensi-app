import 'package:app/clients/DocumentClient.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> find({
    required String email,
    feature = 'find',
  }) async {
    try {
      emit(UserLoading());
      var userFm = UserFm(id: email);
      var result = await DocumentClient.instance().load<UserFm>(userFm);
      emit(UserOk(
        data: result,
        feature: feature,
      ));
    } catch (e) {
      emit(UserInitial());
    }
  }

  Future<void> store({
    feature = 'store',
    required UserFm data,
  }) async {
    try {
      emit(UserLoading());
      var result = await DocumentClient.instance().save(data);
      emit(UserOk(
        feature: feature,
      ));
    } catch (e) {
      emit(UserInitial());
    }
  }
}
