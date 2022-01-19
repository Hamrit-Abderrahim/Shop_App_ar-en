class GetFavoriteModel{
  late bool status;
  GetFavoriteDataModel? data;
  GetFavoriteModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=GetFavoriteDataModel.fromJson(json['data']);
  }
}

class GetFavoriteDataModel{
  int? currentPage;
  List<GetFavoriteDataModelData> data=[];
  GetFavoriteDataModel.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(GetFavoriteDataModelData.fromJson(element));
    });
  }
}
class GetFavoriteDataModelData{
  int? id;
  Product? product;
  GetFavoriteDataModelData.fromJson(Map<String, dynamic>json){
    id=json['id'];
    product=Product.fromJson(json['product']);
  }}
class Product{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  Product({this.id,this.oldPrice,this.price,this.discount,this.image,
    this.name
  });
  Product.fromJson(Map<String, dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];

  }
}


