import 'package:app/global_resource.dart';

final box = GetStorage();

String getTimeFromDatetime(String createdAt) {
  DateTime dateTime = DateTime.parse(createdAt);

  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;
}

changeFormatDate(status, date) {
  DateFormat f;
  if (status == 1) {
    f = DateFormat('yyyy-MM-dd');
  } else if (status == 2) {
    f = DateFormat('dd MMM yyyy');
  } else if (status == 3) {
    f = DateFormat('dd MMMM yyyy');
  } else if (status == 4) {
    f = DateFormat('ddMMyyyy');
  } else {
    f = DateFormat('yyyy-MM-dd  hh:mm');
  }
  if (date != null) {
    return f.format(DateTime.parse(date));
  } else {
    return null;
  }
}

changeUrlImage(data) {
  return data.replaceAll("wwwroot/", Base.url).toLowerCase();
}

timerAbsen() {
  var waktuAbsen = box.read(Base.waktuAbsen);
  var time = DateTime.parse(waktuAbsen!).difference(DateTime.now());
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');
  var hours = waktu.hour < 10 ? '0${waktu.hour}' : waktu.hour;
  var munite = waktu.minute < 10 ? '0${waktu.minute}' : waktu.minute;
  // var second = waktu.second < 10 ? '0${waktu.second}' : waktu.second;
  return "$hours:$munite";
}

izinAbs() {
  var izinAbse = box.read(Base.izinAbsen);
  var sekarang = DateTime.now();
  if (izinAbse != null) {
    var izin = DateTime.parse(izinAbse);
    var tanggalAwal =
        "${izin.year}-${izin.month < 10 ? '0${izin.month}' : izin.month}-${izin.day < 10 ? '0${izin.day}' : izin.day} 00:00:00";
    var tanggalAkhir = DateTime.parse(
        "${sekarang.year}-${sekarang.month < 10 ? '0${sekarang.month}' : sekarang.month}-${sekarang.day < 10 ? '0${sekarang.day}' : sekarang.day} 00:00:00");
    return DateTime.parse(tanggalAwal).isAtSameMomentAs(tanggalAkhir);
  } else {
    return false;
  }
}
