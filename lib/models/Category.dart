part of 'Models.dart';

class Category extends ChangeNotifier {
  String category;

  String getCategory(String thisCategory) {
    category = thisCategory;
    return category;
  }

  dynamic setCategory(String category) {
    getCategory(category);
    notifyListeners();
  }
}
