import 'package:get/get.dart';
import 'package:mercadinho/src/models/category_model.dart';
import 'package:mercadinho/src/pages/home/repository/home_repository.dart';
import 'package:mercadinho/src/pages/home/result/home_result.dart';
import 'package:mercadinho/src/services/utils_services.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository = HomeRepository();

  bool isLoading = false;

  List<CategoryModel> allCategories = [];

  final utilServices = UtilServices();

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        print('todas as categorias: $allCategories');
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
