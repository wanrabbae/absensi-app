import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation.freezed.dart';
part 'invitation.g.dart';

@freezed
class Invitation with _$Invitation {
  const factory Invitation({
    required String receiver,
    required String sender,
    @JsonKey(name: 'idperusahaan') required String idPerusahaan,
    required String namaPerusahaan,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);
}
