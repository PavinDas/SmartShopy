import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.image,
    required this.id,
  });

  String image;
  String id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
      };
}
