
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable()
class ProductModel{
  final String id;
  final String name;
  @JsonKey(defaultValue: [], includeIfNull: true)
  final List<Brand> brands;

  ProductModel({
    required this.id,
    required this.name,
    required this.brands
});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}

@JsonSerializable()
class Brand{
  final String name;
  Brand({required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}