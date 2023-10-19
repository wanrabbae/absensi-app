import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:intl/intl.dart';

part 'user_fm.flamingo.dart';

class UserFm extends Document<UserFm> {
  UserFm({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
  }) : super(id: id, snapshot: snapshot, values: values);

  @Field()
  String? idkaryawan;
  @Field()
  GeoPoint? location;
  @Field()
  bool? isLive;

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);

  String? get getFormattedDate {
    final date = createdAt?.toDate().toLocal();
    if (date == null) {
      return null;
    }
    return DateFormat('HH:mm:ss').format(date).toString();
  }
}
