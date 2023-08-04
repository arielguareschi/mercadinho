import 'package:get/get.dart';
import 'package:mercadinho/src/models/category_model.dart';
import 'package:mercadinho/src/models/item_model.dart';
import 'package:mercadinho/src/pages/home/repository/home_repository.dart';
import 'package:mercadinho/src/pages/home/result/home_result.dart';
import 'package:mercadinho/src/services/utils_services.dart';

const int itemPerPages = 6;

class HomeController extends GetxController {
  final HomeRepository homeRepository = HomeRepository();

  bool isLoadingCategories = false;
  bool isLoadingProducts = true;

  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  final utilServices = UtilServices();

  CategoryModel? currentCategory;

  RxString searchTitle = "".obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemPerPages) {
      return true;
    }
    return currentCategory!.pagination * itemPerPages > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isLoadingCategories = value;
    } else {
      isLoadingProducts = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }
    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == "");
      if (c == null) {
        final allProductsCategory = CategoryModel(
          title: "Todos",
          id: "",
          items: [],
          pagination: 0,
        );
        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = allCategories.first;
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getlAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> getlAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }
    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemPerPages
    };
    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }
    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);
    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);

        if (currentCategory!.items.isEmpty) return;

        update();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getlAllProducts(canLoad: false);
  }
}
