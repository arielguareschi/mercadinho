import 'package:mercadinho/src/constants/endpoints.dart';
import 'package:mercadinho/src/models/category_model.dart';
import 'package:mercadinho/src/pages/home/result/home_result.dart';
import 'package:mercadinho/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restResquest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      // algum erro
      return HomeResult.error("Ocorreu algum erro ao buscar as categorias");
    }
  }
}
