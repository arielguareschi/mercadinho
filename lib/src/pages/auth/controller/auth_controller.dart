import 'package:get/get.dart';
import 'package:mercadinho/src/constants/storage_keys.dart';
import 'package:mercadinho/src/models/user_model.dart';
import 'package:mercadinho/src/pages/auth/repository/auth_repository.dart';
import 'package:mercadinho/src/pages/auth/result/auth_result.dart';
import 'package:mercadinho/src/pages_routes/app_pages.dart';
import 'package:mercadinho/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final repository = AuthRepository();

  final UtilServices utilServices = UtilServices();
  UserModel user = UserModel();

  // @override
  // void onInit() {
  //   super.onInit();
  //   validateToken();
  // }

  Future<void> validateToken() async {
    String? token = await utilServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await repository.validateToken(token);
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
    // Zerar o user
    user = UserModel();
    // remover o token Localmente,
    await utilServices.removeLocalData(
      key: StorageKeys.token,
    );
    // ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await repository.signup(user);

    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await repository.resetPassword(email);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await repository.signIn(
      email: email,
      password: password,
    );

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void saveTokenAndProceedToBase() {
    // salva o token
    utilServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    // vai para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }
}
