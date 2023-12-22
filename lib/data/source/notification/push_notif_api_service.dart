import 'package:app/data/models/notification/push_notification.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'push_notif_api_service.g.dart';

@RestApi(baseUrl: 'https://hora-id.vercel.app/api')
abstract class PushNotificationApiService {
  factory PushNotificationApiService(Dio dio, {String baseUrl}) =
      _PushNotificationApiService;

  @POST('/send/push-notification')
  Future<dynamic> sendPushNotification(@Body() PushNotification request);
}
