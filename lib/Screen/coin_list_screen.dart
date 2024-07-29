import 'package:crypto_plus/Model/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  final List<CryptoModel> cryptoModel;

  const CoinListScreen({super.key, required this.cryptoModel});

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}



class _CoinListScreenState extends State<CoinListScreen> {
  late  List<CryptoModel> cryptolist;
  @override
  void initState() {
    cryptolist = widget.cryptoModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: cryptolist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(cryptolist[index].name),
              ),
            ),
          );
        },
      )),
    );
  }
}
