import 'package:travel_go/model/sub_model/buy_listing.dart';
import 'package:travel_go/model/sub_model/invoice_model.dart';
import 'package:travel_go/model/sub_model/product_model.dart';

import '../pagination.dart';

class PersonalMessageListModel {
  List<PersonalMessageModel> personalMessage;
  Pagination? pagination;

  PersonalMessageListModel({this.pagination, required this.personalMessage});

  factory PersonalMessageListModel.fromJson(Map<String, dynamic> json) =>
      PersonalMessageListModel(
        personalMessage: json["data"] == null
            ? []
            : List<PersonalMessageModel>.from(
                json["data"].map((x) => PersonalMessageModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class PersonalMessageModel {
  PersonalMessageModel({
    this.id,
    this.histories,
    this.message,
    this.photo,
    this.photoUrl,
    this.voice,
    this.voiceUrl,
    this.chatId,
    this.senderId,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.duration,
    this.payment,
    this.buyListing,
    this.invoice,
    this.product,
  });

  final String? id;
  final List<PersonalMessageModel>? histories;
  final String? message;
  final String? photo;
  final String? photoUrl;
  final String? voice;
  final String? voiceUrl;
  final String? chatId;
  final String? senderId;
  final bool? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;
  InvoiceModel? invoice;
  InvoiceModel? payment;
  BuyListingModel? buyListing;
  ProductModel? product;
  final dynamic duration;
  factory PersonalMessageModel.fromJson(Map<String, dynamic> json) {
    return PersonalMessageModel(
      id: json["_id"],
      histories: json["histories"] == null
          ? []
          : List<PersonalMessageModel>.from(
              json["histories"].map((x) => PersonalMessageModel.fromJson(x))),
      message: json["message"],
      photo: json["photo"],
      photoUrl: json["photo_url"],
      voice: json["voice"],
      voiceUrl: json["voice_url"],
      duration: json["voice_duration"],
      chatId: json["chat"],
      senderId: json["sender"],
      seen: json["seen"],
      type: json["type"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      invoice: json["invoice"] == null
          ? null
          : InvoiceModel.fromJson(json["invoice"]),
      payment: json["payment"] == null
          ? null
          : InvoiceModel.fromJson(json["payment"]),
      buyListing: json["buy_listing"] == null
          ? null
          : BuyListingModel.fromJson(json["buy_listing"]),
      product: json["product"] == null
          ? null
          : ProductModel.fromJson(json["product"]),
    );
  }
}
