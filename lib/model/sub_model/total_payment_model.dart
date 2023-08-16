class TotalPaymentModel {
  num? amount;

  TotalPaymentModel({
    this.amount,
  });

  factory TotalPaymentModel.fromJson(Map<String, dynamic> json) => TotalPaymentModel(
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
  };
}