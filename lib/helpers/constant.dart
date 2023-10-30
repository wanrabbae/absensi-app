import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

final box = GetStorage();

String getTimeFromDatetime(String createdAt) {
  DateTime dateTime = DateTime.parse(createdAt);

  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;
}

String getTimeFullFromDatetime(String createdAt) {
  DateTime dateTime = DateTime.parse(createdAt);

  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";

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
  } else if (status == 5) {
    f = DateFormat('dd/MM/yyyy');
  } else {
    f = DateFormat('yyyy-MM-dd  hh:mm');
  }
  if (date != null) {
    return f.format(DateTime.parse(date));
  } else {
    return null;
  }
}

Future<File> readAssetFileImg(String assetFilePath, String fileName) async {
  // Load the image file from the assets using rootBundle
  ByteData? byteData = await rootBundle.load(assetFilePath);
  Uint8List bytes = byteData.buffer.asUint8List();

  // Get the temporary directory path using the path_provider package
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Create a temporary File
  File tempFile = File('$tempPath/$fileName');

  // Write the image bytes into the temporary File
  await tempFile.writeAsBytes(bytes);

  return tempFile;
}

Future<File> readAssetFile(String assetContent, String fileName) async {
  // Get the temporary directory path using the path_provider package
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Create a temporary File
  File tempFile = File('$tempPath/$fileName');

  // Write the asset content into the temporary File
  await tempFile.writeAsString(assetContent);

  return tempFile;
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

bool isSmallerThanToday(String dateString) {
  // Parse the given date string
  DateTime parsedDate = DateTime.parse(dateString);

  // Get the current date today
  DateTime currentDate = DateTime.now();
  DateTime addedOneDay = parsedDate.add(const Duration(days: 1));
  // Compare the dates
  return addedOneDay.isBefore(currentDate);
}

timerAbsen() {
  var waktuAbsen = box.read(Base.waktuAbsen);
  print(waktuAbsen);
  var time = DateTime.parse(waktuAbsen!).difference(DateTime.now());
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');
  var hours = waktu.hour < 10 ? '0${waktu.hour}' : waktu.hour;
  var munite = waktu.minute < 10 ? '0${waktu.minute}' : waktu.minute;
  var second = waktu.second < 10 ? '0${waktu.second}' : waktu.second;
  return "$hours:$munite:$second";
}

timerAbsen2(waktuAbsen) {
  var time = DateTime.parse(waktuAbsen!).difference(DateTime.now());
  print(time.inHours);
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');
  var hours = waktu.hour < 10 ? '0${waktu.hour}' : waktu.hour;
  var munite = waktu.minute < 10 ? '0${waktu.minute}' : waktu.minute;
  var second = waktu.second < 10 ? '0${waktu.second}' : waktu.second;
  return "$hours:$munite:$second";
}

timerAbsen3(waktuCheckIn, String? checkOut) {
  DateTime checkOutDateTime;

  if (checkOut != null) {
    checkOutDateTime = DateTime.parse(checkOut);
  } else {
    checkOutDateTime = DateTime.now();
  }

  var time = DateTime.parse(waktuCheckIn!).difference(checkOutDateTime);
  Duration timeDifference =
      DateTime.parse(waktuCheckIn!).difference(checkOutDateTime);
  print(timeDifference.inHours);
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');

  var hours = timeDifference.inHours.abs() < 10
      ? '0${timeDifference.inHours.abs()}'
      : timeDifference.inHours.abs();
  var munite = timeDifference.inMinutes.remainder(60).abs() < 10
      ? '0${timeDifference.inMinutes.remainder(60).abs()}'
      : timeDifference.inMinutes.remainder(60).abs();
  var second = timeDifference.inSeconds.remainder(60).abs() < 10
      ? '0${timeDifference.inSeconds.remainder(60).abs()}'
      : timeDifference.inSeconds.remainder(60).abs();
  return "$hours:$munite:$second";
}

timerAbsen4() {
  var waktuAbsen = box.read(Base.waktuAbsen);
  print(waktuAbsen);
  var time = DateTime.parse(waktuAbsen!).difference(DateTime.now());

  Duration timeDifference =
      DateTime.parse(waktuAbsen!).difference(DateTime.now());
  print(timeDifference.inHours);
  var waktu = DateTime.parse(
      '2023-05-11 ${time.inHours.abs() < 10 ? '0' : ''}${time.abs().toString()}');

  var hours = timeDifference.inHours.abs() < 10
      ? '0${timeDifference.inHours.abs()}'
      : timeDifference.inHours.abs();
  var munite = timeDifference.inMinutes.remainder(60).abs() < 10
      ? '0${timeDifference.inMinutes.remainder(60).abs()}'
      : timeDifference.inMinutes.remainder(60).abs();
  var second = timeDifference.inSeconds.remainder(60).abs() < 10
      ? '0${timeDifference.inSeconds.remainder(60).abs()}'
      : timeDifference.inSeconds.remainder(60).abs();
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

int parseTimeToSeconds(String time) {
  List<String> timeComponents = time.split(':');
  int hours = int.parse(timeComponents[0]);
  int minutes = int.parse(timeComponents[1]);
  int seconds = int.parse(timeComponents[2]);
  return (hours * 3600) + (minutes * 60) + seconds;
}

void printTime(int timeInSeconds) {
  int hours = timeInSeconds ~/ 3600;
  int minutes = (timeInSeconds % 3600) ~/ 60;
  int seconds = timeInSeconds % 60;
  print(
      '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

Future<void> downloadImage(String imageUrl) async {
  try {
    Dio dio = Dio();
    var response = await dio.get(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    // Get the default Download directory path using the path_provider package
    Directory downloadDir = await getDownloadsDirectory() as Directory;

    // Extract the image name from the URL
    String imageName = imageUrl.split('/').last;

    // Create a File object to save the image in the default Download directory
    File imageFile = File('${downloadDir.path}/$imageName');

    // Write the image data to the file
    await imageFile.writeAsBytes(response.data);

    print('Image downloaded successfully. File path: ${imageFile.path}');
  } catch (e) {
    print('Error downloading the image: $e');
  }
}

Future<String> createFolder(String cow) async {
  final folderName = cow;
  final path = Directory("storage/emulated/0/$folderName");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();
    return path.path;
  }
}

Future<void> openMap(String? latitude, String? longitude) async {
  double latitude2 = double.parse(latitude.toString());
  double longitude2 = double.parse(longitude.toString());
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude2,$longitude2';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

saveNetworkImage(url) async {
  String path = url.toString();
  var dir = await DownloadsPathProvider.downloadsDirectory;

  PermissionStatus status = await Permission.storage.status;

  if (!status.isGranted) {
    // If permission is not granted, request it
    status = await Permission.storage.request();
    if (!status.isGranted) {
      // If the user denies the permission, open app settings
      SplashController().showConfirmationDialog2(
          "Perizinan", "Buka pengaturan perizinan perangkat?", () {
        // Redirect to allow location setting on phone
        openAppSettings();
      });
      return false;
    }
  }

  var dir2 = await getApplicationDocumentsDirectory();
  if (dir != null || dir2 != null) {
    String savename = url.toString().split("/").last;
    String savePath = Platform.isIOS
        ? "${dir2.path}/$savename"
        : "${dir?.path.toString()}/Hora/$savename";

    try {
      customSnackbarLoading("Mengunduh dokumen...");
      await Dio().download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint("${(received / total * 100).toStringAsFixed(0)}%");
          // create progress bar
        }
      });
      debugPrint("File is saved to download folder.");
      customSnackbar1("Tangkapan layar telah disimpan.");
      await AwesomeNotificationService()
          .showNotificationCapture(path: savePath);
    } on DioError catch (e) {
      print(e.message);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }
}

saveNetworkFile(url) async {
  PermissionStatus status = await Permission.storage.status;

  if (!status.isGranted) {
    // If permission is not granted, request it
    status = await Permission.storage.request();
    if (!status.isGranted) {
      // If the user denies the permission, open app settings
      SplashController().showConfirmationDialog2(
          "Perizinan", "Buka pengaturan perizinan perangkat?", () {
        // Redirect to allow location setting on phone
        openAppSettings();
      });
      return false;
    }
  }

  var dir = await DownloadsPathProvider.downloadsDirectory;
  var dir2 = await getApplicationDocumentsDirectory();
  if (dir != null || dir2 != null) {
    String savename = url.toString().split("/").last;
    String savePath = Platform.isIOS
        ? "${dir2.path}/$savename"
        : "${dir?.path}/Hora/$savename";

    try {
      customSnackbarLoading("Mengunduh dokumen...");
      await Dio().download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint("${(received / total * 100).toStringAsFixed(0)}%");
          // create progress bar
          // loadingBar();
        }
      });
      // Get.back();
      debugPrint("File is saved to download folder.");
      customSnackbar1("Lampiran telah disimpan.");
      await AwesomeNotificationService()
          .showNotificationDownloadedFile(path: savePath.toString());
    } on DioError catch (e) {
      print(e.message);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }
}
