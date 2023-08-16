class UnitModel {
  String? id;
  String? name;
  String? symbol;
  String? type;
  num? order;

  UnitModel({
    this.id,
    this.name,
    this.symbol,
    this.type,
    this.order,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["_id"],
        name: json["name"],
        symbol: json["symbol"],
        type: json["type"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "symbol": symbol,
        "type": type,
        "order": order,
      };
}
