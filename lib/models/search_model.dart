class SearchModel{
  late bool status;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel{
  int? currentPage;
  List<Product> data=[];
  SearchDataModel.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(Product.fromJson(element));
    });
  }
}
class Product{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  List<dynamic>? images;
  Product({this.id,this.oldPrice,this.price,this.discount,this.image,
    this.name,this.images
  });
  Product.fromJson(Map<String, dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    images=json['images'];

  }
}