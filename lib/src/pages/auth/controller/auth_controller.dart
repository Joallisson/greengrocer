import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final AuthRepository _authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await _authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user){
        print(user.toString());
      },
      error: (message){
        print(message);
      },
    );
  }
}
