class CurrencyModel {
  String? id;
  String? name;
  String? code;
  String? symbol;

  CurrencyModel({
    this.id,
    this.name,
    this.code,
    this.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    id: json["_id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "code": code,
    "symbol": symbol,
  };
}