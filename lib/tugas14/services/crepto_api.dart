import 'package:dio/dio.dart';
import 'package:ppkdjakut/tugas14/models/crepto.dart';

class CreptoApi {
  CreptoApi({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<List<Crepto>> getMarkets() async {
    final response = await _dio.get<List<dynamic>>(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 20,
        'page': 1,
        'sparkline': false,
      },
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('Respons API crypto kosong');
    }
    return data
        .map((item) => Crepto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
