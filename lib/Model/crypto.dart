class CryptoModel {
  String id;
  String name;
  String symbol;
  String changePercet24hr;
  String priceUSD;
  String marketCapUSD;
  double rank;

  CryptoModel(
    this.id,
    this.name,
    this.symbol,
    this.changePercet24hr,
    this.priceUSD,
    this.marketCapUSD,
    this.rank,
  );

  factory CryptoModel.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return CryptoModel(
      jsonMapObject["id"],
      jsonMapObject["name"],
      jsonMapObject["symbol"],
      jsonMapObject["changePercent24Hr"],
      jsonMapObject["priceUsd"],
      jsonMapObject["marketCapUsd"],
      double.parse(jsonMapObject["rank"]),
    );
  }
}
