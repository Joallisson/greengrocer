const String baseUrl = 'https://parseapi.back4app.com';

abstract class Endpoints{

  static const String signin = '$baseUrl/functions/login';
  static const String signup = '$baseUrl/functions/signup';
  static const String validateToken = '$baseUrl/functions/validate-token';
}