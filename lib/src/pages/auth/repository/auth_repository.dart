import 'package:mercadinho/src/constants/endpoints.dart';
import 'package:mercadinho/src/models/user_model.dart';
import 'package:mercadinho/src/pages/auth/repository/auth_errors.dart';
import 'package:mercadinho/src/pages/auth/result/auth_result.dart';
import 'package:mercadinho/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restResquest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restResquest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signup(UserModel user) async {
    final result = await _httpManager.restResquest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restResquest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {
        'email': email,
      },
    );
  }

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      return AuthResult.success(UserModel.fromJson(result['result']));
    } else {
      return AuthResult.error(authErrorsStr(result['error']));
    }
  }
}
