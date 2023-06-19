const String baseUrl = 'https://parseapi.back4app.com';

abstract class Endpoints{

  static const String signin = '$baseUrl/functions/login';
  static const String signup = '$baseUrl/functions/signup';
  static const String validateToken = '$baseUrl/functions/validate-token';
  static const String resetPassword = '$baseUrl/functions/reset-password';
  static const String getAllCategories = '$baseUrl/functions/get-category-list';
  static const String getAllProducts = '$baseUrl/functions/get-product-list';
  static const String getCartItems = '$baseUrl/functions/get-cart-items';
}