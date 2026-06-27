import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/product_list/domain/repository/product_list_repo.dart';
import 'package:storecs/main.dart';

class ProductListController extends GetxController {
  final ProductListRepo repo;
  ProductListController(this.repo);
  final Alerts alerts = Alerts(messengerKey);
  final name = TextEditingController();
  final brand = TextEditingController();
  final barcode = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final costPrice = TextEditingController();
  final stock = TextEditingController();
  final selectedCategory = ''.obs;
  final RxString imageFileUrl = ''.obs;
  final ImagePicker picker = ImagePicker();
  final Rx<File?> selectedFile = Rx<File?>(null);

  final List<String> categories = [
    "Phones",
    "Tablates",
    "Tv's & Monitors",
    "Accessories",
    "PS5",
    "Pc's Components",
  ];
  void changeCategory(String value) => selectedCategory.value = value;

  Future<void> uploadProductPic() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      selectedFile.value = File(file.path);
    }
  }

  Future<void> storeProductInfo() async {
    if (name.text.trim().isEmpty) {
    } else if (brand.text.trim().isEmpty) {
    } else if (barcode.text.trim().isEmpty) {
    } else if (description.text.trim().isEmpty) {
    } else if (price.text.trim().isEmpty) {
    } else if (stock.text.trim().isEmpty) {
    } else {
      Loader.startLoading();
      try {
        String base64Image = "";
        if (selectedFile.value != null && await selectedFile.value!.exists()) {
          final List<int> imageBytes = await selectedFile.value!.readAsBytes();
          base64Image = base64Encode(imageBytes);
          final newProduct = await repo.toInsertProductListRepo(
            name.text.trim(),
            brand.text.trim(),
            selectedCategory.value,
            base64Image,
            barcode.text.trim(),
            description.text.trim(),
            price.text.trim(),
            costPrice.text.trim(),
            stock.text.trim(),
          );
          imageFileUrl.value = newProduct.image;
          alerts.ifSuccess(ProductAdded);
        }
      } on PlatformException catch (e) {
        print('The Error Is: ${e.message.toString()}');
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      } catch (e) {
        Loader.stopLoading();
        print("Something went wrong. $e");
        alerts.ifErrors("Something went wrong.");
      } finally {
        Loader.stopLoading();
      }
    }
  }
}
