import 'package:http/http.dart';

extension ResponseExtension on Response {
  bool isSuccessful() {
    return statusCode >= 200 && statusCode < 300;
  }
}
