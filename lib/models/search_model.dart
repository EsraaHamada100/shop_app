import 'package:shop_app/models/home_model.dart';

class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] == null) {
      print('data equal null');
      return;
    }
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  List<Product> productsDataList = [];
  // String? firstPageUrl;
  // int? from;
  // int? lastPage;
  // String? lastPageUrl;
  // Null? nextPageUrl;
  // String? path;
  // int? perPage;
  // Null? prevPageUrl;
  // int? to;
  // int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      // data = <FavoritesData>[];
      json['data'].forEach((data) {
        productsDataList.add(Product.fromJson(data));
      });
    }
    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
    // total = json['total'];
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  int? discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
