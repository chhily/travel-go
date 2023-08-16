// import 'package:travel_go/model/sub_model/invoice_model.dart';
//
// class StorePersonalMessageModel {
//   String? id;
//   List<StorePersonalMessageModel>? histories;
//   String? message;
//   String? chat;
//   String? sender;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   bool? seen;
//   String? type;
//   int? v;
//   InvoiceModel? invoice;
//   InvoiceModel? payment;
//
//   StorePersonalMessageModel({
//     this.id,
//     this.histories,
//     this.message,
//     this.chat,
//     this.sender,
//     this.createdAt,
//     this.updatedAt,
//     this.seen,
//     this.type,
//     this.v,
//     this.invoice,
//     this.payment,
//   });
//
//   factory StorePersonalMessageModel.fromJson(Map<String, dynamic> json) =>
//       StorePersonalMessageModel(
//         id: json["_id"],
//         histories: json["histories"] == null
//             ? []
//             : List<StorePersonalMessageModel>.from(
//                 json["histories"]!.map((x) => x)),
//         message: json["message"],
//         chat: json["chat"],
//         sender: json["sender"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         seen: json["seen"],
//         type: json["type"],
//         v: json["__v"],
//         invoice: json["invoice"] == null
//             ? null
//             : InvoiceModel.fromJson(json["invoice"]),
//         payment: json["payment"] == null
//             ? null
//             : InvoiceModel.fromJson(json["payment"]),
//       );
// }
