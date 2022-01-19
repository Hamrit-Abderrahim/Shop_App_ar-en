class HomeModel{
  late bool status;
  HomeDataModel? data;
  HomeModel({required this.status, this.data});
  HomeModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<Banners>banners=[];
  List<Products>products=[];
  HomeDataModel({ required this.banners, required this.products});
  HomeDataModel.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(Products.fromJson(element));
    });
  }
}
class Banners{
  int? id;
  String? image;
  Banners({this.id, this.image});
  Banners.fromJson(Map<String, dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}
class Products{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? inFavourite;
  bool? inCart;
  String? description;
  List<dynamic>? images;
  Products({this.id,this.oldPrice,this.price,this.discount,this.image,
  this.name,this.inFavourite,this.inCart,this.images,this.description
  });
  Products.fromJson(Map<String, dynamic> json){
   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];
   inFavourite=json['in_favorites'];
   inCart=json['in_cart'];
   description=json['description'];
   images=json['images'];
  }
}