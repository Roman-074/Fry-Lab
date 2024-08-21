import 'package:dio/dio.dart';

void sendMessageToTg(message) async {
  try {
    String token = "7359727741:AAFV9nRRfLBQYlzHfxxZUCLyrBmMOZcH_ys";
    String userId = "409490616";
    String url =
        "https://api.telegram.org/bot$token/sendMessage?chat_id=$userId&text=$message";
    final response = await Dio().post(url);
    print(response);
  } catch (e) {
    print(e.toString());
  }
}
