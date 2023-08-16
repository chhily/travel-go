import 'package:travel_go/model/sub_model/currency_model.dart';
import 'package:travel_go/model/sub_model/extra_fee_model.dart';
import 'package:travel_go/model/sub_model/product_item_model.dart';

import 'total_payment_model.dart';

class InvoiceModel {
  String? orderId;
  String? invoiceId;
  List<ProductItemModel>? productItems;
  List<ExtraFeeModel>? extraFee;
  String? customer;
  String? shop;
  String? paymentStatus;
  TotalPaymentModel? totalPayment;
  CurrencyModel? currency;

  InvoiceModel({
    this.orderId,
    this.productItems,
    this.extraFee,
    this.customer,
    this.shop,
    this.paymentStatus,
    this.totalPayment,
    this.currency,
    this.invoiceId,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        orderId: json["order"],
        productItems: json["product_items"] == null
            ? []
            : List<ProductItemModel>.from(json["product_items"]!
                .map((x) => ProductItemModel.fromJson(x))),
        // extraFee: json["extra_fee"] == null
        //     ? []
        //     : List<ExtraFeeModel>.from(
        //         json["extra_fee"]!.map((x) => ExtraFeeModel.fromJson(x))),
        // customer: json["customer"],
        // shop: json["shop"],
        paymentStatus: json["payment_status"],
        totalPayment: json["total_payment"] == null
            ? null
            : TotalPaymentModel.fromJson(json["total_payment"]),
        currency: json["currency"] == null
            ? null
            : CurrencyModel.fromJson(json["currency"]),
        invoiceId: json["invoice"],
      );
}



