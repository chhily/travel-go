import 'package:travel_go/model/sub_model/currency_model.dart';
import 'package:travel_go/model/sub_model/unit_model.dart';

class BuyListingModel {
  BuyListingModel({
    this.id,
    this.title,
    this.offer,
    this.prices,
    this.photoUrls,
    this.currency,
  });

  final String? id;
  final String? title;
  final OfferSocket? offer;
  final List<num>? prices;
  final List<String>? photoUrls;
  final CurrencyModel? currency;

  factory BuyListingModel.fromJson(Map<String, dynamic> json) =>
      BuyListingModel(
        id: json["_id"],
        title: json["title"],
        offer:
            json["offer"] == null ? null : OfferSocket.fromJson(json["offer"]),
        prices: json["prices"] == null
            ? []
            : List<num>.from(json["prices"].where((x) => x != null)),
        photoUrls: json["photo_urls"] == null
            ? []
            : List<String>.from(json["photo_urls"].map((x) => x)),
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
      );
}

class OfferSocket {
  final num? qty;
  final num? price;
  final CurrencyModel? currency;
  final UnitModel? unit;

  OfferSocket({
    this.qty,
    this.price,
    this.currency,
    this.unit,
  });

  factory OfferSocket.fromJson(Map<String, dynamic> json) => OfferSocket(
        qty: json["qty"],
        price: json["price"],
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
        unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
      );
}
