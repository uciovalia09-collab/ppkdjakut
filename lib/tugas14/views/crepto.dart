import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkdjakut/tugas14/models/crepto.dart';
import 'package:ppkdjakut/tugas14/services/crepto_api.dart';

class CreptoList extends StatefulWidget {
  const CreptoList({super.key});

  @override
  State<CreptoList> createState() => _CreptoListState();
}

class _CreptoListState extends State<CreptoList> {
  final CreptoApi _api = CreptoApi();
  late Future<List<Crepto>> _markets;

  @override
  void initState() {
    super.initState();
    _markets = _api.getMarkets();
  }

  void _reload() {
    setState(() {
      _markets = _api.getMarkets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Market'),
        backgroundColor: const Color.fromARGB(190, 245, 123, 221),
        actions: [
          IconButton(onPressed: _reload, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<Crepto>>(
        future: _markets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final message = snapshot.error is DioException
                ? 'Gagal terhubung ke API CoinGecko.'
                : 'Data crypto tidak dapat diproses.';

            return Center(
              child: FilledButton.icon(
                onPressed: _reload,
                icon: const Icon(Icons.refresh),
                label: Text('$message Coba lagi'),
              ),
            );
          }

          final markets = snapshot.data ?? [];

          if (markets.isEmpty) {
            return const Center(child: Text('Belum ada data crypto.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              _reload();
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: markets.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _CryptoTile(crypto: markets[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _CryptoTile extends StatelessWidget {
  const _CryptoTile({required this.crypto});

  final Crepto crypto;

  @override
  Widget build(BuildContext context) {
    final change = crypto.priceChangePercentage24H;
    final changeColor = change >= 0 ? Colors.green : Colors.red;

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CryptoDetailPage(crypto: crypto),
          ),
        );
      },

      leading: CircleAvatar(backgroundImage: NetworkImage(crypto.image)),

      title: Text('${crypto.name} (${crypto.symbol.toUpperCase()})'),

      subtitle: Text(
        '#${crypto.marketCapRank}  Market cap: ${crypto.marketCap}',
      ),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('\$${crypto.currentPrice.toStringAsFixed(2)}'),
          Text(
            //
            '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%',
            style: TextStyle(color: changeColor),
          ),
        ],
      ),
    );
  }
}

// ===============================
// HALAMAN DETAIL CRYPTO
// ===============================

class CryptoDetailPage extends StatelessWidget {
  const CryptoDetailPage({super.key, required this.crypto});

  final Crepto crypto;

  @override
  Widget build(BuildContext context) {
    final change = crypto.priceChangePercentage24H;
    final changeColor = change >= 0 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Crypto'),
        backgroundColor: const Color.fromARGB(190, 245, 123, 221),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(crypto.image),
            ),

            const SizedBox(height: 20),

            Text(
              '${crypto.name} (${crypto.symbol.toUpperCase()})',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Text(
              '\$${crypto.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              '24h Change: '
              '${change >= 0 ? '+' : ''}'
              '${change.toStringAsFixed(2)}%',
              style: TextStyle(
                color: changeColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            Chip(label: Text('Rank #${crypto.marketCapRank}')),

            const SizedBox(height: 10),

            Text(
              'Market Cap: ${crypto.marketCap}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
