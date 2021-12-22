import 'package:the_logistic_mall/model/http_response.dart';
import 'package:the_logistic_mall/service/connection_helper.dart';

class MockRepo {
  Future<HttpResponse> login() async {
    final hasConnection = await ConnectionHelper.hasConnection();
    if (hasConnection) {
    //TODO API CALL
    } else {
    //TODO RETURN NO INTERNET MESSAGE
    }
    return HttpResponse();
  }
}
