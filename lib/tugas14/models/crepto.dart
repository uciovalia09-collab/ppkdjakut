import 'dart:convert';

List<Crepto> creptoListFromJson(String source) =>
    (json.decode(source) as List<dynamic>)
        .map((item) => Crepto.fromJson(item as Map<String, dynamic>))
        .toList();

String creptoListToJson(List<Crepto> data) =>
    json.encode(data.map((item) => item.toJson()).toList());

class Crepto {
  const Crepto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24H,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int marketCap;
  final int marketCapRank;
  final double priceChangePercentage24H;

  factory Crepto.fromJson(Map<String, dynamic> json) => Crepto(
    id: json['id'] as String? ?? '',
    symbol: json['symbol'] as String? ?? '',
    name: json['name'] as String? ?? '',
    image: json['image'] as String? ?? '',
    currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0,
    marketCap: (json['market_cap'] as num?)?.toInt() ?? 0,
    marketCapRank: (json['market_cap_rank'] as num?)?.toInt() ?? 0,
    priceChangePercentage24H:
        (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'symbol': symbol,
    'name': name,
    'image': image,
    'current_price': currentPrice,
    'market_cap': marketCap,
    'market_cap_rank': marketCapRank,
    'price_change_percentage_24h': priceChangePercentage24H,
  };
}
