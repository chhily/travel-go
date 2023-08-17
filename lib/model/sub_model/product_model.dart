import 'package:travel_go/model/sub_model/currency_model.dart';
import 'package:travel_go/model/sub_model/unit_model.dart';

class ProductModel {
  List<String>? photoUrls;
  String? id;
  String? title;
  DateTime? deletedAt;
  final List<num>? prices;
  final CurrencyModel? currency;
  final ProductRequest? request;
  ProductModel({
    this.photoUrls,
    this.id,
    this.title,
    this.deletedAt,
    this.prices,
    this.request,
    this.currency,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        photoUrls: json["photo_urls"] == null
            ? []
            : List<String>.from(json["photo_urls"]!.map((x) => x)),
        id: json["_id"],
        title: json["title"],
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        prices: json["prices"] == null
            ? []
            : List<num>.from(json["prices"].where((x) => x != null)),
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
        request: json["request"] == null
            ? null
            : ProductRequest.fromJson(json["request"]),
      );
}

class ProductRequest {
  /// either int or string
  final num? qty;
  final UnitModel? unit;
  final CurrencyModel? currency;
  ProductRequest({
    this.qty,
    this.unit,
    this.currency,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
        qty: json["qty"],
        unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
      );
}
