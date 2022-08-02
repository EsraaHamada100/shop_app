class ChangeFavoritesModel {
  late bool status;
  late String message ;
  // late FavoritesDataModel data;
  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = FavoritesDataModel.fromJson(json['data']);
  }
}
//
// class FavoritesDataModel {
//     late int id;
//     late ProductData product;
//     FavoritesDataModel.fromJson(Map<String , dynamic> json){
//       id = json['id'];
//       product = ProductData.fromJson(json['product']);
//     }
// }
//
// class ProductData {
//   late int id;
//   late int price;
//   late int oldPrice;
//   late int discount;
//   late String image;
//   ProductData.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//   }
// }