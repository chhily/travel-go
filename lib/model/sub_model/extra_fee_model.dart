class ExtraFeeModel {
  String? name;
  num? amount;

  ExtraFeeModel({
    this.name,
    this.amount,
  });

  factory ExtraFeeModel.fromJson(Map<String, dynamic> json) => ExtraFeeModel(
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}