class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(BannerModel.fromJson(banner));
    });

    json['products'].forEach((product) {
      products.add(ProductModel.fromJson(product));
    });
    print('Hello');
    // print(banners[0].image);
    // print(products);

  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late int price;
  late int oldPrice;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  late int discount;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toInt();
    price = json['price'].toInt();
    oldPrice = json['old_price'].toInt();
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    discount = json['discount'];
  }
}
