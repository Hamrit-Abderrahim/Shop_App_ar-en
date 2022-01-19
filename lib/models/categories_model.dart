class CategoriesModel{
  late bool status;
  CategoriesModelData? data;
  CategoriesModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=CategoriesModelData.fromJson(json['data']);
  }
}

class CategoriesModelData{
  int? currentPage;
  List<DataModel>data=[];
  CategoriesModelData.fromJson(Map<String, dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }}

class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}