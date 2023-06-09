import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const post = 'POST';
  static const get = 'GET';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}

class HttpManager {

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    //Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
        data: body
      );

      //Retorno do resultado do backend
      return response.data;
    } 
    on DioException catch(error){

      //Retorno do resultado da request
      return error.response?.data;
    }
    catch (e) {

      //Retorno de map vazio para error generalizado
      return {};
    }
    
  }
}
