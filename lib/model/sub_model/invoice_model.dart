import 'package:travel_go/model/sub_model/currency_model.dart';
import 'package:travel_go/model/sub_model/extra_fee_model.dart';
import 'package:travel_go/model/sub_model/product_item_model.dart';

import 'total_payment_model.dart';

class InvoiceModel {
  String? order;
  List<ProductItemModel>? productItems;
  List<ExtraFeeModel>? extraFee;
  String? customer;
  String? shop;
  String? paymentStatus;
  TotalPaymentModel? totalPayment;
  String? deliveryStatus;
  String? orderStatus;
  CurrencyModel? currency;
  String? invoice;
  String? paymentMethod;

  InvoiceModel({
    this.order,
    this.productItems,
    this.extraFee,
    this.customer,
    this.shop,
    this.paymentStatus,
    this.totalPayment,
    this.deliveryStatus,
    this.orderStatus,
    this.currency,
    this.invoice,
    this.paymentMethod,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        order: json["order"],
        productItems: json["product_items"] == null
            ? []
            : List<ProductItemModel>.from(json["product_items"]!
                .map((x) => ProductItemModel.fromJson(x))),
        extraFee: json["extra_fee"] == null
            ? []
            : List<ExtraFeeModel>.from(
                json["extra_fee"]!.map((x) => ExtraFeeModel.fromJson(x))),
        customer: json["customer"],
        shop: json["shop"],
        paymentStatus: json["payment_status"],
        totalPayment: json["total_payment"] == null
            ? null
            : TotalPaymentModel.fromJson(json["total_payment"]),
        deliveryStatus: json["delivery_status"],
        orderStatus: json["order_status"],
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
        invoice: json["invoice"],
        paymentMethod: json["payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "product_items": productItems == null
            ? []
            : List<dynamic>.from(productItems!.map((x) => x.toJson())),
        "extra_fee": extraFee == null
            ? []
            : List<dynamic>.from(extraFee!.map((x) => x.toJson())),
        "customer": customer,
        "shop": shop,
        "payment_status": paymentStatus,
        "total_payment": totalPayment?.toJson(),
        "delivery_status": deliveryStatus,
        "order_status": orderStatus,
        "currency": currency?.toJson(),
        "invoice": invoice,
        "payment_method": paymentMethod,
      };
}
