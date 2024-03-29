import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final _authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    validateToken();
  }

  void saveTokenAndProceedToBase() {
    //Salvar o token
    utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );
    //Ir para a tela base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }
  
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  })async{
    isLoading.value = true;
    final result = await _authRepository.changePassword(currentPassword: currentPassword, email: user.email!, newPassword: newPassword, token: user.token!,);

    if (result) {
      utilsServices.showToast(message: 'A senha foi atualizado com sucesso!');
      signOut();
    }else{
      utilsServices.showToast(message: 'A senha atual está incorreta', isError: true);
    }
    isLoading.value = false;
  }

  Future<void> resetPassword(String email) async{
    await _authRepository.resetPassword(email);
  }

  Future<void> validateToken() async {
    //Recuperar token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await _authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    //Zerar o user
    this.user = UserModel();

    //Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);

    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await _authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await _authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
