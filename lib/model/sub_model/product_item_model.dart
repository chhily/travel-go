import 'package:travel_go/model/sub_model/product_model.dart';

import 'unit_model.dart';

class ProductItemModel {
  String? id;
  ProductModel? product;
  num? quantity;
  num? pricePerUnit;
  num? amount;
  UnitModel? unit;
  String? productItemId;

  ProductItemModel({
    this.id,
    this.product,
    this.quantity,
    this.pricePerUnit,
    this.amount,
    this.unit,
    this.productItemId
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) => ProductItemModel(
    id: json["_id"],
    product:
    json["product"] == null ? null : ProductModel.fromJson(json["product"]),
    quantity: json["quantity"],
    pricePerUnit: json["price_per_unit"],
    amount: json["amount"],
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
    productItemId: json["id"],
  );

}