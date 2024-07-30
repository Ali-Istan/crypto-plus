import 'package:crypto_plus/Constants/colors.dart';
import 'package:crypto_plus/Model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  final List<CryptoModel> cryptoModel;

  const CoinListScreen({super.key, required this.cryptoModel});

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  late List<CryptoModel> cryptolist;

  @override
  void initState() {
    cryptolist = widget.cryptoModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.black,
        title: Text(
          "Crypto Plus",
          style: TextStyle(fontFamily: 'mr', color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: MyColors.black,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          List<CryptoModel> refresh = await _getData() ;
          setState(() {
            cryptolist = refresh;
          });
        },
        child: ListView.builder(
          itemCount: cryptolist.length,
          itemBuilder: (context, index) {
              return  _getList(cryptolist[index]);
          },
        ),
      )),
    );
  }

  Widget _getIconChangePercent(double percentChanged) {
    return percentChanged <= 0
        ? const Icon(
            Icons.trending_down,
            color: Colors.red,
          )
        : const Icon(
            Icons.trending_up,
            color: MyColors.green,
          );
  }

  Color _getColorChangeText(double percentChanged) {
    return percentChanged <= 0 ? Colors.red : MyColors.green;
  }

  Widget _getList(CryptoModel crypto) {
    return ListTile(
      leading: SizedBox(
        width: 20,
        child: Center(
          child: Text(
            crypto.rank.floor().toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  double.parse(crypto.priceUSD)
                      .toStringAsFixed(2),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  double.parse(crypto.changePercet24hr)
                      .toStringAsFixed(2),
                  style: TextStyle(
                    color: _getColorChangeText(double.parse(
                        crypto.changePercet24hr)),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30,
              child: _getIconChangePercent(
                  double.parse(crypto.changePercet24hr)),
            ),
          ],
        ),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: Colors.white),
      ),
      title: Text(
        crypto.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<List<CryptoModel>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<CryptoModel> crypto_list = response.data['data']
        .map<CryptoModel>((e) => CryptoModel.fromMapJson(e))
        .toList();

    return crypto_list;
  }
}
