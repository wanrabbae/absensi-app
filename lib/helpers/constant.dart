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

bool isGreaterThanToday(String dateString) {
  // Parse the given date string
  DateTime parsedDate = DateTime.parse(dateString);

  // Get the current date today
  DateTime currentDate = DateTime.now();

  // Compare the dates
  return parsedDate.isAfter(currentDate);
}

timerAbsen() {
  var waktuAbsen = box.read(Base.waktuAbsen);
  var time = DateTime.parse(waktuAbsen!).difference(DateTime.now());
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');
  var hours = waktu.hour < 10 ? '0${waktu.hour}' : waktu.hour;
  var munite = waktu.minute < 10 ? '0${waktu.minute}' : waktu.minute;
  var second = waktu.second < 10 ? '0${waktu.second}' : waktu.second;
  return "$hours:$munite:$second";
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

bool isEmailValid(String email) {
  // Regular expression for email validation
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegExp.hasMatch(email);
}

String getDuration(String checkIn, String? checkOut) {
  DateTime checkInDateTime = DateTime.parse(checkIn);
  DateTime checkOutDateTime;

  if (checkOut != null) {
    checkOutDateTime = DateTime.parse(checkOut);
  } else {
    checkOutDateTime = DateTime.now();
  }

  Duration duration = checkOutDateTime.difference(checkInDateTime);

  return formatDuration(duration);
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}
