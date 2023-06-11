import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';

class AuthController extends GetxController{

  RxBool isLoading = false.obs;

  AuthRepository _authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {

    isLoading .value = true;

    //await Future.delayed(const Duration(seconds: 2));

    await _authRepository.signIn(email: email, password: password);

    isLoading.value = false;
  }

}