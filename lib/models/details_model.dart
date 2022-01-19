// class DetailsModel{
//   late bool status;
//   Products? data;
//   DetailsModel.fromJson(Map<String, dynamic> json){
//     status=json['status'];
//     data=json['data'] != null? Products.fromJson(json['data']) : null;
//   }
// }
// class Products{
//   int? id;
//   dynamic? price;
//   dynamic? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   bool? inFavourite;
//   bool? inCart;
//   String? description;
//   List<dynamic>? images;
//   Products.fromJson(Map<String, dynamic> json){
//     id=json['id'];
//     price=json['price'];
//     oldPrice=json['old_price'];
//     discount=json['discount'];
//     image=json['image'];
//     name=json['name'];
//     inFavourite=json['in_favorites'];
//     inCart=json['in_cart'];
//     description=json['description'];
//     images=json['images'];
//   }
// }

class DetailsModel {
  bool? status;
  Data? data;


  DetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'].cast<String>();
  }
}